package org.example.controller;

import jakarta.validation.constraints.Pattern;
import org.example.pojo.Result;
import org.example.pojo.User;
import org.example.service.UserService;
import org.example.utils.JwtUtil;
import org.example.utils.Md5Util;
import org.example.utils.ThreadLocalUtil;
import org.hibernate.validator.constraints.URL;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.util.StringUtils;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
@RequestMapping("/user")
@Validated
public class UserController {

    @Autowired
    private UserService userService;

    @RequestMapping("/register")
    public Result<Object> register(@Pattern(regexp = "^\\S{5,16}$") String username, @Pattern(regexp = "^\\S{5,16}$") String password) {
        //查询用户
        User u = userService.findByUsername(username);
        if (u == null) {
            //没有被占用
            userService.register(username, password);
            return Result.success();
        } else {
            //用户名已经被占用
            return Result.error("该用户名已被占用");
        }
    }

    @RequestMapping("/login")
    public Result<String> login(@Pattern(regexp = "^\\S{5,16}$") String username, @Pattern(regexp = "^\\S{5,16}$") String password) {
        User loginUser = userService.findByUsername(username);
        //判断该用户是否存在
        if (loginUser == null) {
            return Result.error("用户名错误");
        }

        //判断密码是否正确
        if (Md5Util.getMD5String(password).equals(loginUser.getPassword())) {
            Map<String, Object> claims = new HashMap<>();
            claims.put("id", loginUser.getId());
            claims.put("username", loginUser.getUsername());
            String token = JwtUtil.genToken(claims);
            //登陆成功
            return Result.success(token);
        }

        return Result.success("密码错误");

    }

    @RequestMapping("/userInfo")
    public Result<User> userInfo(@RequestHeader(name = "Authorization") String token) {
        //根据token的用户名查询用户
//        Map<String, Object> claims = JwtUtil.parseToken(token);
//        String username = claims.get("username").toString();
        Map<String, Object> map = ThreadLocalUtil.get();
        String username = map.get("username").toString();
        User user = userService.findByUsername(username);
        return Result.success(user);
    }


    @PutMapping("/update")
    public Result update(@RequestBody @Validated User user) {
        userService.update(user);
        return Result.success();
    }

    @PatchMapping("updateAvatar")
    public Result updateAvatar(@RequestParam @URL String avatarUrl) {
        userService.updateAvatar(avatarUrl);
        return Result.success();
    }

    @PatchMapping("/updatePwd")
    public Result updatePwd(@RequestBody Map<String, String> params) {
        //1.校验参数
        String oldPwd = params.get("old_pwd");
        String newPwd = params.get("new_pwd");
        String rePwd = params.get("re_pwd");
        if (!StringUtils.hasLength(oldPwd) ||
                !StringUtils.hasLength(newPwd) ||
                !StringUtils.hasLength(rePwd)) {
            return Result.error("Missing necessary parameters");
        }

        //2.比对新密码和确认密码是否一样
        if (!rePwd.equals(newPwd)) {
            return Result.error("The passwords filled in twice are inconsistent");
        }

        //3.对比原密码是否输入正确
        Map<String, Object> map = ThreadLocalUtil.get();
        String username = map.get("username").toString();
        User user = userService.findByUsername(username);
        if (!user.getPassword().equals(Md5Util.getMD5String(oldPwd))) {
            return Result.error("The original password is incorrect");
        }

        userService.updatePwd(newPwd);
        return Result.success();
    }

    /**
     * 返回所有用户Json数据接口
     */

    @RequestMapping("/allUserInfo")
    public Result<List<User>> findAllUserInfo(/*@RequestHeader(name = "Authorization") String token*/) {
        //根据token的用户名查询所有用户
//        Map<String, Object> map = JwtUtil.parseToken(token);
//        String username = map.get("username").toString();
//        System.out.println("用户：" + username + "查看了所有用户信息");

        System.out.println("findAllUserInfo调用！！！！！！！！！！！");
        List<User> users = userService.findAllUseInfo();
        return Result.success(users);
    }



}























