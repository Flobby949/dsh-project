package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.exception.ServerException;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.mapper.BookExchangeMapper;
import com.nh.dsh.admin.model.entity.BookExchangeEntity;
import com.nh.dsh.admin.model.query.BookExchangeQuery;
import com.nh.dsh.admin.service.BookExchangeService;
import org.springframework.stereotype.Service;

import java.util.Date;
import java.util.List;
import java.util.concurrent.ArrayBlockingQueue;
import java.util.concurrent.ThreadPoolExecutor;
import java.util.concurrent.TimeUnit;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-30 15:38
 **/

@Service
public class BookExchangeServiceImpl extends BaseServiceImpl<BookExchangeMapper, BookExchangeEntity> implements BookExchangeService {
    public static ThreadPoolExecutor generateExecutor = new ThreadPoolExecutor(
            2,
            8,
            30, TimeUnit.SECONDS, new ArrayBlockingQueue<>(10)
            , r -> {
        Thread thread = new Thread(r);
        thread.setName("generate-book-exchange-thread");
        return thread;
    }
    );

    @Override
    public void generate(Integer bookId, Integer num) {
        // 异步任务插入num次
        generateExecutor.execute(() -> {
            for (int i = 0; i < num; i++) {
                BookExchangeEntity bookExchangeEntity = new BookExchangeEntity();
                bookExchangeEntity.setBookId(bookId);
                bookExchangeEntity.setStatus(0);
                this.save(bookExchangeEntity);
            }
        });
    }

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
}
