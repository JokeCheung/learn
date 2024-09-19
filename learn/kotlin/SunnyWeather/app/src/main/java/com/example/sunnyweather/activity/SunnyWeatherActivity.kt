package com.example.sunnyweather.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.ActivityMainBinding
import com.example.sunnyweather.databinding.ActivitySunnyWeatherBinding

class SunnyWeatherActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_sunny_weather)
        val binding= ActivitySunnyWeatherBinding.inflate(layoutInflater)
        setContentView(binding.root)
    }
}