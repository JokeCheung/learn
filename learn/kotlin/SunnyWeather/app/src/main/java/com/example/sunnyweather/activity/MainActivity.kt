package com.example.sunnyweather.activity

import android.content.Intent
import android.os.Bundle
import androidx.appcompat.app.AppCompatActivity
import com.example.sunnyweather.databinding.ActivityMainBinding
import learn.HttpActivity
import learn.WebViewActivity

const val FROM_HTTP=0;
const val FROM_OKHTTP=1;
const val FROM_RETROFIT=2;
const val FROM_RETROFIT_DESERIALIZE=3;

class MainActivity : AppCompatActivity() {

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)

        val binding=ActivityMainBinding.inflate(layoutInflater)
        setContentView(binding.root)
        binding.webViewBtn.setOnClickListener {
            startActivity(Intent(this, WebViewActivity::class.java))
        }

        binding.httpBtn.setOnClickListener {
            val intent=Intent(this, HttpActivity::class.java)
            intent.putExtra("from", FROM_HTTP)
            startActivity(intent)
        }

        binding.okhttpBtn.setOnClickListener {
            val intent=Intent(this, HttpActivity::class.java)
            intent.putExtra("from",FROM_OKHTTP)
            startActivity(intent)
        }

        binding.retrofitBtn.setOnClickListener {
            val intent=Intent(this, HttpActivity::class.java)
            intent.putExtra("from",FROM_RETROFIT)
            startActivity(intent)
        }

        binding.retrofitDeserializeBtn.setOnClickListener {
            val intent=Intent(this, HttpActivity::class.java)
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

    }
}
