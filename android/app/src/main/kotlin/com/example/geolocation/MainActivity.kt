package com.example.geolocation

import android.content.Intent
import android.os.Build
import androidx.annotation.NonNull
import androidx.annotation.RequiresApi
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {


    private val channel = "tracking_service"


    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(
            flutterEngine.dartExecutor.binaryMessenger,
            channel
        ).setMethodCallHandler { call, result ->
            when (call.method) {
                "startTracking" -> {
                    val token: String? = call.argument("token")
                    val url: String? = call.argument("url")
                    print(token)
                    startTrackingService(token!!,url!!)
                    result.success(null)
                }
                "stopTracking" -> {
                    // stopTrackingService()
                    stopTrackingService()
                    result.success(null)
                }
                else -> {
                    result.notImplemented()
                }
            }
        }
    }


    @RequiresApi(Build.VERSION_CODES.O)
    private fun startTrackingService(token: String, url:String) {

        val intent = Intent(this, LocationTrackingService::class.java)
        print(token)
        intent.putExtra("token", token)
        intent.putExtra("url", url)
        startForegroundService(intent)

    }

    private fun stopTrackingService() {
        val intent = Intent(this, LocationTrackingService::class.java)
        stopService(intent)
    }

}