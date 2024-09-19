package learn.retrofit


import learn.entity.MyResponsePlace
import learn.entity.MyResponseUser
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.GET
import retrofit2.http.Headers

interface ResponseService {

    @Headers(
        "CONNECT_TIMEOUT:1000", // 连接超时
        "READ_TIMEOUT:1000",    // 读取超时
        "WRITE_TIMEOUT:1000"    // 写出超时
    )
    @GET("/user/allUserInfo")
    fun getUserData(): Call<MyResponseUser>

    @GET("/user/allUserInfo")
    fun getRawJson(): Call<ResponseBody>

    @GET("/place/all")
    fun getPlaceData():Call<MyResponsePlace>
}