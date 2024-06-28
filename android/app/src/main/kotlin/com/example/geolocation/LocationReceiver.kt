package com.example.geolocation

import android.content.BroadcastReceiver
import android.content.Context
import android.content.Intent
import android.location.LocationManager
import android.util.Log
import android.widget.Toast

class LocationReceiver: BroadcastReceiver() {
    override fun onReceive(context: Context?, intent: Intent?) {
        Log.d("LocationReceiver", intent?.action.toString())
        val sharedPreferencesHelper = context?.let { SharedPreferencesHelper(context= it) }
//        if (intent?.action == LocationManager.PROVIDERS_CHANGED_ACTION) {
//            val locationManager = context?.getSystemService(Context.LOCATION_SERVICE) as LocationManager
//            val isGpsEnabled = locationManager.isProviderEnabled(LocationManager.GPS_PROVIDER)
//            val isNetworkEnabled = locationManager.isProviderEnabled(LocationManager.NETWORK_PROVIDER)
//
//            if (isGpsEnabled || isNetworkEnabled) {
//                Log.d("LocationSettingsChanged", "Location services enabled");
//                    val serviceIntent = Intent(context, LocationTrackingService::class.java)
//                    context.startForegroundService(serviceIntent)
//
//            } else {
//                Log.d("LocationSettingsChanged", "Location services disabled")
//                // Optionally, stop the location tracking service
//                val serviceIntent = Intent(context, LocationTrackingService::class.java)
//                context.startService(serviceIntent)
//            }
//        }
        if (intent?.action == Intent.ACTION_BOOT_COMPLETED) {
            Log.d("LocationReceiver", "Boot completed")
            // Restart the service on device boot
            if(sharedPreferencesHelper?.getCheckedIn() == true) {
                val serviceIntent = Intent(context, LocationTrackingService::class.java)
                context.startForegroundService(serviceIntent)
            }

        }
    }
}