package org.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.apache.ibatis.annotations.Update;
import org.example.pojo.Category;
import org.example.pojo.User;

@Mapper
public interface CategoryMapper {


    @Insert("insert into category(category_name,category_alias,create_user,create_time,update_time)" +
            "value(#{categoryName},#{categoryAlias},#{createUser},#{createTime},#{updateTime})")
    void add(Category category);
}




























