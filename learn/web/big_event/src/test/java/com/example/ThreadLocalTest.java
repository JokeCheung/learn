package com.example;

import org.junit.jupiter.api.Test;

public class ThreadLocalTest {

    @Test
    public void testThreadLocalSetAndGet() {
        //提供一个ThreadLocal对象
        ThreadLocal<Object> tl = new ThreadLocal<>();

        //开启两个线程
        new Thread(() -> {
            tl.set("派大星");
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
        },"线程1").start();

        new Thread(() -> {
            tl.set("海绵宝宝");
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
            System.out.println(Thread.currentThread().getName()+"："+tl.get());
        },"线程2").start();
    }
}
