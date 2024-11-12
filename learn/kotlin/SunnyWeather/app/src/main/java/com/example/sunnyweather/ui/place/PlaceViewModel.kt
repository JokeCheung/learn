package com.example.sunnyweather.ui.place

  import android.util.Log
import androidx.lifecycle.*
import com.example.sunnyweather.logic.Repository
import com.example.sunnyweather.logic.model.Location
import com.example.sunnyweather.logic.model.Place

class PlaceViewModel : ViewModel() {
    val placeList = ArrayList<Place>()
    private val searchLiveData = MutableLiveData<String>()

    val placeLiveData = Transformations.switchMap(searchLiveData) { query ->
        Repository.searchPlace(query)
    }

//    val placeNameData = Transformations.switchMap(placeList) {
//        val names= ArrayList<String>()
//        placeList.value!!.forEach { place ->
//            names.add("${place.adcode},${place.formatted_address}")
//        }
//        return MutableLiveData<names>()
//    }

//    fun allPlace(): LiveData<Result<List<Place>>> {
//        val data=Repository.allPlace()
////        Log.d("PlaceFragment","data=${data.value.}")
//        return data
//    }
////

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