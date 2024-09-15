package org.example.service;

import org.example.pojo.Article;
import org.example.pojo.Category;
import org.example.pojo.PageBean;

import java.util.List;


public interface ArticleService {

    //新增文章
    void add(Article article);

    //条件分类查询
    PageBean<Article> list(Integer pageNum, Integer pageSize, Integer categoryId, String state);
}
