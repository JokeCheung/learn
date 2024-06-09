package org.example.anno;

import jakarta.validation.Constraint;
import jakarta.validation.Payload;
import org.example.validation.StateValidation;

import java.lang.annotation.*;

import static java.lang.annotation.ElementType.FIELD;
import static java.lang.annotation.RetentionPolicy.RUNTIME;

@Documented//元注解
@Target({FIELD})//元注解 决定该注解能应用在哪些地方 此时只能应用在属性上
@Retention(RUNTIME)//元注解 决定该注解能被保留在什么阶段
@Constraint(validatedBy = {StateValidation.class})//指定提供校验规则的类
public @interface State {
    //提供校验后失败后的提示信息
    String message() default "state参数的值只能是已发布或者草稿";

    //指定分组
    Class<?>[] groups() default {};

    //负载 获取到state注解的附加信息
    Class<? extends Payload>[] payload() default {};
}
