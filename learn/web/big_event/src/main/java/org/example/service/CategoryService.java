package org.example.service;

import org.apache.ibatis.annotations.Insert;
import org.example.pojo.Category;
import org.example.pojo.User;

import java.util.List;


public interface CategoryService {

    //新增分类
    void add(Category category);

    //查询所有分类的列表
    List<Category> list();

    //查询特定的分类
    Category findById(Integer id);

    void update(Category category);
}
