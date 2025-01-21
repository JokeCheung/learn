package com.example.sunnyweather.logic.network

import okhttp3.OkHttpClient
import okhttp3.logging.HttpLoggingInterceptor
import retrofit2.Retrofit
import retrofit2.converter.gson.GsonConverterFactory

//单例
object ServiceCreator {

    private const val BASE_URL = "https://api.caiyunapp.com/"
    private const val BASE_URL_TEST = "http://192.168.31.180:8080"

    // 创建 HttpLoggingInterceptor
     val logging = HttpLoggingInterceptor().apply { setLevel(HttpLoggingInterceptor.Level.BODY) }
    // 创建 OkHttpClient 并添加拦截器
     val client = OkHttpClient.Builder().addInterceptor(logging) .build()

    private val retrofit = Retrofit.Builder()
        .baseUrl(BASE_URL)
        .addConverterFactory(GsonConverterFactory.create())
        .client(client)
        .build()

    private val retrofitLocal = Retrofit.Builder()
        .baseUrl(BASE_URL_TEST)
        .addConverterFactory(GsonConverterFactory.create())
        .build()

    fun <T> create(serviceClass: Class<T>): T = retrofit.create(serviceClass)
    fun <T> createLocal(serviceClass: Class<T>): T = retrofitLocal.create(serviceClass)

    //泛型实化：允许我们在泛型函数中获取泛型的实际类型
    inline fun <reified T> create(): T = create(T::class.java)
}