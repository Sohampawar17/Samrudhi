package com.example.geolocation

import android.content.Context
import android.content.Intent
import android.net.ConnectivityManager
import android.net.Network
import android.net.NetworkCapabilities
import android.net.NetworkRequest
import android.util.Log
import android.widget.Toast

class NetworkMonitor(context: Context) {

    private val connectivityManager =
        context.getSystemService(Context.CONNECTIVITY_SERVICE) as ConnectivityManager

    private val networkCallback = object : ConnectivityManager.NetworkCallback() {
        override fun onAvailable(network: Network) {
            Log.d("NetworkMonitor", "Network Available")
            if (Utility.isInternetConnected(context)) {
                super.onAvailable(network)
                (context as LocationTrackingService).uploadSavedLocations()
            }
        }

        override fun onLost(network: Network) {
            super.onLost(network)
            (context as LocationTrackingService).createNotification()
            Log.d("NetworkMonitor", "Network lost")
            // Handle network lost
        }
    }

    fun registerNetworkCallback() {
        val networkRequest = NetworkRequest.Builder()
            .addCapability(NetworkCapabilities.NET_CAPABILITY_INTERNET)
            .build()
        connectivityManager.registerNetworkCallback(networkRequest, networkCallback)
    }

    fun unregisterNetworkCallback() {
        connectivityManager.unregisterNetworkCallback(networkCallback)
    }
}