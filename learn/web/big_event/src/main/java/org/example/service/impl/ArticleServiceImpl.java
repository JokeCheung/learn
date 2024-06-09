package org.example.service.impl;

import org.example.mapper.ArticleMapper;
import org.example.mapper.CategoryMapper;
import org.example.pojo.Article;
import org.example.pojo.Category;
import org.example.pojo.PageBean;
import org.example.service.ArticleService;
import org.example.service.CategoryService;
import org.example.utils.ThreadLocalUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Map;

@Service
public class ArticleServiceImpl implements ArticleService {

    @Autowired
    private ArticleMapper articleMapper;


    @Override
    public void add(Article article) {
        //补充属性值 不能为null
        articleMapper.add(article);
    }

    @Override
    public PageBean<Article> list(Integer pageNum, Integer pageSize, Integer categoryId, String state) {
        //1.创建PageBean对象
        PageBean<Article> pageBean=new PageBean<>();
        //2.开启分页查询 PageHelper插件
        //3.调用mapper
        return null;
    }

}
