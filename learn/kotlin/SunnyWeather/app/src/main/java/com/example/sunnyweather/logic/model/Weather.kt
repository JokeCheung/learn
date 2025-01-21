package com.sunnyweather.android.logic.model

import com.example.sunnyweather.logic.model.DailyResponse
import com.example.sunnyweather.logic.model.RealtimeResponse

class Weather(val realtime: RealtimeResponse.Realtime, val daily: DailyResponse.Daily)