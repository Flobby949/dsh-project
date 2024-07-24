package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.core.conditions.update.LambdaUpdateWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.BookConvert;
import com.nh.dsh.admin.mapper.BookMapper;
import com.nh.dsh.admin.mapper.ForumMapper;
import com.nh.dsh.admin.model.dto.BookDTO;
import com.nh.dsh.admin.model.entity.BookEntity;
import com.nh.dsh.admin.model.entity.CategoryEntity;
import com.nh.dsh.admin.model.entity.ForumEntity;
import com.nh.dsh.admin.model.entity.PublisherEntity;
import com.nh.dsh.admin.model.query.BookQuery;
import com.nh.dsh.admin.model.vo.BookVO;
import com.nh.dsh.admin.security.cache.TokenStoreCache;
import com.nh.dsh.admin.security.user.ManagerDetail;
import com.nh.dsh.admin.service.BookService;
import com.nh.dsh.admin.service.CategoryService;
import com.nh.dsh.admin.service.PublisherService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
    private final PublisherService publisherService;
    private final TokenStoreCache tokenStoreCache;
    private final ForumMapper forumMapper;

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
    @Transactional(rollbackFor = Exception.class)
    public void deleteBookInBatch(List<Integer> ids) {
        if (ids.isEmpty()) {
            return;
        }
        LambdaUpdateWrapper<ForumEntity> wrapper = new LambdaUpdateWrapper<>();
        wrapper.in(ForumEntity::getBookId, ids);
        forumMapper.delete(wrapper);
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<BookVO> page(BookQuery query, String authorization) {
        ManagerDetail user = tokenStoreCache.getUser(authorization);
        Page<BookEntity> entityPage = getPage(query);
        LambdaQueryWrapper<BookEntity> wrapper = new LambdaQueryWrapper<BookEntity>()
                .like(StringUtils.isNotBlank(query.getBookName()), BookEntity::getBookName, "%" + query.getBookName() + "%")
                .like(StringUtils.isNotBlank(query.getWriter()), BookEntity::getWriter, "%" + query.getWriter() + "%")
                .like(StringUtils.isNotBlank(query.getIsbn()), BookEntity::getIsbn, "%" + query.getIsbn() + "%")
                .eq(query.getPublisherId() != null, BookEntity::getPublisherId, query.getPublisherId())
                .in(user.getPublisherIdList() != null && !user.getPublisherIdList().isEmpty(), BookEntity::getPublisherId, user.getPublisherIdList())
                .orderByDesc(BookEntity::getCreateTime);
        Page<BookEntity> pageResult = baseMapper.selectPage(entityPage, wrapper);
        List<BookVO> collectList = pageResult.getRecords().stream().map(item -> {
            BookVO vo = BookConvert.INSTANCE.convert(item);
            CategoryEntity category = categoryService.getById(item.getClassificationId());
            vo.setClassification(category.getName());
            PublisherEntity publisher = publisherService.getById(item.getPublisherId());
            vo.setPublishingHouse(publisher.getName());
            return vo;
        }).collect(Collectors.toList());
        return new PageResult<>(collectList, pageResult.getTotal());
    }

    @Override
    public List<BookVO> selectedList(String authorization) {
        ManagerDetail user = tokenStoreCache.getUser(authorization);
        LambdaQueryWrapper<BookEntity> query = new LambdaQueryWrapper<>();
        query.in(user.getPublisherIdList() != null && !user.getPublisherIdList().isEmpty(), BookEntity::getPublisherId, user.getPublisherIdList());
        return BookConvert.INSTANCE.convertList(list(query));
    }
}
