package org.example.controller;

import jakarta.validation.constraints.Pattern;
import org.example.pojo.Place;
import org.example.pojo.Result;
import org.example.service.PlaceService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/place")
@Validated
public class PlaceController {

    final String placeRegex = " [\\u4e00-\\u9fa5()]{1,50}";


    @Autowired
    private PlaceService placeService;

    @RequestMapping("/all")
    public Result<List<Place>> allPlace(/*@RequestHeader(name = "Authorization") String token*/) {
        //根据token的用户名查询所有用户
//        Map<String, Object> map = JwtUtil.parseToken(token);
//        String username = map.get("username").toString();
//        System.out.println("用户：" + username + "查看了所有用户信息");

        System.out.println("allPlace调用！！！！！！！！！！！");
        List<Place> placeData = placeService.allPlace();
        return Result.success(placeData);
    }

    @RequestMapping("/find")
    public Result<List<Place>> findPlace(/*@Pattern(regexp = placeRegex)*/@RequestParam String placeName) {

        System.out.println("find调用！！！！！！！！！！！");
        List<Place> placeData = placeService.findPlace(placeName);
        return Result.success(placeData);
    }
}
