package com.fptu.swd391.cvideo_mobile

import android.app.Activity
import android.app.ActivityManager
import android.content.Context
import android.content.Intent
import android.media.CamcorderProfile
import android.os.Bundle
import android.os.CountDownTimer
import android.util.Log
import android.view.Gravity
import android.view.View
import android.widget.ProgressBar
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.google.android.material.floatingactionbutton.FloatingActionButton
import com.google.ar.core.ArCoreApk
import com.google.ar.core.AugmentedFace
import com.google.ar.core.TrackingState
import com.google.ar.sceneform.Node
import com.google.ar.sceneform.math.Vector3
import com.google.ar.sceneform.rendering.ModelRenderable
import com.google.ar.sceneform.rendering.Renderable
import com.google.ar.sceneform.rendering.Texture
import com.google.ar.sceneform.rendering.ViewRenderable
import com.google.ar.sceneform.ux.AugmentedFaceNode
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import kotlinx.coroutines.*

class ArFaceActivity : AppCompatActivity(), ModelLoader.ModelLoaderCallbacks {

    companion object {
        private val TAG = ArFaceActivity::class.java.simpleName
        private const val MIN_OPENGL_VERSION = 3.0

        const val ACTIVITY_RESULT = "activity_result";
    }

    private lateinit var arFragment: FaceArFragment
    private lateinit var faceRegionsRenderable: ModelRenderable
    private lateinit var faceMeshTexture: Texture
    private val faceNodeMap = HashMap<AugmentedFace, AugmentedFaceNode>()

    private lateinit var modelLoader: ModelLoader

    private lateinit var questionBoardNode: Node
    private lateinit var questionBoarView: QuestionBoard

    // VideoRecorder encapsulates all the video recording functionality.
    private lateinit var videoRecorder: VideoRecorder

    private lateinit var videoPath: String

    private var startPrepareTimer: CountDownTimer? = null
    private var questionCountDownTimer: CountDownTimer? = null

    // Job for coroutines
    private val job = Job()

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)


        if (!checkIsSupportedDeviceOrFinish(this)) {
            Log.e(TAG, "No Permission")
            return
        }

        setContentView(R.layout.activity_ar_face)

        /// Receive intent from MainActivity
        val intent = intent
        /// Get extra data from this intent
        val jsonQuestions = intent.getStringExtra(MainActivity.QUESTIONS) as String

        /// Parse json to list of Question
        val questions: List<Question> = Gson().fromJson<List<Question>>(jsonQuestions, object : TypeToken<List<Question>>() {}.type)

        /// Get FaceArFragment
        arFragment = supportFragmentManager.findFragmentById(R.id.face_fragment) as FaceArFragment

        // Initialize question board view
        questionBoarView = QuestionBoard(this)

        // Initialize the VideoRecorder
        videoRecorder = VideoRecorder()
        val orientation = resources.configuration.orientation
        videoRecorder.setVideoQuality(CamcorderProfile.QUALITY_720P, orientation);
        videoRecorder.sceneView = arFragment.arSceneView

        // Get reference to txtCountdown
        val textCountDown = findViewById<TextView>(R.id.txtCountDown);
        // Get reference to textQuestion
        val txtQuestion: TextView = questionBoarView.findViewById(R.id.txtQuestion)
        val progressBar: ProgressBar = questionBoarView.findViewById(R.id.progressBar)


        /// Countdown timer for 5s
        startPrepareTimer = object : CountDownTimer(5000, 1000) {
            override fun onTick(millisUtilFinished: Long) {
                textCountDown.text = (millisUtilFinished / 1000).toString()
            }

            /// When finish count down, start showing questions
            override fun onFinish() {
                textCountDown.text = ""
                textCountDown.visibility = View.GONE

                /// start recording
                startRecording()

                // Show first question
                txtQuestion.text = questions[0].questionContent
                progressBar.progress = 100

                CoroutineScope(Dispatchers.Main + job).launch {
                    var questionIndex = 0

                    repeat(questions.size) {
                        /// Set countdown progress bar for each question
                        progressBar.max = questions[questionIndex].questionTime * 1000
                        questionCountDownTimer = object : CountDownTimer(questions[questionIndex].questionTime.toLong() * 1000, 10) {
                            override fun onFinish() {}

                            override fun onTick(millisUntilDone: Long) {
                                progressBar.progress = millisUntilDone.toInt()
                            }
                        }.start()

                        withContext(Dispatchers.IO) {
                            delay((questions[questionIndex].questionTime * 1000).toLong())
                        }

                        questionIndex++;
                        if (questionIndex < questions.size) {
                            txtQuestion.text = questions[questionIndex].questionContent
                        } else if (questionIndex >= questions.size) {
                            // Finish recording after run of out questions
                            stopRecording()

                            // Return data to main activity
                            val intentForResult = Intent()
                            intentForResult.putExtra(ACTIVITY_RESULT, videoPath)
                            setResult(Activity.RESULT_OK, intentForResult)
                            finish()
                        }
                    }
                }
            }
        }.start()

        modelLoader = ModelLoader(this)

        // Load fox face
        modelLoader.loadModel(this, R.raw.fox_face)
        // Load the face mesh texture.
        modelLoader.loadTexture(this, R.drawable.fox_face_mesh_texture)

        modelLoader.loadViewModel(this, questionBoarView)

        val sceneView = arFragment.arSceneView;

        // This is important to make sure that the camera stream renders first so that
        // the face mesh occlusion works correctly.
        sceneView.cameraStreamRenderPriority = Renderable.RENDER_PRIORITY_FIRST

        val scene = sceneView.scene

        scene.addOnUpdateListener {
            run {
                // Make new AugmentedFaceNodes for any new faces.
                sceneView.session?.getAllTrackables(AugmentedFace::class.java)?.forEach {
                    if (!faceNodeMap.containsKey(it)) {
                        val faceNode = AugmentedFaceNode(it)
                        faceNode.setParent(scene)

                        faceNode.faceRegionsRenderable = faceRegionsRenderable
                        faceNode.faceMeshTexture = faceMeshTexture
                        questionBoardNode.setParent(faceNode)

                        faceNodeMap[it] = faceNode
                    }
                }

                // Remove any AugmentedFaceNodes associated with an AugmentedFace that stopped tracking.
                val iter: MutableIterator<Map.Entry<AugmentedFace, AugmentedFaceNode>> = faceNodeMap.entries.iterator()
                while (iter.hasNext()) {
                    val entry = iter.next()
                    val face = entry.key
                    val faceNode = entry.value

                    if (face.trackingState == TrackingState.PAUSED || face.trackingState == TrackingState.STOPPED) {
                        faceNode.setParent(null)
                        iter.remove()
                    }
                }
            }
        }

    }


    /**
     * Returns false and displays an error message if Sceneform can not run, true if Sceneform can run
     * on this device.
     *
     * <p>Sceneform requires Android N on the device as well as OpenGL 3.0 capabilities.
     *
     * <p>Finishes the activity if Sceneform can not run
     */
    private fun checkIsSupportedDeviceOrFinish(activity: Activity): Boolean {
        if (ArCoreApk.getInstance()
                        .checkAvailability(activity) == ArCoreApk.Availability.UNSUPPORTED_DEVICE_NOT_CAPABLE
        ) {
            Log.e(TAG, "Augmented Faces requires ARCore.")
            Toast.makeText(activity, "Augmented Faces requires ARCore", Toast.LENGTH_LONG).show()
            activity.finish();
            return false
        }

        val openGlVersionString =
                (activity.getSystemService(Context.ACTIVITY_SERVICE) as ActivityManager)
                        .deviceConfigurationInfo
                        .glEsVersion

        if (openGlVersionString.toDouble() < MIN_OPENGL_VERSION) {
            Log.e(TAG, "Sceneform requires OpenGL ES 3.0 later")
            Toast.makeText(activity, "Sceneform requires OpenGL ES 3.0 or later", Toast.LENGTH_LONG)
                    .show()

            activity.finish()
            return false;
        }
        return true
    }

    /**
     * Start recording video
     */
    private fun startRecording() {
        if (!arFragment.hasWritePermission()) {
            Log.e(TAG, "Video recording requires the WRITE_EXTERNAL_STORAGE permission")
            Toast.makeText(
                    this,
                    "Video recording requires the WRITE_EXTERNAL_STORAGE permission",
                    Toast.LENGTH_LONG
            ).show()

            arFragment.launchPermissionSettings()
            return
        }

        if (!arFragment.hasRecordAudioPermission()) {
            Log.e(TAG, "Video recording requires the RECORD_AUDIO permission")
            Toast.makeText(
                    this,
                    "Video recording requires the RECORD_AUDIO permission",
                    Toast.LENGTH_LONG
            ).show();
            arFragment.launchPermissionSettings();
            return;
        }

        // val recording = videoRecorder.onToggleRecord();
        videoRecorder.startRecordingVideo()
    }

    /**
     * Stop recording when run of questions
     */
    private fun stopRecording() {
        videoRecorder.stopRecordingVideo()

        // Set video path after finish recording
        videoPath = videoRecorder.videoPath.absolutePath
        Toast.makeText(this, "Saved video: $videoPath", Toast.LENGTH_LONG).show()
        Log.d(TAG, "Saved video: $videoPath")
    }

    /**
     * Show AR model on screen
     */
    override fun setModelRenderable(modelRenderable: ModelRenderable) {
        faceRegionsRenderable = modelRenderable
        modelRenderable.isShadowCaster = false
        modelRenderable.isShadowReceiver = false
    }

    /**
     * Show texture on screen
     */
    override fun setTexture(texture: Texture) {
        faceMeshTexture = texture
    }

    // Show Question board on screen
    override fun setViewRenderable(viewRenderable: ViewRenderable) {
        questionBoardNode = Node()
        val position = Vector3()
        position.set(0.0f, 0.3f, -0.4f)
        questionBoardNode.localPosition = position
        questionBoardNode.renderable = viewRenderable
    }

    override fun onBackPressed() {
        super.onBackPressed()
        Log.d(TAG, "onBackPressed() was called!")
        questionCountDownTimer?.cancel()
        startPrepareTimer?.cancel()
    }

    /**
     * Show load exception
     */
    override fun onLoadException(throwable: Throwable) {
        val toast = Toast.makeText(this, throwable.localizedMessage, Toast.LENGTH_LONG)
        toast.setGravity(Gravity.CENTER, 0, 0)
        toast.show()
        return;
    }

    /**
     * Remove any resources
     */
    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy() is called!")
        questionCountDownTimer?.cancel()
        startPrepareTimer?.cancel()

        if (videoRecorder.isRecording()) {
            /// Cancel the coroutines jobs
            job.cancel()

            videoRecorder.stopRecordingVideo()
        }
    }
}