package com.nh.dsh.client.service.impl;

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
    public String exchangeBookLink(String cardNum, String openId) {
        Long count = userMapper.selectCount(new LambdaQueryWrapper<UserEntity>().eq(UserEntity::getWxId, openId));
        if (count != 1) {
            log.error("不是本系统的用户,openId:{}", openId);
            throw new ServerException("不是本系统的用户");
        }
        List<BookExchangeEntity> list = baseMapper.selectList(new LambdaQueryWrapper<BookExchangeEntity>()
                .eq(BookExchangeEntity::getVerifyCode, cardNum));
        if (list.size() != 1) {
            log.error("防伪码错误,{},查询得到结果： {}", cardNum, list);
            throw new ServerException("防伪码错误");
        }
        BookExchangeEntity bookExchange = list.get(0);
        // 防伪码已被使用，且不是当前用户使用
        if (bookExchange.getStatus() != 0 && !Objects.equals(bookExchange.getUserFlag(), openId)) {
            log.error("防伪码已被使用,{}", cardNum);
            throw new ServerException("防伪码已被使用");
        }
        // 判断用户是否兑换过其他防伪码
        String bookLink = checkRepeatExchange(bookExchange, openId);
        if (bookLink != null) {
            return bookLink;
        }
        bookExchange.setStatus(1);
        bookExchange.setUserFlag(openId);
        bookExchange.setExchangeTime(new Date());
        baseMapper.updateById(bookExchange);
        return bookExchange.getBookLink();
    }

    private String checkRepeatExchange(BookExchangeEntity bookExchange, String openId) {
        Integer bookId = bookExchange.getBookId();
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, bookId);
        wrapper.eq(BookExchangeEntity::getUserFlag, openId);
        List<BookExchangeEntity> list = baseMapper.selectList(wrapper);
        if (list.isEmpty()) {
            return null;
        }
        BookExchangeEntity bookExchangeEntity = list.get(0);
        return bookExchangeEntity.getBookLink();
    }
}
