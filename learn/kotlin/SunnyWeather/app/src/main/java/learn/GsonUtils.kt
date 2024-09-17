package learn

import android.util.Log
import com.google.gson.Gson
import com.google.gson.reflect.TypeToken
import learn.entity.MyResponse

object GsonUtils {

    val TAG = "GsonUtils"

    fun parseResponse(jsonData: String) {
        Log.e(TAG, "parseJSON")
        val gson = Gson()
        val typeOf = object : TypeToken<MyResponse>() {}.type
        val myResponse = gson.fromJson<MyResponse>(jsonData, typeOf)
        myResponse.data.forEach { user ->
            Log.d(TAG, "-----------------------")
            Log.d(TAG, "user.id=" + user.id)
            Log.d(TAG, "user.username=" + user.username)
            Log.d(TAG, "user.userPic=" + user.userPic)
            Log.d(TAG, "user.nickname=" + user.nickname)
            Log.d(TAG, "user.email=" + user.email)
            Log.d(TAG, "user.createTime=" + user.createTime)
            Log.d(TAG, "user.updateTime=" + user.updateTime)
        }
    }

}