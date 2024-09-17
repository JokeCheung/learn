package org.example.service;

import org.example.pojo.User;

import java.util.List;

public interface UserService {
    //根据用户名查找用户
    User findByUsername(String username);

    //注册
    void register(String username, String psw);

    //更新
    void update(User user);

    //更新头像链接
    void updateAvatar(String avatarUrl);

    //更新密码
    void updatePwd(String newPwd);

    //返回所有用户信息
    List<User> findAllUseInfo();
}
