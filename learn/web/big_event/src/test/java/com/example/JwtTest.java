package com.example;

import com.auth0.jwt.JWT;
import com.auth0.jwt.JWTVerifier;
import com.auth0.jwt.algorithms.Algorithm;
import com.auth0.jwt.interfaces.Claim;
import com.auth0.jwt.interfaces.DecodedJWT;
import org.junit.jupiter.api.Test;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

public class JwtTest {

    @Test
    public void testGen() {
        Map<String, Object> claims = new HashMap<>();
        claims.put("id", 1);
        claims.put("username", "zhangsan");
        //生成jwt代码
        //1.添加载荷
        String token = JWT.create().withClaim("user", claims)
                //2.添加过期时间
                .withExpiresAt(new Date(System.currentTimeMillis()/* + 1000 * 60 * 60 * 12*/))
                //3.指定算法 配置密钥
                .sign(Algorithm.HMAC256("example"));
        System.out.println(token);
    }

    @Test
    public void testPaste() {
        //定义字符串 模拟用户传递过来的token
        String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9" +
                ".eyJ1c2VyIjp7ImlkIjoxLCJ1c2VybmFtZSI6InpoYW5nc2FuIn0sImV4cCI6MTcxMzczOTQ0MX0" +
                ".Nqb_DTYYtP4cfyqJvAbvg2tGQkDKK3rrxEwIOU1_MCo";
        JWTVerifier jwtVerifier = JWT.require(Algorithm.HMAC256("example")).build();
        //验证token 生成一个解析后的JWT对象
        DecodedJWT decodedJWT = jwtVerifier.verify(token);
        Map<String, Claim> claims = decodedJWT.getClaims();
        System.out.println(claims.get("user"));
    }
}
