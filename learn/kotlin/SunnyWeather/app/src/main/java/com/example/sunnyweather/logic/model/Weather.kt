package com.example.sunnyweather.logic.model

data class Weather(
    val realtime: RealtimeResponse.Realtime,
    val dailyResponse: DailyResponse.Daily
) {

}