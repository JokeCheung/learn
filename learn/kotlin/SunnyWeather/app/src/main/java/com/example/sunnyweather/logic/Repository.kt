package com.example.sunnyweather.logic

import android.util.Log
import androidx.lifecycle.liveData

import com.example.sunnyweather.logic.network.SunnyWeatherNetwork
import com.sunnyweather.android.logic.model.Weather
import kotlinx.coroutines.Dispatchers
import kotlinx.coroutines.async
import kotlinx.coroutines.coroutineScope
import retrofit2.http.Query

object Repository {

    //获取某个地区天气信息
    fun refreshWeather(lng: String, lat: String) = liveData(Dispatchers.IO) {
        val result = try {
            coroutineScope {
                val deferredRealtime = async {
                    Log.e("测试1","getRealtimeWeather lng=$lng lat=$lat")
                    SunnyWeatherNetwork.getRealtimeWeather(lng, lat)
                }
                val deferredDaily = async {
                    Log.e("测试2","getDailyWeather lng=$lng lat=$lat")
                    SunnyWeatherNetwork.getDailyWeather(lng, lat)
                }

                val realtimeResponse = deferredRealtime.await()
                val dailyResponse = deferredDaily.await()
                Log.e("测试","realtimeResponse.status=${realtimeResponse.status}")
                Log.e("测试","dailyResponse.status=${dailyResponse.status}")
                if (realtimeResponse.status == "ok" && dailyResponse.status == "ok") {
                    Log.e("测试","返回成功")
                    val weather = Weather(realtimeResponse.result.realtime, dailyResponse.result.daily)
                    Result.success(weather)
                }else{
                    Log.e("测试","返回失败")
                    Result.failure(
                        RuntimeException(
                            "realtime response status is ${realtimeResponse.status}"+
                                    "daily response status is ${dailyResponse.status}"
                        )
                    )
                }
            }
        } catch (e: Exception) {
            Log.d("refreshWeather", "Exception:${e.printStackTrace()}")
            Result.failure<Weather>(e)
        }
        emit(result)
    }

    //搜索城市名
    fun searchLocalPlace(query: String) = liveData(Dispatchers.IO) {
        val result = try {
            val placeResponse = SunnyWeatherNetwork.searchLocalPlaces(query)
            if (placeResponse.code == "0") {
                Log.e("PlaceFragment", "OK")
                val places = placeResponse.data
                Log.e("PlaceFragment", "size=${placeResponse.data.size}")
                Result.success(places)
            } else {
                Log.e("PlaceFragment", "failure response status is ${placeResponse.code}")
                Result.failure(RuntimeException("response status is ${placeResponse.code}"))
            }
        } catch (e: Exception) {
            Log.d("PlaceFragment", "Exception:${e.printStackTrace()}")
            Result.failure(e)
        }
        emit(result)
    }

    //搜索某个地区信息
    fun searchPlace(query: String) = liveData(Dispatchers.IO) {
        val result = try {
            val placeResponse = SunnyWeatherNetwork.searchPlaces(query)
            if (placeResponse.code == "0") {
                Log.e("PlaceFragment", "OK")
                val places = placeResponse.data
                Log.e("PlaceFragment", "size=${placeResponse.data.size}")
                Result.success(places)
            } else {
                Log.e("PlaceFragment", "failure response status is ${placeResponse.code}")
                Result.failure(RuntimeException("response status is ${placeResponse.code}"))
            }
        } catch (e: Exception) {
            Log.d("PlaceFragment", "Exception:${e.printStackTrace()}")
            Result.failure(e)
        }
        emit(result)
    }

    //返回全部地区信息
    fun allPlace() = liveData(Dispatchers.IO) {
        val result = try {
            val placeResponse = SunnyWeatherNetwork.allPlaces()
            if (placeResponse.code == "0") {
                Log.e("PlaceFragment", "OK")
                val places = placeResponse.data
                Log.e("PlaceFragment", "size=${placeResponse.data}")
                Result.success(places)
            } else {
                Log.e("PlaceFragment", "failure response status is ${placeResponse.code}")
                Result.failure(RuntimeException("response status is ${placeResponse.code}"))
            }
        } catch (e: Exception) {
            Log.d("PlaceFragment", "Exception:${e.printStackTrace()}")
            Result.failure(e)
        }
        emit(result)
    }
}