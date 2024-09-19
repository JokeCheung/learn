package com.example.sunnyweather.ui.place

import androidx.lifecycle.*
import com.example.sunnyweather.logic.Repository
import com.example.sunnyweather.logic.model.Location
import com.example.sunnyweather.logic.model.Place

class PlaceViewModel : ViewModel() {
    private val searchLiveData = MutableLiveData<String>()
    val placeList = ArrayList<Place>()
    val placeLiveData = Transformations.switchMap(searchLiveData) { query ->
        Repository.searchPlace(query)
    }

    fun searchPlaces(query: String) {
        searchLiveData.value = query
    }

//    fun initData() {
//        440106,广东省广州市天河区,113.3612,23.12468
//        val location = Location("113.3612", "23.12468")
//        val p = Place("440106", location, "广东省广州市天河区")
//        placeList.set(p)
//    }
}