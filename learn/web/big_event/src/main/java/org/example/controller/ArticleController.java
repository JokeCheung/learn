package org.example.controller;

import jakarta.servlet.http.HttpServletResponse;
import org.example.pojo.Result;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
@RestController
@RequestMapping("/article")
public class ArticleController {

    @RequestMapping("/list")
    public Result<String> list(@RequestHeader(name = "Authorization") String token,
                               HttpServletResponse response) {
        return Result.success("获取所有文章数据");
    }
}
