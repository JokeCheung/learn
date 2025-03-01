package org.example.interceptors;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import org.example.utils.JwtUtil;
import org.example.utils.ThreadLocalUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;
import org.springframework.stereotype.Component;
import org.springframework.web.servlet.HandlerInterceptor;

import java.util.Map;
import java.util.concurrent.TimeUnit;

/**
 * 拦截器的具体实现
 */

@Component
public class LoginInterceptor implements HandlerInterceptor {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;


    @Override
    public boolean preHandle(HttpServletRequest request, HttpServletResponse response, Object handler) throws Exception {
        //token验证
        String token = request.getHeader("Authorization");
        //访问该接口时 需要验证token
        try {
            //校验token是否过时
            ValueOperations<String, String> ops = stringRedisTemplate.opsForValue();
            String redisToken=ops.get(token);
            if(redisToken==null){
                throw new RuntimeException();
            }
            Map<String, Object> claims = JwtUtil.parseToken(token);
            //线程隔离：为每一个用户访问的进程保存一个可以持续全局调用的对象
            ThreadLocalUtil.set(claims);
            return true;//放行
        } catch (Exception e) {
            //设置失败响应状态码为401
            response.setStatus(401);
            return false;//不放行
        }
    }

    /** 防止内存泄露 务必清除ThreadLocal
     */
    @Override
    public void afterCompletion(HttpServletRequest request, HttpServletResponse response, Object handler, Exception ex) throws Exception {
        //清空ThreadLocal
        ThreadLocalUtil.remove();
    }
}
