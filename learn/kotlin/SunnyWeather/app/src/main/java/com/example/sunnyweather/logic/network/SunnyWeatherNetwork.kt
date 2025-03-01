package com.example.sunnyweather.logic.network

import com.example.sunnyweather.logic.model.Place
import retrofit2.Call
import retrofit2.Callback
import retrofit2.Response
import retrofit2.await
import retrofit2.http.Query
import kotlin.coroutines.resume
import kotlin.coroutines.resumeWithException
import kotlin.coroutines.suspendCoroutine

object SunnyWeatherNetwork {
    private val localPlaceService = ServiceCreator.createLocal(PlaceService::class.java)
    private val placeService = ServiceCreator.create(PlaceService::class.java)
    private val weatherService = ServiceCreator.create(WeatherService::class.java)

    //searchPlaces获得一个Call对象
    suspend fun searchLocalPlaces(query: String) = localPlaceService.searchPlaces(query).await()

    //searchPlaces获得一个Call对象
    suspend fun searchPlaces(query: String) = placeService.searchPlaces(query).await()

    //searchPlaces获得一个Call对象
    suspend fun allPlaces() = placeService.allPlace().await()

    //获取城市未来几天数据
    suspend fun getDailyWeather(lng: String, lat: String) =
        weatherService.getDailyWeather(lng, lat).await()

    //获取城市实时天气数据
    suspend fun getRealtimeWeather(lng: String, lat: String) =
        weatherService.getRealtimeWeather(lng, lat).await()


    //Call接口的扩展函数await 这个函数又是一个挂起函数
    private suspend fun <T> Call<T>.await(): T {
        //suspendCoroutine挂起函数可继承外层协程作用域，立即挂起当前协程，continuation内置对象可恢复挂起的协程
        return suspendCoroutine { continuation ->
            enqueue(object : Callback<T> {
                override fun onResponse(call: Call<T>, response: Response<T>) {
                    val body = response.body()
                    if (body != null) continuation.resume(body)
                    else continuation.resumeWithException(RuntimeException("response body is null"))
                }

                override fun onFailure(call: Call<T>, t: Throwable) {
                    continuation.resumeWithException(t)
                }
            }

            )
        }
    }
}