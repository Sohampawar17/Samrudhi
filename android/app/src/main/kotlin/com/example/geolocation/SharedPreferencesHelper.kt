package com.example.geolocation

import android.content.Context
import android.content.SharedPreferences

class SharedPreferencesHelper(context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    companion object {
        private const val PREFS_NAME = "geolocation.prefs"
        private const val KEY_TOKEN = "token"
        private const val KEY_URL = "url"
        private const val CHECKED_IN = "checked_in"
        private const val SERVICE_RUNNING = "service_running"
    }

    fun saveToken(token: String) {
        prefs.edit().putString(KEY_TOKEN, token).apply()
    }

    fun saveUrl(url: String) {
        prefs.edit().putString(KEY_URL, url).apply()
    }

    fun saveCheckedIn(checkIn: Boolean) {
        prefs.edit().putBoolean(CHECKED_IN, checkIn).apply()
    }


    fun setServiceRunning(isServiceRunning: Boolean) {
        prefs.edit().putBoolean(SERVICE_RUNNING, isServiceRunning).apply()
    }

    fun getServiceRunning():Boolean {
        return prefs.getBoolean(SERVICE_RUNNING, false)
    }


    fun getToken(): String? {
        return prefs.getString(KEY_TOKEN, "")
    }

    fun getUrl(): String? {
        return prefs.getString(KEY_URL, "")
    }

    fun getCheckedIn(): Boolean {
        return prefs.getBoolean(CHECKED_IN, false)
    }

    fun clearPreferences() {
        prefs.edit().clear().apply()
    }


}