package com.nh.dsh.admin.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.admin.common.model.BaseServiceImpl;
import com.nh.dsh.admin.common.result.PageResult;
import com.nh.dsh.admin.convert.CategoryConvert;
import com.nh.dsh.admin.mapper.CategoryMapper;
import com.nh.dsh.admin.model.dto.CategoryDTO;
import com.nh.dsh.admin.model.entity.CategoryEntity;
import com.nh.dsh.admin.model.query.CategoryQuery;
import com.nh.dsh.admin.model.vo.CategoryVO;
import com.nh.dsh.admin.service.CategoryService;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-admin-api
 * @description :
 * @create : 2024-06-17 14:37
 **/

@Service
public class CategoryServiceImpl extends BaseServiceImpl<CategoryMapper, CategoryEntity> implements CategoryService {

    @Override
    public void save(CategoryDTO dto) {
        CategoryEntity category = CategoryConvert.INSTANCE.convert(dto);
        baseMapper.insert(category);
    }

    @Override
    public void update(CategoryDTO dto) {
        CategoryEntity category = CategoryConvert.INSTANCE.convert(dto);
        baseMapper.updateById(category);
    }

    @Override
    public void deleteInBatch(List<Integer> ids) {
        baseMapper.deleteBatchIds(ids);
    }

    @Override
    public PageResult<CategoryVO> page(CategoryQuery query) {
        Page<CategoryEntity> entityPage = getPage(query);
        LambdaQueryWrapper<CategoryEntity> wrapper = new LambdaQueryWrapper<CategoryEntity>().orderByDesc(CategoryEntity::getCreateTime);
        Page<CategoryEntity> pageResult = baseMapper.selectPage(entityPage, wrapper);
        return new PageResult<>(CategoryConvert.INSTANCE.convertList(pageResult.getRecords()), pageResult.getTotal());
    }
}
