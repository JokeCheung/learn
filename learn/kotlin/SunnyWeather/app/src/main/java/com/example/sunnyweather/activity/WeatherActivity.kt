package com.example.sunnyweather.activity

import android.os.Bundle
import android.util.Log
import android.widget.TextView
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.ActivitySearchBinding
import com.example.sunnyweather.databinding.ActivityWeatherBinding
import com.example.sunnyweather.databinding.PlaceItemBinding
import learn.GsonUtils
import learn.HttpUtils
import learn.place
import okhttp3.Call
import okhttp3.Response
import java.io.IOException

//请求具体城市天气信息详情页

const val url = "https://api.caiyunapp.com/v2.6/r4WWeERNjLoEZDJJ/weather.json?adcode="

class WeatherActivity : AppCompatActivity() {


    private lateinit var binding: ActivityWeatherBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityWeatherBinding.inflate(layoutInflater)
        setContentView(binding.root)
        val adcode = intent.getStringExtra("adcode")

        HttpUtils.sendRequestOkhttp(url + adcode, object : okhttp3.Callback {

            override fun onFailure(call: Call, e: IOException) {
                showResponse(e.message.toString())
                Log.e(GsonUtils.TAG, e.message.toString())
            }

            override fun onResponse(call: Call, response: Response) {
                val responseData = response.body?.string()
                showResponse(responseData ?: "")
//                GsonUtils.parseResponse(responseData ?: "")
            }
        })
    }

    private fun showResponse(content: String) {
        runOnUiThread {
            binding.responseTv.setText(content)
        }
    }
}