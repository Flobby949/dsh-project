package com.nh.dsh.admin.service;

import com.baomidou.mybatisplus.extension.service.IService;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.model.entity.BookExchangeEntity;
import com.nh.dsh.admin.model.query.BookExchangeQuery;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-30 15:38
 **/

public interface BookExchangeService extends IService<BookExchangeEntity> {

    void generate(Integer bookId, Integer num);

    PageResult<BookExchangeEntity> page(BookExchangeQuery query);

    void exchange(Integer id);
}
