package com.example.sunnyweather

object KotlinUtil {
    @JvmStatic
    fun staticDoSomething(): String {
        return "UtilKotlin.ok()"
    }
}

class KotlinUtilUsage {
    fun useKotlinUtil() {
        KotlinUtil.staticDoSomething()
    }
}