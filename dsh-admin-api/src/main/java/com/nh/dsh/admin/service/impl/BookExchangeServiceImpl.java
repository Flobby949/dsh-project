package com.nh.dsh.admin.service.impl;

import com.alibaba.excel.EasyExcel;
import com.alibaba.excel.read.listener.PageReadListener;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.exception.ServerException;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.mapper.BookExchangeMapper;
import com.nh.dsh.admin.model.dto.BookExchangeDTO;
import com.nh.dsh.admin.model.entity.BookExchangeEntity;
import com.nh.dsh.admin.model.query.BookExchangeQuery;
import com.nh.dsh.admin.service.BookExchangeService;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-30 15:38
 **/

@Service
public class BookExchangeServiceImpl extends BaseServiceImpl<BookExchangeMapper, BookExchangeEntity> implements BookExchangeService {

    @Override
    public PageResult<BookExchangeEntity> page(BookExchangeQuery query) {
        Page<BookExchangeEntity> page = new Page<>(query.getPage(), query.getLimit());
        LambdaQueryWrapper<BookExchangeEntity> wrapper = new LambdaQueryWrapper<>();
        wrapper.eq(BookExchangeEntity::getBookId, query.getBookId());
        Page<BookExchangeEntity> result = this.page(page, wrapper);
        return new PageResult<>(result.getRecords(), result.getTotal());
    }

    @Override
    public void exchange(Integer id) {
        BookExchangeEntity bookExchange = baseMapper.selectById(id);
        if (bookExchange == null) {
            throw new ServerException("兑换不存在");
        }
        if (bookExchange.getStatus() != 0) {
            throw new ServerException("该资源已被兑换");
        }
        bookExchange.setStatus(1);
        bookExchange.setExchangeTime(new Date());
        baseMapper.updateById(bookExchange);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public void bookLinkImport(Integer bookId, MultipartFile file) {
        List<BookExchangeEntity> partialImportList = new ArrayList<>();
        try {
            EasyExcel.read(file.getInputStream(), BookExchangeDTO.class, new PageReadListener<BookExchangeDTO>(dataList -> {
                partialImportList.addAll(dataList.stream().map(item -> {
                    BookExchangeEntity exchange = new BookExchangeEntity();
                    exchange.setBookId(bookId);
                    // 判断url是否是网络链接
                    if (!item.getBookLink().startsWith("http")) {
                        throw new ServerException("资源链接有误");
                    }
                    exchange.setBookLink(item.getBookLink());
                    exchange.setVerifyCode(item.getCardNum());
                    exchange.setStatus(0);
                    return exchange;
                }).toList());
            })).sheet().doRead();
        } catch (IOException e) {
            log.error("导入失败", e);
            throw new ServerException("导入失败");
        }
        this.saveBatch(partialImportList);
    }
}
