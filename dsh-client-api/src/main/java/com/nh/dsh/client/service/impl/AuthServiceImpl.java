package com.nh.dsh.client.service.impl;

import com.alibaba.fastjson2.JSON;
import com.alibaba.fastjson2.JSONObject;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.nh.dsh.client.common.cache.RequestContext;
import com.nh.dsh.client.common.cache.TokenStoreCache;
import com.nh.dsh.client.common.exception.ErrorCode;
import com.nh.dsh.client.common.exception.ServerException;
import com.nh.dsh.client.enums.CommonStatusEnum;
import com.nh.dsh.client.mapper.UserMapper;
import com.nh.dsh.client.model.entity.UserEntity;
import com.nh.dsh.client.model.vo.UserLoginVO;
import com.nh.dsh.client.service.AuthService;
import com.nh.dsh.client.utils.JwtUtil;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.http.HttpHeaders;
import org.springframework.http.MediaType;
import org.springframework.http.converter.StringHttpMessageConverter;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import java.nio.charset.StandardCharsets;
import java.util.Collections;
import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-06-28 10:09
 **/

@Slf4j
@Service
@AllArgsConstructor
public class AuthServiceImpl implements AuthService {
    private final UserMapper userMapper;
    private final TokenStoreCache tokenStoreCache;

    // final static String APP_ID = "wx731630b450248376";
    // final static String APP_SECRET = "65f6d70befb283d461486a63922652e6";
    final static String APP_ID = "wx0055deef26d951ff";
    final static String APP_SECRET = "02cc1aef64542aba6e45e8c2753c4ba4";

    @Override
    public boolean checkUserEnabled(Integer pkId) {
        return userMapper.selectById(pkId).getDeleteFlag().equals(CommonStatusEnum.NO.getStatus());
    }

    @Override
    public UserLoginVO login(String code) {
        log.info("微信登录: {}", code);
        String urlForAK = "https://api.weixin.qq.com/sns/oauth2/access_token?" +
                "appid=" + APP_ID +
                "&secret=" + APP_SECRET +
                "&code=" + code +
                "&grant_type=authorization_code";
        RestTemplate restTemplate = new RestTemplate();
        String accessData = restTemplate.getForObject(urlForAK, String.class);
        log.info("accessData: {}", accessData);
        JSONObject accessObj = JSONObject.parseObject(accessData);
        String openid = accessObj.getString("openid");
        String accessToken = accessObj.getString("access_token");
        String urlForUserInfo = "https://api.weixin.qq.com/sns/userinfo?" +
                "access_token=" + accessToken +
                "&openid=" + openid +
                "&lang=zh_CN";
        StringHttpMessageConverter stringConverter = new StringHttpMessageConverter(StandardCharsets.UTF_8);
        stringConverter.setSupportedMediaTypes(Collections.singletonList(MediaType.TEXT_PLAIN));
        // 将StringHttpMessageConverter添加到RestTemplate的消息转换器列表中
        restTemplate.getMessageConverters().add(0, stringConverter);
        // 创建HttpHeaders对象，设置Accept头部的值为"text/plain;charset=UTF-8"
        HttpHeaders headers = new HttpHeaders();
        headers.setAccept(Collections.singletonList(MediaType.TEXT_PLAIN));
        headers.set(HttpHeaders.ACCEPT_CHARSET, "UTF-8");
        String userInfoStr = restTemplate.getForObject(urlForUserInfo, String.class);
        log.info("userInfoStr: {}", userInfoStr);
        JSONObject userInfo = JSON.parseObject(userInfoStr);
        String nickname = userInfo.getString("nickname");
        userInfo.getString("sex");
        String headimgurl = userInfo.getString("headimgurl");
        LambdaQueryWrapper<UserEntity> userQueryWrapper = new LambdaQueryWrapper<>();
        userQueryWrapper.eq(UserEntity::getWxId, openid).eq(UserEntity::getDeleteFlag, CommonStatusEnum.NO);
        List<UserEntity> userEntities = userMapper.selectList(userQueryWrapper);
        if (userEntities.size() > 1) {
            throw new ServerException(ErrorCode.ALREADY_HAS_CHECK);
        }
        UserEntity user;
        if (userEntities.isEmpty()) {
            user = new UserEntity();
            user.setWxId(openid);
            user.setWxName(nickname);
            user.setAvatar(headimgurl);
            userMapper.insert(user);
        } else {
            user = userEntities.get(0);
        }
        log.info("user: {}", JSON.toJSONString(user));
        String token = JwtUtil.createToken(user.getId());
        UserLoginVO userLoginVO = new UserLoginVO();
        userLoginVO.setAccessToken(token);
        userLoginVO.setPkId(user.getId());
        tokenStoreCache.saveUser(token, userLoginVO);
        return userLoginVO;
    }

    @Override
    public void logout(String token) {
        Integer userId = RequestContext.getUserId();
        tokenStoreCache.deleteUserById(userId);
        tokenStoreCache.deleteUser(token);
    }

    @Override
    public String wxVerify(String code) {
        log.info("微信校验: {}", code);
        String urlForAK = "https://api.weixin.qq.com/sns/oauth2/access_token?" +
                "appid=" + APP_ID +
                "&secret=" + APP_SECRET +
                "&code=" + code +
                "&grant_type=authorization_code";
        RestTemplate restTemplate = new RestTemplate();
        String accessData = restTemplate.getForObject(urlForAK, String.class);
        log.info("accessData: {}", accessData);
        JSONObject accessObj = JSONObject.parseObject(accessData);
        return accessObj.getString("openid");
    }
}
