package com.example.sunnyweather.activity

import android.content.Context
import android.graphics.Color
import android.os.Bundle
import android.util.Log
import android.view.LayoutInflater
import android.view.View
import android.view.ViewGroup.MarginLayoutParams
import android.view.inputmethod.InputMethodManager
import android.widget.ImageButton
import android.widget.ImageView
import android.widget.LinearLayout
import android.widget.RelativeLayout
import android.widget.ScrollView
import android.widget.TextView
import android.widget.Toast
import androidx.appcompat.app.AppCompatActivity
import androidx.core.view.GravityCompat
import androidx.core.view.ViewCompat
import androidx.core.view.WindowInsetsCompat
import androidx.drawerlayout.widget.DrawerLayout
import androidx.lifecycle.Observer
import androidx.lifecycle.ViewModelProviders
import androidx.swiperefreshlayout.widget.SwipeRefreshLayout
import com.example.sunnyweather.R
import com.example.sunnyweather.databinding.ActivityWeatherBinding
import com.example.sunnyweather.ui.weather.WeatherViewModel
import com.sunnyweather.android.logic.model.Weather
import com.sunnyweather.android.logic.model.getSky
import java.text.SimpleDateFormat
import java.util.Locale

//请求具体城市天气信息详情页

const val url = "https://api.caiyunapp.com/v2.6/r4WWeERNjLoEZDJJ/weather.json?adcode="

class WeatherActivity : AppCompatActivity() {

    val weatherViewModel by lazy { ViewModelProviders.of(this).get(WeatherViewModel::class.java) }

    private lateinit var activityBinding: ActivityWeatherBinding

    private lateinit var swipeRefresh: SwipeRefreshLayout
    private lateinit var drawerLayout: DrawerLayout
    private lateinit var placeName: TextView
    private lateinit var currentTemp: TextView
    private lateinit var currentSky: TextView
    private lateinit var currentAQI: TextView
    private lateinit var navBtn: ImageButton
    private lateinit var forecastLayout: LinearLayout
    private lateinit var nowLayout: RelativeLayout
    private lateinit var coldRiskText: TextView
    private lateinit var dressingText: TextView
    private lateinit var ultravioletText: TextView
    private lateinit var carWashingText: TextView
    private lateinit var weatherLayout: ScrollView

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        activityBinding = ActivityWeatherBinding.inflate(layoutInflater)
        setContentView(activityBinding.root)
        initView()

//        statusBarOnly {
//            transparent()
//        }

        //原生方式实现透明状态栏
        val flag = (View.SYSTEM_UI_FLAG_LAYOUT_HIDE_NAVIGATION
                or View.SYSTEM_UI_FLAG_LAYOUT_FULLSCREEN
                or View.SYSTEM_UI_FLAG_LAYOUT_STABLE)
        window?.decorView?.systemUiVisibility = flag
        window?.statusBarColor = Color.TRANSPARENT
        window?.navigationBarColor = Color.TRANSPARENT

        // 让内容布局偏移到状态栏下
        val titleFL = activityBinding.now.titleLayout
        val placeFragment = activityBinding.placeFragmentContainer
        ViewCompat.setOnApplyWindowInsetsListener(titleFL) { _, insets ->
            val systemWindowInsets = insets.getInsets(WindowInsetsCompat.Type.statusBars())
            Log.e("系统状态栏高度", "systemWindowInsets.top=" + systemWindowInsets.top)
            val params1 = titleFL.layoutParams as MarginLayoutParams
            val params2 = placeFragment.layoutParams as MarginLayoutParams
            params1.topMargin = systemWindowInsets.top
//            params2.topMargin = systemWindowInsets.top
            insets
        }

        /*      val adcode = intent.getStringExtra("adcode")

           HttpUtils.sendRequestOkhttp(url + adcode, object : okhttp3.Callback {

               override fun onFailure(call: Call, e: IOException) {
                   showResponse(e.message.toString())
                   Log.e(GsonUtils.TAG, e.message.toString())
               }

               override fun onResponse(call: Call, response: Response) {
                   val responseData = response.body?.string()
                   showResponse(responseData ?: "")
                   GsonUtils.parseResponse(responseData ?: "")
               }
           })*/

        if (weatherViewModel.locationLng.isEmpty()) {
            weatherViewModel.locationLng = /*intent.getStringExtra("location_lng") ?:*/ "101.6656"
        }
        if (weatherViewModel.locationLat.isEmpty()) {
            weatherViewModel.locationLat = /*intent.getStringExtra("location_lat") ?:*/ "39.2072"
        }
        if (weatherViewModel.placeName.isEmpty()) {
            weatherViewModel.placeName = /*intent.getStringExtra("place_name") ?: */"广州市天河区"
        }
        weatherViewModel.weatherLiveData.observe(this, Observer { result: Result<Weather> ->
            val weather = result.getOrNull()
            if (weather != null) {
                Log.e("viewModel", "已经返回数据")
                showWeatherInfo(weather)
            } else {
                Log.e("viewModel", "没有返回数据")
                Toast.makeText(this, "无法成功获取天气信息", Toast.LENGTH_SHORT).show()
                result.exceptionOrNull()?.printStackTrace()
            }
            swipeRefresh.isRefreshing = false
        })
        swipeRefresh.setColorSchemeResources(R.color.colorPrimary)
        refreshWeather()
        swipeRefresh.setOnRefreshListener {
            refreshWeather()
        }

        navBtn.setOnClickListener {
            drawerLayout.openDrawer(GravityCompat.START)
        }
        drawerLayout.addDrawerListener(object : DrawerLayout.DrawerListener {
            override fun onDrawerStateChanged(newState: Int) {}

            override fun onDrawerSlide(drawerView: View, slideOffset: Float) {}

            override fun onDrawerOpened(drawerView: View) {}

            override fun onDrawerClosed(drawerView: View) {
                val manager = getSystemService(Context.INPUT_METHOD_SERVICE) as InputMethodManager
                manager.hideSoftInputFromWindow(
                    drawerView.windowToken,
                    InputMethodManager.HIDE_NOT_ALWAYS
                )
            }
        })
    }

    private fun showWeatherInfo(weather: Weather) {
        placeName.text = weatherViewModel.placeName
        val realtime = weather.realtime
        val daily = weather.daily
        // 填充now.xml布局中数据
        val currentTempText = "${realtime.temperature.toInt()} ℃"
        currentTemp.text = currentTempText
        currentSky.text = getSky(realtime.skycon).info
        val currentPM25Text = "空气指数 ${realtime.air_quality.aqi.chn.toInt()}"
        currentAQI.text = currentPM25Text
        nowLayout.setBackgroundResource(getSky(realtime.skycon).bg)
        // 填充forecast.xml布局中的数据
        forecastLayout.removeAllViews()
        val days = daily.skycon.size
        for (i in 0 until days) {
            val skycon = daily.skycon[i]
            val temperature = daily.temperature[i]
            val view =
                LayoutInflater.from(this).inflate(R.layout.forecast_item, forecastLayout, false)
            val dateInfo = view.findViewById(R.id.dateInfo) as TextView
            val skyIcon = view.findViewById(R.id.skyIcon) as ImageView
            val skyInfo = view.findViewById(R.id.skyInfo) as TextView
            val temperatureInfo = view.findViewById(R.id.temperatureInfo) as TextView
            val simpleDateFormat = SimpleDateFormat("yyyy-MM-dd", Locale.getDefault())
            dateInfo.text = skycon.date
            val sky = getSky(skycon.value)
            skyIcon.setImageResource(sky.icon)
            skyInfo.text = sky.info
            val tempText = "${temperature.min.toInt()} ~ ${temperature.max.toInt()} ℃"
            temperatureInfo.text = tempText
            forecastLayout.addView(view)
        }
        // 填充life_index.xml布局中的数据
        val lifeIndex = daily.life_index
        coldRiskText.text = lifeIndex.coldRisk[0].desc
        dressingText.text = lifeIndex.dressing[0].desc
        ultravioletText.text = lifeIndex.ultraviolet[0].desc
        carWashingText.text = lifeIndex.carWashing[0].desc
        weatherLayout.visibility = View.VISIBLE
    }

    fun refreshWeather() {
        weatherViewModel.refreshWeather(weatherViewModel.locationLng, weatherViewModel.locationLat)
        swipeRefresh.isRefreshing = true
    }

    fun initView() {
        swipeRefresh = activityBinding.swipeRefresh
        drawerLayout = activityBinding.drawerLayout

        placeName = activityBinding.now.placeName
        currentTemp = activityBinding.now.currentTemp
        currentSky = activityBinding.now.currentSky
        currentAQI = activityBinding.now.currentAQI
        navBtn = activityBinding.now.navBtn

        nowLayout = activityBinding.now.rlNowRoot
        weatherLayout = activityBinding.weatherLayout

        forecastLayout = activityBinding.forecast.llForecast
        coldRiskText = activityBinding.lifeIndex.tvColdRisk
        dressingText = activityBinding.lifeIndex.tvDressing
        ultravioletText = activityBinding.lifeIndex.tvUltraviolet
        carWashingText = activityBinding.lifeIndex.tvCarWashing

    }

    fun closeDrawers(){
        drawerLayout.closeDrawers()
    }

//    private fun showResponse(content: String) {
//        runOnUiThread {
//            binding.responseTv.setText(content)
//        }
//    }
}
