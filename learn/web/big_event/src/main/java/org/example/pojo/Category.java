package org.example.pojo;

import com.fasterxml.jackson.annotation.JsonFilter;
import com.fasterxml.jackson.annotation.JsonFormat;
import jakarta.validation.constraints.NotEmpty;
import jakarta.validation.constraints.NotNull;
import jakarta.validation.groups.Default;
import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;

@Data
public class Category {
    //分组校验：用于区分不同请求体应用不同的校验规则
    //add不需要从传入的请求体中获取id
    //update需要从传入的请求体中获取id
    //id只在update操纵时校验不能为空
    @NotNull(groups = Update.class)
    private Integer id;//主键ID

//    @NotEmpty(groups = {Add.class, Update.class})
    @NotEmpty()
    private String categoryName;//分类名称

//    @NotEmpty(groups = {Add.class, Update.class})
    @NotEmpty()
    private String categoryAlias;//分类别名
    private Integer createUser;//创建人ID

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime createTime;//创建时间

    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    private LocalDateTime updateTime;//更新时间

    //分组：以下是分组
    //校验项：类的属性字段

    //校验项不指定group属性则属于默认分组
    //此时会对校验项同时进行继承自Default的分组进行校验
    public interface Add extends Default {

    }

    public interface Update extends  Default{

    }
}
