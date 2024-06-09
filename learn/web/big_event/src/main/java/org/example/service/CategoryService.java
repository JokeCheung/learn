package org.example.service;

import org.apache.ibatis.annotations.Insert;
import org.example.pojo.Category;
import org.example.pojo.User;


public interface CategoryService {

    //新增分类
    void add(Category category);
}
