package com.example.sunnyweather.activity

import android.app.Service
import android.content.ContentValues
import android.content.Intent
import android.os.Bundle
import android.os.VibrationEffect
import android.os.Vibrator
import android.util.Log
import android.view.GestureDetector
import android.view.MotionEvent
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import com.example.sunnyweather.databinding.ActivityMainBinding
import com.example.sunnyweather.logic.model.Location
import com.example.sunnyweather.logic.model.Place
import com.google.gson.Gson
import learn.HttpActivity
import learn.VibrateActivity
import learn.WebViewActivity
import learn.db.MyDataBaseHelper


const val FROM_HTTP = 0;
const val FROM_OKHTTP = 1;
const val FROM_RETROFIT = 2;
const val FROM_RETROFIT_DESERIALIZE = 3;
const val FROM_SUNNY_WEATHER = 4;

class MainActivity : AppCompatActivity() {



    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val binding = ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)


        val dbHelper = MyDataBaseHelper(this, "BookStore.db", 2)
        binding.createDBBtn.setOnClickListener {
            dbHelper.writableDatabase
        }

        binding.testBtn.setOnClickListener {
//            startActivity(Intent(this, WeatherActivity::class.java))
        }

        binding.addBtn.setOnClickListener {
            val db = dbHelper.writableDatabase
            val value1 = ContentValues().apply {
                put("name", "The Da Vinci Code")
                put("author", "Dan Brown")
                put("pages", 454)
                put("price", 16.96)
            }
            db.insert("Book", null, value1)
            val value2 = ContentValues().apply {
                put("name", "The Lost Symbol")
                put("author", "Dan Brown")
                put("pages", 510)
                put("price", 19.95)
            }
            db.insert("Book", null, value2)
        }

        binding.vibrateBtn.setOnClickListener {
            startActivity(Intent(this, VibrateActivity::class.java))
            intent.putExtra("from", FROM_SUNNY_WEATHER)
            startActivity(intent)
        }

        binding.sunnyWeatherBtn.setOnClickListener {
            startActivity(Intent(this, WeatherActivity::class.java))
            intent.putExtra("from", FROM_SUNNY_WEATHER)
            startActivity(intent)
        }

        binding.webViewBtn.setOnClickListener {
            startActivity(Intent(this, WebViewActivity::class.java))
        }

        binding.httpBtn.setOnClickListener {
            val intent = Intent(this, HttpActivity::class.java)
            intent.putExtra("from", FROM_HTTP)
            startActivity(intent)
        }

        binding.okhttpBtn.setOnClickListener {
            val intent = Intent(this, HttpActivity::class.java)
            intent.putExtra("from", FROM_OKHTTP)
            startActivity(intent)
        }

        binding.retrofitBtn.setOnClickListener {
            val intent = Intent(this, HttpActivity::class.java)
            intent.putExtra("from", FROM_RETROFIT)
            startActivity(intent)
        }

        binding.retrofitDeserializeBtn.setOnClickListener {
            val intent = Intent(this, HttpActivity::class.java)
            intent.putExtra("from", FROM_RETROFIT_DESERIALIZE)
            startActivity(intent)
        }

//findById写法
//        setContentView(R.layout.activity_main)
//        val webViewBtn=findViewById<Button>(R.id.webView_btn);
//        webViewBtn.setOnClickListener {
//            startActivity(Intent(this, WebViewActivity::class.java))
//        };

//Java匿名内部类写法：
//        webViewBtn.setOnClickListener(new View.OnClickListener {
//            startActivity(Intent(this,WebViewActivity.class));
//        });
//Java Lambda写法：
//        webViewBtn.setOnClickListener(v -> {
//            startActivity(new Intent(this, WebViewActivity.class));
//        });

        val gson: Gson = Gson()
        val json = """
        {
            "adcode": "123456",
            "formatted_address": "beijing",
            "lng": "120.123",
            "lat": "30.123"
        }
    """
//        val typeOf=object :TypeToken<Place>(){}.type
        val place = gson.fromJson(json, Place::class.java)
        val aa = gson.toJson(Place("1", "2", Location("3", "4")))
        Log.e("LocationAdapter", aa)
//        runOnUiThread {
//            Toast.makeText(this,aa.toString(),Toast.LENGTH_SHORT).show()
//        }
    }


}
