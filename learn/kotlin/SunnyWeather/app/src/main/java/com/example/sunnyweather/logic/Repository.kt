package com.example.sunnyweather.logic

import android.util.Log
import androidx.lifecycle.liveData
import com.example.sunnyweather.logic.model.Place
import com.example.sunnyweather.logic.network.SunnyWeatherNetwork
import kotlinx.coroutines.Dispatchers
import retrofit2.http.Query

object Repository {
    fun searchPlace(query: String) = liveData(Dispatchers.IO) {
        Log.e("PlaceFragment","Repository.searchPlace")
        val result = try {
            val placeResponse = SunnyWeatherNetwork.allPlaces()
            if (placeResponse.code == "0") {
                Log.e("PlaceFragment","OK")
                val places = placeResponse.data
                Log.e("PlaceFragment","size=${placeResponse.data}")
                Result.success(places)
            } else {
                Log.e("PlaceFragment","failure response status is ${placeResponse.code}")
                Result.failure(RuntimeException("response status is ${placeResponse.code}"))
            }
        } catch (e: Exception) {
            Log.d("PlaceFragment","Exception:${e.printStackTrace()}")
            Result.failure(e)
        }
        emit(result)
    }

//    fun allPlace() = liveData(Dispatchers.IO) {
//        Log.d("PlaceViewModel","Repository.searchPlace")
//        val result = try {
//            val placeResponse = SunnyWeatherNetwork.allPlaces()
//            if (placeResponse.code == "0") {
//                Log.d("PlaceViewModel","OK")
//                val places = placeResponse.data
//                Log.d("PlaceViewModel","size=${placeResponse.data}")
//                Result.success(places)
//            } else {
//                Log.d("PlaceViewModel","failure response status is ${placeResponse.code}")
//                Result.failure(RuntimeException("response status is ${placeResponse.code}"))
//            }
//        } catch (e: Exception) {
//            Log.d("PlaceViewModel","Exception")
//            Result.failure<List<Place>>(e)
//        }
//        emit(result)
//    }
}