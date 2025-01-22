package com.example.sunnyweather.database

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.util.Log
import com.example.sunnyweather.logic.model.Location
import com.example.sunnyweather.logic.model.Place

object DataBaseManager {
    private const val tableName="Place"
    val findPlace = "SELECT * FROM $tableName WHERE formatted_address LIKE '%' || ? || '%'"
    val createPlaceTable = "CREATE TABLE $tableName ( id INTEGER PRIMARY KEY AUTOINCREMENT,formatted_address TEXT,adcode TEXT,lng TEXT,lat TEXT)"
    val insertPlace = "INSERT INTO $tableName (formatted_address,adcode,lng,lat) VALUES (?, ?, ?,?)"

    private lateinit var dbHelper: PlaceDBHelper
    private lateinit var db: SQLiteDatabase

    fun initialize(context: Context) {
        dbHelper = PlaceDBHelper(context, "Place.db", 1)
        db = dbHelper.writableDatabase
    }

    fun queryPlaces(name:String): ArrayList<Place> {
        val placeData = ArrayList<Place>()
        val cursor=db.rawQuery(findPlace,arrayOf(name))
        val adcodeIndex = cursor.getColumnIndex("adcode")
        val formatted_addressIndex = cursor.getColumnIndex("formatted_address")
        val lngIndex = cursor.getColumnIndex("lng")
        val latIndex = cursor.getColumnIndex("lat")
        if (adcodeIndex == -1 ||formatted_addressIndex == -1 ||lngIndex == -1 ||latIndex == -1 ) {
            Log.e("DataBaseManager","queryPlaces getColumnIndex error.")
            return placeData
        }

        if(cursor.moveToFirst()){
            do {
                val adcode = cursor.getString(adcodeIndex)
                val formatted_address = cursor.getString(formatted_addressIndex)
                val lng =cursor.getString(lngIndex)
                val lat = cursor.getString(latIndex)
                val location = Location(lng, lat)
                val place = Place(adcode, formatted_address, location)
                placeData.add(place)
            }while (cursor.moveToNext())
        }
        cursor.close()
        return placeData
    }

}
