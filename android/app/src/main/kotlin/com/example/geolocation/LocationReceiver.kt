package com.example.geolocation

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.util.Log

class LocationReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        if (intent?.action == Intent.ACTION_BOOT_COMPLETED) {
            Log.d("BootCompletedReceiver", "Boot completed, starting service...")
            val serviceIntent = Intent(context, LocationTrackingService::class.java)
            context?.startForegroundService(serviceIntent)
        }
    }
}