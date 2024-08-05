package com.nh.dsh.client.service.impl;

import com.nh.dsh.client.common.config.CodeConfig;
import com.nh.dsh.client.common.exception.ServerException;
import com.nh.dsh.client.mapper.BookResourceMapper;
import com.nh.dsh.client.model.BaseServiceImpl;
import com.nh.dsh.client.model.dto.CodeDTO;
import com.nh.dsh.client.model.entity.BookResourceEntity;
import com.nh.dsh.client.service.BookResourceService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-08-05 22:55
 **/

@Slf4j
@Service
@AllArgsConstructor
public class BookResourceServiceImpl extends BaseServiceImpl<BookResourceMapper, BookResourceEntity> implements BookResourceService {
    private final CodeConfig codeConfig;

    @Override
    public String checkBookResource(CodeDTO dto) {
        if (!dto.getCodeSecret().equals(codeConfig.getSecret())) {
            this.invalidCode(dto.getResourceId());
            throw new ServerException("codeSecret error");
        }
        BookResourceEntity bookResourceEntity = baseMapper.selectById(dto.getResourceId());
        return bookResourceEntity.getLink();
    }

    private void invalidCode(Integer resourceId) {
        BookResourceEntity bookResourceEntity = baseMapper.selectById(resourceId);
        bookResourceEntity.setValidStatus(1);
        baseMapper.updateById(bookResourceEntity);
    }
}
