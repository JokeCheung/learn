package com.example.sunnyweather

class Kid(private val mother: Mother) {
    var money = 0
    fun wantMoney() {
        money += mother.giveMoney()
        mother.doSomeThing()
    }

}