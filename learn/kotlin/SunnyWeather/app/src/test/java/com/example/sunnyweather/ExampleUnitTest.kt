package com.example.sunnyweather

import io.mockk.MockKAnnotations
import io.mockk.every
import io.mockk.impl.annotations.InjectMockKs
import io.mockk.impl.annotations.MockK
import io.mockk.mockk
import io.mockk.mockkStatic
import io.mockk.verify
import io.mockk.verifyOrder
import io.mockk.verifySequence
import org.junit.Test

import org.junit.Assert.*
import org.junit.Before


/**
 * Example local unit test, which will execute on the development machine (host).
 *
 * See [testing documentation](http://d.android.com/tools/testing).
 */
class ExampleUnitTest {

    //自动创建该类的替身
    @MockK(relaxUnitFun = true)
    lateinit var mother: Mother

    //初始化测试替身作为构造函数参数的对象
    @InjectMockKs
    lateinit var kid: Kid

    @Before
    fun setUp(){
        //初始化替身
        MockKAnnotations.init(this)
    }


    @Test
    fun test() {
        //替身创建方法1：mockk<Class>()
//        val mother = mockk<Mother>()
        //mockk要求每一个被调用过的替身对象的方法都要打桩 @MockK(relaxed = true)意思是该替身所有方法都不用打桩
//        every { mother.giveMoney() } returns 100
//        val kid = Kid(mother)
//        kid.wantMoney()
//        assertEquals(100,kid.money)

        //替身创建方法2：利用注解创建
//        every { mother.giveMoney() } returns 100
//        kid.wantMoney()
//        assertEquals(100,kid.money)
        //是否被调用过
//        verify { mother.giveMoney() }
        //是否被调用过n次
//        verify(exactly = 0) { mother.giveMoney() }

        //执行一定要按这个顺序一条条执行下去 不得有其他方法插入
//        verifySequence {
//            mother.inform(any())
//            mother.giveMoney()
//        }

        //表示中间可以加入其他方法的调用，整体顺序是这样就行
//        verifyOrder {
//            mother.inform(any())
//            mother.giveMoney()
//        }

        val kotlinUtilUsage = KotlinUtilUsage()
        mockkStatic(KotlinUtil::class)
        every { KotlinUtil.staticDoSomething() } returns "mocked returns"
        //when
        kotlinUtilUsage.useKotlinUtil()
        //then
        verify { KotlinUtil.staticDoSomething() }

    }
}