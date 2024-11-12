package com.example.sunnyweather.logic.model

import androidx.core.location.LocationRequestCompat.Quality

data class RealtimeResponse(val status: String, val result: Result) {
    data class Result(val realtime: Realtime)
    data class Realtime(
        val skycon: String, val temperature: Float,
        val airQuality: AirQuality
    )

    data class AirQuality(val aqi: AQI)

    data class AQI(val chn: Float)
}