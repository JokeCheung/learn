package com.example.sunnyweather

import android.annotation.SuppressLint
import android.app.Application
import android.content.Context
import android.media.session.MediaSession.Token

class SunnyWeatherApplication : Application() {


    companion object {
        //消除静态Context泄露警告
        @SuppressLint("StaticFieldLeak")
        lateinit var context: Context

        //API token
        const val TOKEN="r4WWeERNjLoEZDJJ";
    }

    override fun onCreate() {
        super.onCreate()
        context = applicationContext
    }
}