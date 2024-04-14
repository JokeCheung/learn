package org.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.pojo.User;

@Mapper
public interface UserMapper {
    //根据用户名查询用户
    @Select("select * from user where username=#{userName}")
    User findByUsername(String userName);


    //添加
    @Insert("insert into user(username,password,create_time,update_time)" +
            " value(#{username},#{psw},now(),now())")
    void add(String username, String psw);
}




























