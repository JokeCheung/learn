package learn.retrofit;


import java.io.IOException;
import java.util.concurrent.TimeUnit;

import okhttp3.Interceptor;
import okhttp3.Request;
import okhttp3.Response;

public class TimeoutInterceptor implements Interceptor {
    @Override
    public Response intercept(Chain chain) throws IOException {
        Request request = chain.request();

        // 获取请求头中的超时设置
        String connectTimeout = request.header("CONNECT_TIMEOUT");
        String readTimeout = request.header("READ_TIMEOUT");
        String writeTimeout = request.header("WRITE_TIMEOUT");

        // 设置默认超时
        int connectTimeoutMillis = 2 * 1000; // 10秒
        int readTimeoutMillis = 2 * 1000;    // 30秒
        int writeTimeoutMillis = 2 * 1000;   // 15秒

        // 根据请求头中的设置覆盖默认超时
        if (connectTimeout != null) {
            connectTimeoutMillis = Integer.parseInt(connectTimeout);
        }
        if (readTimeout != null) {
            readTimeoutMillis = Integer.parseInt(readTimeout);
        }
        if (writeTimeout != null) {
            writeTimeoutMillis = Integer.parseInt(writeTimeout);
        }

        return chain
                .withConnectTimeout(connectTimeoutMillis, TimeUnit.MILLISECONDS)
                .withReadTimeout(readTimeoutMillis, TimeUnit.MILLISECONDS)
                .withWriteTimeout(writeTimeoutMillis, TimeUnit.MILLISECONDS)
                .proceed(request);
    }
}
