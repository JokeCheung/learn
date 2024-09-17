package learn

import android.annotation.SuppressLint
import android.os.Bundle
import android.webkit.WebViewClient
import androidx.appcompat.app.AppCompatActivity
import com.example.sunnyweather.databinding.ActivityWebBinding


class WebViewActivity : AppCompatActivity() {
    @SuppressLint("SetJavaScriptEnabled")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        val binding= ActivityWebBinding.inflate(layoutInflater)
        setContentView(binding.root)

        val webView=binding.webView
        webView.settings.javaScriptEnabled=true
        webView.webViewClient= WebViewClient()
        webView.loadUrl("https://www.baidu.com")
    }
}
