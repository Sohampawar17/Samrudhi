package com.example.geolocation

import android.content.Context
import android.content.SharedPreferences

class SharedPreferencesHelper(context: Context) {

    private val prefs: SharedPreferences = context.getSharedPreferences(PREFS_NAME, Context.MODE_PRIVATE)

    companion object {
        private const val PREFS_NAME = "geolocation.prefs"
        private const val KEY_TOKEN = "token"
        private const val KEY_URL = "url"
    }

    fun saveToken(token: String) {
        prefs.edit().putString(KEY_TOKEN, token).apply()
    }

    fun saveUrl(url: String) {
        prefs.edit().putString(KEY_URL, url).apply()
    }

    fun getToken(): String? {
        return prefs.getString(KEY_TOKEN, "")
    }

    fun getUrl(): String? {
        return prefs.getString(KEY_URL, "")
    }

    fun clearPreferences() {
        prefs.edit().clear().apply()
    }


}