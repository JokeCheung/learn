package org.example.service;

import org.example.pojo.User;

public interface UserService {
    //根据用户名查找用户
    User findByUsername(String username);

    //注册
    void register(String username, String psw);

    //更新
    void update(User user);

    //更新头像链接
    void updateAvatar(String avatarUrl);

    void updatePwd(String newPwd);
}
