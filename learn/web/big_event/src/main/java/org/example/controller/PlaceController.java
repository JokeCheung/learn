package org.example.controller;

import org.example.pojo.Place;
import org.example.pojo.Result;
import org.example.pojo.User;
import org.example.service.PlaceService;
import org.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("/place")
@Validated
public class PlaceController {
    @Autowired
    private PlaceService placeService;

    @RequestMapping("/all")
    public Result<List<Place>> findAllPlace(/*@RequestHeader(name = "Authorization") String token*/) {
        //根据token的用户名查询所有用户
//        Map<String, Object> map = JwtUtil.parseToken(token);
//        String username = map.get("username").toString();
//        System.out.println("用户：" + username + "查看了所有用户信息");

        System.out.println("findPlace调用！！！！！！！！！！！");
        List<Place> placeData = placeService.getPlaceData();
        return Result.success(placeData);
    }
}
