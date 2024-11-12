package com.example.sunnyweather.logic.network

import android.util.Log
import com.example.sunnyweather.SunnyWeatherApplication
import com.example.sunnyweather.logic.model.Place
import com.example.sunnyweather.logic.model.PlaceResponse
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Query

interface PlaceService {

//    @GET("v2.6/${SunnyWeatherApplication.TOKEN}/weather.json?adcode=440106")
//    fun searchPlaces(@Query("query") query:String): Call<PlaceResponse>

    @GET("/place/find")
    fun searchPlaces(@Query("placeName") placeName:String): Call<PlaceResponse>

    @GET("/place/all")
    fun allPlace(): Call<PlaceResponse>

}