package com.example.sunnyweather.activity

import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.sunnyweather.databinding.ActivitySearchBinding

class SearchActivity : AppCompatActivity() {
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
//        setContentView(R.layout.activity_sunny_weather)
        val binding= ActivitySearchBinding.inflate(layoutInflater)
        setContentView(binding.root)

    }


}