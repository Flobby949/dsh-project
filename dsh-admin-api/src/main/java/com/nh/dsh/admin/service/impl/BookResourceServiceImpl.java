package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.BookResourceConvert;
import com.nh.dsh.admin.mapper.BookResourceMapper;
import com.nh.dsh.admin.model.dto.BookResourceDTO;
import com.nh.dsh.admin.model.entity.BookResourceEntity;
import com.nh.dsh.admin.model.query.BookResourceQuery;
import com.nh.dsh.admin.model.vo.BookResourceVO;
import com.nh.dsh.admin.service.BookResourceService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-18 09:49
 **/

@Service
public class BookResourceServiceImpl extends BaseServiceImpl<BookResourceMapper, BookResourceEntity> implements BookResourceService {

    @Override
    public void save(BookResourceDTO dto) {
        BookResourceEntity bookResource = BookResourceConvert.INSTANCE.convert(dto);
        baseMapper.insert(bookResource);
    }

    @Override
    public void update(BookResourceDTO dto) {
        BookResourceEntity bookResource = BookResourceConvert.INSTANCE.convert(dto);
        baseMapper.updateById(bookResource);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<BookResourceVO> page(BookResourceQuery query) {
        Page<BookResourceEntity> page = getPage(query);
        LambdaQueryWrapper<BookResourceEntity> wrapper = new LambdaQueryWrapper<BookResourceEntity>()
                .eq(BookResourceEntity::getBookId, query.getBookId())
                .orderByDesc(BookResourceEntity::getCreateTime);
        Page<BookResourceEntity> pageResult = baseMapper.selectPage(page, wrapper);
        List<BookResourceVO> vos = BookResourceConvert.INSTANCE.convertList(pageResult.getRecords());
        return new PageResult<>(vos, pageResult.getTotal());
    }
}
