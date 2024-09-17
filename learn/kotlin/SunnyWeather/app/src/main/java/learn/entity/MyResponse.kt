package learn.entity

data class MyResponse(
    var code: Int,
    var message: String,
    var data: List<User>,
)