package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.ForumConvert;
import com.nh.dsh.admin.mapper.ForumMapper;
import com.nh.dsh.admin.model.dto.ForumDTO;
import com.nh.dsh.admin.model.entity.ForumEntity;
import com.nh.dsh.admin.model.query.ForumQuery;
import com.nh.dsh.admin.model.vo.ForumVO;
import com.nh.dsh.admin.security.cache.TokenStoreCache;
import com.nh.dsh.admin.security.user.ManagerDetail;
import com.nh.dsh.admin.service.ForumService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-19 15:53
 **/

@Slf4j
@Service
public class ForumServiceImpl extends BaseServiceImpl<ForumMapper, ForumEntity> implements ForumService {
    private final TokenStoreCache tokenStoreCache;

    public ForumServiceImpl(TokenStoreCache tokenStoreCache) {
        super();
        this.tokenStoreCache = tokenStoreCache;
    }

    @Override
    public void save(ForumDTO dto) {
        ForumEntity entity = ForumConvert.INSTANCE.convert(dto);
        baseMapper.insert(entity);
    }

    @Override
    public void update(ForumDTO dto) {
        ForumEntity entity = ForumConvert.INSTANCE.convert(dto);
        baseMapper.updateById(entity);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<ForumVO> page(ForumQuery query, String authorization) {
        ManagerDetail user = tokenStoreCache.getUser(authorization);
        Page<ForumEntity> page = getPage(query);
        List<ForumVO> resultList = baseMapper.getPage(page, query, user.getPublisherIdList());
        return new PageResult<>(resultList, page.getTotal());
    }
}
