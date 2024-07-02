package com.nh.dsh.client.service.impl;

import com.nh.dsh.client.common.cache.TokenStoreCache;
import com.nh.dsh.client.enums.CommonStatusEnum;
import com.nh.dsh.client.mapper.UserMapper;
import com.nh.dsh.client.model.vo.UserLoginVO;
import com.nh.dsh.client.service.AuthService;
import com.nh.dsh.client.utils.JwtUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-06-28 10:09
 **/

@Service
@AllArgsConstructor
public class AuthServiceImpl implements AuthService {
    private final UserMapper userMapper;
    private final TokenStoreCache tokenStoreCache;

    @Override
    public boolean checkUserEnabled(Integer pkId) {
        return userMapper.selectById(pkId).getDeleteFlag().equals(CommonStatusEnum.NO.getStatus());
    }

    @Override
    public UserLoginVO login() {
        String token = JwtUtil.createToken(1);
        UserLoginVO userLoginVO = new UserLoginVO();
        userLoginVO.setPkId(1);
        userLoginVO.setAccessToken(token);
        tokenStoreCache.saveUser(token, userLoginVO);
        return userLoginVO;
    }
}
