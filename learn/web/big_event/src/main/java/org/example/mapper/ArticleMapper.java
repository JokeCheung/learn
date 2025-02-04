package org.example.mapper;

import org.apache.ibatis.annotations.Insert;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Select;
import org.example.pojo.Article;
import org.example.pojo.Category;

import java.util.List;

@Mapper
public interface ArticleMapper {

    //新增文章
    @Insert("insert into article(title,content,cover_img,state,category_id,create_user,create_time,update_time)" +
            " values(#{title},#{content},#{coverImg},#{state},#{categoryId},#{createUser},#{createTime},#{updateTime})")
    void add(Article article);


    //更新分类信息
    @Select("update article set title=#{title},content=#{content},cover_img=#{coverImg},state=#{state},category_id=#{categoryId}" +
            " where id=#{id}")
    void update(Article article);

    List<Article> list(Integer userId, Integer categoryId, String state);
}




























