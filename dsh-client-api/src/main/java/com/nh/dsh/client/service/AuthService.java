package com.nh.dsh.client.service;


import com.nh.dsh.client.model.vo.UserLoginVO;

public interface AuthService {

    boolean checkUserEnabled(Integer pkId);

    UserLoginVO login(String code);

    void logout(String token);

    String wxVerify(String code);
}
