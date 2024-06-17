package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.BookConvert;
import com.nh.dsh.admin.mapper.BookMapper;
import com.nh.dsh.admin.model.dto.BookDTO;
import com.nh.dsh.admin.model.entity.BookEntity;
import com.nh.dsh.admin.model.entity.CategoryEntity;
import com.nh.dsh.admin.model.query.BookQuery;
import com.nh.dsh.admin.model.vo.BookVO;
import com.nh.dsh.admin.service.BookService;
import com.nh.dsh.admin.service.CategoryService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-17 12:43
 **/

@Slf4j
@Service
@AllArgsConstructor
public class BookServiceImpl extends BaseServiceImpl<BookMapper, BookEntity> implements BookService {
    private final CategoryService categoryService;

    @Override
    public void saveBook(BookDTO dto) {
        BookEntity book = BookConvert.INSTANCE.convert(dto);
        baseMapper.insert(book);
    }

    @Override
    public void updateBook(BookDTO dto) {
        BookEntity book = BookConvert.INSTANCE.convert(dto);
        baseMapper.updateById(book);
    }

    @Override
    public void deleteBookInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<BookVO> page(BookQuery query) {
        Page<BookEntity> entityPage = getPage(query);
        LambdaQueryWrapper<BookEntity> wrapper = new LambdaQueryWrapper<BookEntity>()
                .like(StringUtils.isNotBlank(query.getBookName()), BookEntity::getBookName, "%" + query.getBookName() + "%")
                .orderByDesc(BookEntity::getCreateTime);
        Page<BookEntity> pageResult = baseMapper.selectPage(entityPage, wrapper);
        List<BookVO> collectList = pageResult.getRecords().stream().map(item -> {
            BookVO vo = BookConvert.INSTANCE.convert(item);
            CategoryEntity category = categoryService.getById(item.getClassificationId());
            vo.setClassification(category.getName());
            return vo;
        }).collect(Collectors.toList());
        return new PageResult<>(collectList, pageResult.getTotal());
    }
}
