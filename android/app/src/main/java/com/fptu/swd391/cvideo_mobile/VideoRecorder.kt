package com.fptu.swd391.cvideo_mobile

import android.content.Context
import android.content.res.Configuration
import android.media.CamcorderProfile
import android.media.MediaRecorder
import android.os.Environment
import android.util.Log
import android.util.Size
import android.view.Surface
import com.google.ar.sceneform.SceneView
import java.io.File
import java.io.IOException
import java.lang.Long

class VideoRecorder() {
    companion object {
        private const val TAG = "VideoRecorder"
        private const val DEFAULT_BITRATE = 2000000
        private const val DEFAULT_FRAMERATE = 20

        private val FALLBACK_QUALITY_LEVELS = arrayOf(
                CamcorderProfile.QUALITY_HIGH,
                CamcorderProfile.QUALITY_2160P,
                CamcorderProfile.QUALITY_1080P,
                CamcorderProfile.QUALITY_720P,
                CamcorderProfile.QUALITY_480P
        )
    }

    var sceneView: SceneView? = null
    private var encoderSurface: Surface? = null
    private var mediaRecorder: MediaRecorder? = null
    private var videoCodec: Int = 0
    private var audioCodec: Int = 0
    private var bitRate: Int = DEFAULT_BITRATE
    private var frameRate: Int = DEFAULT_FRAMERATE
    private lateinit var videoDirectory: File
    private lateinit var videoBaseName: String
    private lateinit var videoSize: Size
    lateinit var videoPath: File
        private set
    private var recordingVideoFlag: Boolean = false

    /**
     * Build filename of the video
     */
    private fun buildFilename() {
        // Get directory to store video
        videoDirectory = File(
                Environment.getExternalStoragePublicDirectory(
                        Environment.DIRECTORY_PICTURES
                ).toString() + "/cvideo_directory"
        )

        // Create video basename
        videoBaseName = "cvideo_base_name_"

        // Create the full path of the recording video
        videoPath = File(
                videoDirectory,
                videoBaseName + Long.toHexString(System.currentTimeMillis()) + ".mp4"
        )

        // Create the directory if the have not created.
        val dir = videoPath.parentFile
        if (!dir!!.exists()) {
            dir.mkdir()
        }
    }

    /**
     * Set up the MediaRecorder before recording
     */
    private fun setUpMediaRecorder() {
        mediaRecorder?.setVideoSource(MediaRecorder.VideoSource.SURFACE)
        mediaRecorder?.setAudioSource(MediaRecorder.AudioSource.VOICE_RECOGNITION)
        mediaRecorder?.setOutputFormat(MediaRecorder.OutputFormat.MPEG_4)
        mediaRecorder?.setOutputFile(videoPath.absolutePath)
        mediaRecorder?.setVideoEncodingBitRate(bitRate)
        mediaRecorder?.setVideoFrameRate(frameRate)
        mediaRecorder?.setVideoSize(videoSize.width, videoSize.height)
        mediaRecorder?.setVideoEncoder(videoCodec)
        mediaRecorder?.setAudioEncoder(audioCodec)

        // Prepare to record video
        mediaRecorder?.prepare()

        // Start recording after setup and prepare
        try {
            mediaRecorder?.start()
        } catch (e: IllegalStateException) {
            Log.e(TAG, "Exception starting capture: ${e.message}", e)
        }
    }

    /**
     * Start recording video
     * - Build filename before recording
     * - Setup MediaRecorder before recording
     */
    fun startRecordingVideo() {
        // Initialize if [mediaRecorder] null
        mediaRecorder = mediaRecorder ?: MediaRecorder()
        try {
            buildFilename()
            setUpMediaRecorder()
        } catch (e: IOException) {
            Log.e(TAG, "Exception setting up recorder", e)
            return
        }

        // Set up Surface for the MediaRecorder
        encoderSurface = mediaRecorder!!.surface
        sceneView!!.startMirroringToSurface(encoderSurface, 0, 0, videoSize.width, videoSize.height)

        // Set flag to true while recording
        recordingVideoFlag = true
    }

    /**
     * Stop recording video
     */
    fun stopRecordingVideo() {
        // Set flag to false when stop recording video
        recordingVideoFlag = false

        if (encoderSurface != null) {
            sceneView!!.stopMirroringToSurface(encoderSurface)
            encoderSurface = null
        }

        // Stop recording
        mediaRecorder?.stop()
        mediaRecorder?.reset()
    }

    /**
     * Set the video size
     */
    private fun setVideoSize(width: Int, height: Int) {
        videoSize = Size(width, height)
    }

    /**
     * Set video quality
     */
    fun setVideoQuality(quality: Int, orientation: Int) {
        //  Predefined camcorder profile settings for camcorder applications.
        var profile: CamcorderProfile? = null

        // Get video's quality
        if (CamcorderProfile.hasProfile(quality)) {
            profile = CamcorderProfile.get(quality)
        }

        // Select a quality  that is available on this device.
        if (profile == null) {
            FALLBACK_QUALITY_LEVELS.forEach loop@{
                if (CamcorderProfile.hasProfile(it)) {
                    profile = CamcorderProfile.get(it)
                    return@loop
                }
            }
        }

        // Set size of video
        if (orientation == Configuration.ORIENTATION_LANDSCAPE) {
            setVideoSize(profile!!.videoFrameWidth, profile!!.videoFrameHeight)
        } else {
            setVideoSize(profile!!.videoFrameHeight, profile!!.videoFrameWidth)
        }

//        videoCodec = profile!!.videoCodec
//        audioCodec = profile!!.audioCodec
//        bitRate = profile!!.videoBitRate
//        frameRate = profile!!.videoFrameRate

        videoCodec = MediaRecorder.VideoEncoder.H264
        audioCodec = MediaRecorder.AudioEncoder.DEFAULT
        bitRate = DEFAULT_BITRATE
        frameRate = DEFAULT_FRAMERATE
    }

    fun isRecording(): Boolean {
        return recordingVideoFlag
    }
}