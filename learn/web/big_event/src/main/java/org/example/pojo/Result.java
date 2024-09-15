package org.example.pojo;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

//统一响应结果
@AllArgsConstructor
@Data
public class Result<T> {
        private Integer code;//业务状态码  0-成功  1-失败
        private String message;//提示信息
        private T data;//响应数据

        //快速返回操作成功响应结果(带响应数据)
        public static <E> org.example.pojo.Result<E> success(E data) {
            return new org.example.pojo.Result<>(0, "操作成功", data);
        }

        //快速返回操作成功响应结果
        public static <E> org.example.pojo.Result<E> success() {
            return new org.example.pojo.Result<E>(0, "操作成功", null);
        }

        public static <E> org.example.pojo.Result<E> error(String message) {
            return new org.example.pojo.Result<E>(1, message, null);
        }
}
