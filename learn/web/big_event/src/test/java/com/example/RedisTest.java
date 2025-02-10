package com.example;

import org.example.BigEventApplication;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.data.redis.core.ValueOperations;

import java.util.concurrent.TimeUnit;

//如果在测试类添加了这个注释 那么将来单元测试方法执行之前会先初始化Spring容器
@SpringBootTest(classes = BigEventApplication.class)
public class RedisTest {

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Test
    public void testSet() {
        //往Redis存一个键值对
        ValueOperations<String, String> ops = stringRedisTemplate.opsForValue();
        ops.set("key1", "value1");
        ops.set("key2", "value2",5, TimeUnit.SECONDS);
    }

    @Test
    public void testGet() {
        //往Redis存一个键值对
        ValueOperations<String, String> ops = stringRedisTemplate.opsForValue();
        System.out.println(ops.get("key1"));
    }
}
