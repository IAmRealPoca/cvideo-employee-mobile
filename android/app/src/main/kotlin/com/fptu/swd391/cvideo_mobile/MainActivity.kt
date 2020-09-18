package com.fptu.swd391.cvideo_mobile

import android.app.Activity
import android.content.Intent
import android.util.Log
import com.google.gson.JsonObject
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import kotlinx.coroutines.*
import org.json.JSONObject
import kotlin.coroutines.CoroutineContext


class MainActivity : FlutterActivity() {
    companion object {
        private val TAG = MainActivity::class.java.simpleName
        private const val CHANNEL = "com.fptu.swd391.cvideo_mobile/record"
        const val QUESTIONS = "QUESTIONS";
        const val LAUNCH_SECOND_ACTIVITY_CODE = 1
    }

    private var parentJob = Job()
    private val coroutineContext: CoroutineContext
        get() = parentJob + Dispatchers.Main
    private val scope = CoroutineScope(coroutineContext)

    private var videoPath: String? = null
    private var isBackPressed: Boolean = false
    private var isReturn = false


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            if (call.method == "recordVideo") {
                // Reset before recording new video
                videoPath = ""
                isReturn = false
                isBackPressed = false

                val intent = Intent(this, ArFaceActivity::class.java)
                intent.putExtra(QUESTIONS, call.arguments as String)
                startActivityForResult(intent, LAUNCH_SECOND_ACTIVITY_CODE)

                CoroutineScope(Dispatchers.Main + parentJob).launch {
                    withContext(Dispatchers.IO) {
                        while (!isReturn) {
                            delay(300)
                        }
                    }

                    val jsonResult = JSONObject()
                    jsonResult.put("isBackPressed", isBackPressed)
                    jsonResult.put("videoPath", videoPath)

                    result.success(jsonResult.toString())
                }
            } else {
                result.notImplemented()
            }
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == LAUNCH_SECOND_ACTIVITY_CODE) {
            if (resultCode == Activity.RESULT_OK) {
                // Get video path when recording is done
                videoPath = data?.getStringExtra(ArFaceActivity.ACTIVITY_RESULT)
            } else {
                // User press the back button while recording
                isBackPressed = true
            }
        }
        isReturn = true
    }

    override fun onDestroy() {
        super.onDestroy()
        Log.d(TAG, "onDestroy() was called");
        // cancel all asynchronous jobs
        scope.cancel()
    }
}
