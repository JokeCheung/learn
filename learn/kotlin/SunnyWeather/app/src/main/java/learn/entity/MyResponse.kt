package learn.entity

import com.example.sunnyweather.logic.model.Place

data class MyResponseUser(
    var code: Int,
    var message: String,
    var data: List<User>,
)

data class MyResponsePlace(
    var code: Int,
    var message: String,
    var data: List<Place>,
)