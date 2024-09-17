package learn

import android.util.Log
import okhttp3.OkHttpClient
import okhttp3.Request
import java.io.BufferedReader
import java.io.InputStreamReader
import java.net.HttpURLConnection
import java.net.URL
import kotlin.concurrent.thread

object HttpUtils {

    /**
     * HttpURLConnection  接口封装回调实现：需要手动创建子线程包裹
     * @param address   网址
     * @param callback  回调接口
     */
    fun sendRequestHttpURLConnection(address: String, callback: HttpCallbackListener) {
        var connection: HttpURLConnection? = null
        try {
            val response = StringBuilder()
            val url = URL(address)
            connection = url.openConnection() as HttpURLConnection
            connection.requestMethod = "GET"
            connection.connectTimeout = 8000
            connection.readTimeout = 8000
            val input = connection.inputStream
            val reader = BufferedReader(InputStreamReader(input))
            reader.use {
                reader.forEachLine {
                    response.append(it)
                }
            }
            callback.onFinish(response.toString())
        } catch (e: Exception) {
            callback.onError(e)
        } finally {
            connection?.disconnect()
        }
    }
    /**
     * OkHttp  接口封装回调实现 enqueue方法会自动创建子线程
     * @param address   网址
     * @param callback  回调接口
     */
    fun sendRequestOkhttp(address: String, callback: okhttp3.Callback) {
        val client = OkHttpClient()
        val request = Request.Builder()
            .url(address)
            .build()
        client.newCall(request).enqueue(callback)
    }

}

interface HttpCallbackListener {
    fun onFinish(response: String)
    fun onError(e: Exception)
}