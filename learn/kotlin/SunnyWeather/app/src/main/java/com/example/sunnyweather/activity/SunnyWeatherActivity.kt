package com.example.sunnyweather.activity

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.ActivityMainBinding
import com.example.sunnyweather.databinding.ActivitySunnyWeatherBinding
import learn.addressHead
import learn.entity.MyResponsePlace
import learn.retrofit.ResponseService
import learn.retrofit.TimeoutInterceptor
import okhttp3.OkHttpClient
import retrofit2.Callback
import retrofit2.Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

class SunnyWeatherActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_sunny_weather)
        val binding= ActivitySunnyWeatherBinding.inflate(layoutInflater)
        setContentView(binding.root)

    }


}