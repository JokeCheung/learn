package com.example.sunnyweather.database

import android.content.Context
import android.database.sqlite.SQLiteDatabase
import android.database.sqlite.SQLiteOpenHelper
import android.widget.Toast
import com.example.sunnyweather.logic.model.Location
import com.example.sunnyweather.logic.model.Place
import java.io.BufferedReader
import java.io.InputStreamReader
import java.util.regex.Matcher
import java.util.regex.Pattern


class PlaceDBHelper(val context: Context, name: String, version: Int) :
    SQLiteOpenHelper(context, name, null, version) {

    //数据库已存在不会重复调用
    override fun onCreate(db: SQLiteDatabase) {
        db.execSQL(DataBaseManager.createPlaceTable)
        initData(db)
        Toast.makeText(context,"Create PlaceTable succeeded",Toast.LENGTH_SHORT).show()
    }

    override fun onUpgrade(db: SQLiteDatabase, oldVersion: Int, newVersion: Int) {
        db.execSQL("drop table if exists Book")
        db.execSQL("drop table if exists Category")
        onCreate(db)
        Toast.makeText(context,"Upgrade succeeded",Toast.LENGTH_SHORT).show()
    }


    private fun initData(db: SQLiteDatabase){
        //    ^\d{6}：匹配以六位数字开头的部分
        //    [\u4e00-\u9fa5()]{2,50}：匹配逗号后 2 到 50 个汉字的城市名称+加上带括号特殊情况
        //    \d{3}\.\d{6}：匹配逗号后 3 位整数和 6 位小数的经度
        //    \d{2}\.\d{6}$：匹配逗号后 2 位整数和 6 位小数的纬度，并以此结尾
        val regex = "(^\\d{6}),([\\u4e00-\\u9fa5()]{2,50}),(\\d{1,3}\\.\\d{1,10}),(\\d{1,2}\\.\\d{1,10})$"
        val placeData = ArrayList<Place>()
        val inputStream = context.assets.open("adcode.csv")
        val reader = BufferedReader(InputStreamReader(inputStream))
        var inputLine: String?
        while ((reader.readLine().also { inputLine = it }) != null) {
            val pattern: Pattern = Pattern.compile(regex)
            val matcher: Matcher = pattern.matcher(inputLine)
            if (matcher.matches()) {
                val adcode = matcher.group(1)
                val formatted_address = matcher.group(2)
                val lng = matcher.group(3)
                val lat = matcher.group(4)

                if(adcode == null || formatted_address == null || lng == null || lat == null) continue

                val location = Location(lng, lat)
                val place = Place(adcode, formatted_address, location)
                placeData.add(place)
            }
        }

        for (place in placeData) {
            val adcode = place.adcode
            val formatted_address = place.formatted_address
            val lng = place.location.lng
            val lat = place.location.lat
            db.execSQL(DataBaseManager.insertPlace, arrayOf(formatted_address,adcode,lng,lat))
        }
    }

}