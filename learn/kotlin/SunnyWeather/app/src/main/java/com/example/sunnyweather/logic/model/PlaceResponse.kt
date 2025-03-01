package com.example.sunnyweather.logic.model

import android.util.Log
import androidx.core.app.NotificationCompat.MessagingStyle.Message
import com.google.gson.TypeAdapter
import com.google.gson.annotations.JsonAdapter
import com.google.gson.stream.JsonReader
import com.google.gson.stream.JsonWriter
import java.io.IOException

data class PlaceResponse(val code: String, val message: String, val data: List<Place>);

data class Place(
    val adcode: String,
    val formatted_address: String,
    val location: Location
) {
    override fun toString(): String {
        return "$adcode $formatted_address $location"
    }

}

data class Location(val lng: String, val lat: String) {
    override fun toString(): String {
        return "($lng,$lat)"
    }
}



