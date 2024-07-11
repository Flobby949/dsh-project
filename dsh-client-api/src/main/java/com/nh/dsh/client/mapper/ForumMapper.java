package com.nh.dsh.client.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.client.model.entity.ForumEntity;
import com.nh.dsh.client.model.query.ForumQuery;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-06-19 15:52
 **/

@Mapper
public interface ForumMapper extends BaseMapper<ForumEntity> {

    List<ForumEntity> selectByPage(Page<ForumEntity> page, @Param("params") ForumQuery query);
}
