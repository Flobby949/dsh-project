package com.nh.dsh.client.service.impl;

import cn.hutool.core.codec.Base64Decoder;
import cn.hutool.crypto.SecureUtil;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.nh.dsh.client.common.exception.ServerException;
import com.nh.dsh.client.mapper.BookExchangeMapper;
import com.nh.dsh.client.mapper.UserMapper;
import com.nh.dsh.client.model.BaseServiceImpl;
import com.nh.dsh.client.model.entity.BookExchangeEntity;
import com.nh.dsh.client.model.entity.UserEntity;
import com.nh.dsh.client.service.BookExchangeService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.Objects;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-30 17:43
 **/

@Slf4j
@Service
@AllArgsConstructor
public class BookExchangeServiceImpl extends BaseServiceImpl<BookExchangeMapper, BookExchangeEntity> implements BookExchangeService {
    private final UserMapper userMapper;

    @Override
    public String exchangeBookLink(String cardNum, String openId, String verifyCode) {
        Long count = userMapper.selectCount(new LambdaQueryWrapper<UserEntity>().eq(UserEntity::getWxId, openId));
        if (count != 1) {
            log.error("不是本系统的用户,openId:{}", openId);
            throw new ServerException("不是本系统的用户");
        }
        String[] decryptStr = SecureUtil
                .aes("dianhuiyun123456".getBytes())
                .decryptStr(cardNum).split("&");
        BookExchangeEntity bookExchange = baseMapper.selectById(decryptStr[1]);
        if (StringUtils.isNotBlank(verifyCode) && bookExchange.getVerifyCode().equals(verifyCode)) {
            log.error("防伪码错误,{},查询得到结果： {}", verifyCode, bookExchange);
            throw new ServerException("防伪码错误");
        }
        // 防伪码已被使用，且不是当前用户使用
        if (bookExchange.getStatus() != 0 && !Objects.equals(bookExchange.getUserFlag(), openId)) {
            log.error("防伪码已被使用,{}", verifyCode);
            throw new ServerException("防伪码已被使用");
        }
        // 判断用户是否兑换过其他防伪码
        return checkRepeatExchange(bookExchange, openId);
    }

    @Override
    public String checkVerifyCodeAvailable(String cardNum, String openId) {
        if (StringUtils.isBlank(cardNum)) {
            return null;
        }
        Long count = userMapper.selectCount(new LambdaQueryWrapper<UserEntity>().eq(UserEntity::getWxId, openId));
        if (count != 1) {
            log.error("不是本系统的用户,openId:{}", openId);
            throw new ServerException("不是本系统的用户");
        }
        String[] decryptStr = SecureUtil
                .aes("dianhuiyun123456".getBytes())
                .decryptStr(Base64Decoder.decode(cardNum)).split("&");
        BookExchangeEntity bookExchange = baseMapper.selectById(decryptStr[1]);
        if (bookExchange == null) {
            return null;
        }
        // 如果有防伪码，返回空值
        if (StringUtils.isNotBlank(bookExchange.getVerifyCode())) {
            return null;
        }
        // 没有防伪码，证明不需要验证，直接返回链接
        return checkRepeatExchange(bookExchange, openId);
    }

    /**
     * 获取最终返回的书链，同时记录兑换信息
     *
     * @param bookExchange 图书交换
     * @param openId       微信 ID
     * @return {@link String }
     */
    private String checkRepeatExchange(BookExchangeEntity bookExchange, String openId) {
        // 查询本书是否被当前用户兑换过
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, bookExchange.getBookId());
        wrapper.eq(BookExchangeEntity::getUserFlag, openId);
        List<BookExchangeEntity> list = baseMapper.selectList(wrapper);
        if (!list.isEmpty()) {
            // 当前用户已经兑换过，直接返回
            return list.get(0).getBookLink();
        }
        // 如果为空，说明没有被当前用户兑换过，记录信息
        bookExchange.setStatus(1);
        bookExchange.setUserFlag(openId);
        bookExchange.setExchangeTime(new Date());
        baseMapper.updateById(bookExchange);
        return bookExchange.getBookLink();
    }

    // public static void main(String[] args) {
    //     //   /RkqR7Q78tDxWF8fgtRoAw==
    //     System.out.println(SecureUtil.aes("dianhuiyun123456".getBytes()).decryptStr(Base64Decoder.decode("/RkqR7Q78tDxWF8fgtRoAw==")));
    // }
}
