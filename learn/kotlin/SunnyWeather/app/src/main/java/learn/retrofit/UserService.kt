package learn.retrofit


import learn.entity.MyResponse
import okhttp3.ResponseBody
import retrofit2.Call
import retrofit2.http.GET

interface ResponseService {

    @GET("/user/allUserInfo")
    fun getResponseData(): Call<MyResponse>

    @GET("/user/allUserInfo")
    fun getRawJson(): Call<ResponseBody>
}