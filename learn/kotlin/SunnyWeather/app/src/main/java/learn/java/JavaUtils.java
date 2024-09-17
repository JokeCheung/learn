package learn.java;

import android.util.Log;

import learn.HttpCallbackListener;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.HttpURLConnection;
import java.net.URL;

import okhttp3.OkHttpClient;
import okhttp3.Request;
import okhttp3.Response;

/**
 * JAVA版本的Http库、OkHttp库的使用
 */
public class JavaUtils {

    /**
     * HttpURLConnection  接口封装回调实现
     * @param address   网址
     * @param callback  回调接口
     */
    public static void sendHttpRequest( String address, HttpCallbackListener callback){
        HttpURLConnection connection= null;
        try {
            StringBuilder response = new StringBuilder();
            URL url = new URL(address);
            connection = (HttpURLConnection)url.openConnection();
            connection.setRequestMethod("GET");
            connection.setConnectTimeout(8000);
            connection.setReadTimeout(8000);
            InputStream input = connection.getInputStream();
            BufferedReader reader = new BufferedReader(new InputStreamReader(input));
            String inputLine;
            while ((inputLine = reader.readLine()) != null) {
                response.append(inputLine);
            }
            callback.onFinish(response.toString());
        } catch ( Exception e) {
            callback.onError(e);
        } finally {
            connection.disconnect();
        }
    }
    /**
     * OkHttp  接口封装回调实现
     * @param address   网址
     * @param callback  回调接口
     */
    public static void sendRequestOkhttp(String address, okhttp3.Callback callback) {
        OkHttpClient client = new  OkHttpClient();
        Request request = new Request.Builder()
                .url(address)
                .build();
        client.newCall(request).enqueue(callback);
    }

}
