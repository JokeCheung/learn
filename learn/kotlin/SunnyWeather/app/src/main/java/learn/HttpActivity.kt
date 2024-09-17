package learn

import android.os.Bundle
import android.util.Log
import androidx.appcompat.app.AppCompatActivity
import com.example.sunnyweather.activity.FROM_HTTP
import com.example.sunnyweather.activity.FROM_OKHTTP
import com.example.sunnyweather.activity.FROM_RETROFIT
import com.example.sunnyweather.activity.FROM_RETROFIT_DESERIALIZE
import com.example.sunnyweather.databinding.ActivityHttpBinding
import learn.entity.MyResponse
import learn.retrofit.ResponseService
import okhttp3.Call

import okhttp3.ResponseBody
import okhttp3.Response as Okhttp3Response
import retrofit2.Callback
import retrofit2.Response as Retrofit2Response
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory
import java.io.IOException
import kotlin.concurrent.thread

const val address = "http://192.168.31.180:8080/user/allUserInfo"
const val addressHead = "http://192.168.31.180:8080"
const val addressTail = "/user/allUserInfo"

class HttpActivity : AppCompatActivity() {

    private lateinit var binding: ActivityHttpBinding

    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        binding = ActivityHttpBinding.inflate(layoutInflater)
        setContentView(binding.root)
        sendRequest()
    }

    private fun sendRequest() {

        val from = intent.getIntExtra("from", FROM_HTTP)
        when (from) {
            FROM_HTTP -> startHttpURLConnection()
            FROM_OKHTTP -> startOKHttp()
            FROM_RETROFIT -> startRetrofit()
            FROM_RETROFIT_DESERIALIZE->startRetrofitDeserialize()
        }

    }
    /**
     * Retrofit kotlin实现接口回调：内部实现了子线程，对响应体反序列化成指定JSON Model
     */
    private fun startRetrofitDeserialize(){
        binding.accessTypeTv.text = "Retrofit Deserialize";
        val retrofit = Retrofit.Builder()
            .baseUrl(addressHead)
            .addConverterFactory(GsonConverterFactory.create())
            .build()
        val responseService = retrofit.create(ResponseService::class.java)
        responseService.getResponseData().enqueue(object : Callback<MyResponse> {
            override fun onResponse(
                call: retrofit2.Call<MyResponse>,
                retrofit2Response: Retrofit2Response<MyResponse>
            ) {
                val response=retrofit2Response.body()
                val string=StringBuilder()
                response?.data?.forEach { user ->
                    string.append(user.toString()+"\n")
                }
                showResponse(string.toString())
            }

            override fun onFailure(call: retrofit2.Call<MyResponse>, t: Throwable) {
                showResponse(t.toString())
            }
        })
    }

    /**
     * Retrofit kotlin实现接口回调：内部实现了子线程，不对响应体反序列化
     */
    private fun startRetrofit() {
        binding.accessTypeTv.text = "Retrofit";
        val retrofit = Retrofit.Builder()
            .baseUrl(addressHead)
            .build()
        val responseService = retrofit.create(ResponseService::class.java)

        responseService.getRawJson().enqueue(object : Callback<ResponseBody> {
            override fun onResponse(
                call: retrofit2.Call<ResponseBody>,
                retrofit2Response: Retrofit2Response<ResponseBody>
            ) {
                if(retrofit2Response.isSuccessful){
                    Log.e(GsonUtils.TAG, "----------Retrofit 响应返回原始json-------------")
                }
                val responseData = retrofit2Response.body()?.string()
                showResponse(responseData?:"")
            }

            override fun onFailure(call: retrofit2.Call<ResponseBody>, t: Throwable) {
                showResponse(t.toString())
            }
        }
        )
    }
    /**
     * Okhttp kotlin实现接口回调：Okhttp内部实现了子线程
     */
    private fun startOKHttp() {
        binding.accessTypeTv.text = "OKHttp";
        HttpUtils.sendRequestOkhttp(address, object : okhttp3.Callback {

            override fun onFailure(call: Call, e: IOException) {
                showResponse(e.message.toString())
                Log.e(GsonUtils.TAG, e.message.toString())
            }

            override fun onResponse(call: Call, response: Okhttp3Response) {
                val responseData = response.body?.string()
                showResponse(responseData ?: "")
                GsonUtils.parseResponse(responseData ?: "")
            }
        })
    }

    /**
     * HttpURLConnection kotlin实现接口回调：需要用子线程包裹
     */
    private fun startHttpURLConnection() {
        binding.accessTypeTv.text = "HttpURLConnection";
        thread {
            HttpUtils.sendRequestHttpURLConnection(address, object : HttpCallbackListener {
                override fun onFinish(response: String) {
                    showResponse(response)
                }

                override fun onError(e: Exception) {
                    showResponse(e.message.toString())
                }
            })
        }
    }

    private fun showResponse(response: String) {
        runOnUiThread {
            binding.responseTv.text = response
        }
    }
}