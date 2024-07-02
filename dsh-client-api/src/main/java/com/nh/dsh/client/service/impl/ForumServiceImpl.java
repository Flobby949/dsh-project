package com.nh.dsh.client.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.nh.dsh.client.common.cache.RequestContext;
import com.nh.dsh.client.common.result.PageResult;
import com.nh.dsh.client.convert.ForumConvert;
import com.nh.dsh.client.enums.UserActionEnum;
import com.nh.dsh.client.mapper.BookMapper;
import com.nh.dsh.client.mapper.ForumMapper;
import com.nh.dsh.client.mapper.UserMapper;
import com.nh.dsh.client.model.BaseServiceImpl;
import com.nh.dsh.client.model.entity.BookEntity;
import com.nh.dsh.client.model.entity.ForumEntity;
import com.nh.dsh.client.model.entity.UserEntity;
import com.nh.dsh.client.model.query.ForumQuery;
import com.nh.dsh.client.model.vo.ForumDetailVO;
import com.nh.dsh.client.model.vo.ForumListItemVO;
import com.nh.dsh.client.service.ForumService;
import com.nh.dsh.client.service.UserActionService;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.Comparator;
import java.util.List;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-02 10:55
 **/

@Slf4j
@Service
@AllArgsConstructor
public class ForumServiceImpl extends BaseServiceImpl<ForumMapper, ForumEntity> implements ForumService {
    private final UserMapper userMapper;
    private final BookMapper bookMapper;
    private final UserActionService userActionService;

    @Override
    public PageResult<ForumListItemVO> forumList(ForumQuery query) {
        Page<ForumEntity> page = getPage(query);
        LambdaQueryWrapper<ForumEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.orderByDesc(ForumEntity::getCreateTime);
        Page<ForumEntity> pageResult = baseMapper.selectPage(page, queryWrapper);
        List<ForumListItemVO> resultList = pageResult.getRecords().stream().map(item -> {
            ForumListItemVO vo = ForumConvert.INSTANCE.convert(item);
            vo.setFollowCount(userActionService.getActionCount(item.getId(), UserActionEnum.FOLLOW_FORUM));
            return vo;
        }).sorted(Comparator.comparing(ForumListItemVO::getFollowCount)).toList();
        return new PageResult<>(resultList, pageResult.getTotal());
    }

    @Override
    public ForumDetailVO forumDetail(Integer id) {
        ForumEntity entity = baseMapper.selectById(id);
        ForumDetailVO forumDetailVO = ForumConvert.INSTANCE.convertDetail(entity);
        UserEntity userEntity = userMapper.selectById(entity.getUserId());
        forumDetailVO.setUsername(userEntity.getWxName());
        BookEntity bookEntity = bookMapper.selectById(entity.getBookId());
        forumDetailVO.setBookName(bookEntity.getBookName());
        forumDetailVO.setBookIntroduction(bookEntity.getBookIntroduction());
        forumDetailVO.setFollowCount(userActionService.getActionCount(entity.getId(), UserActionEnum.FOLLOW_FORUM));
        forumDetailVO.setFollow(userActionService.checkUserAction(RequestContext.getUserId(), entity.getId(), UserActionEnum.FOLLOW_FORUM));
        return forumDetailVO;
    }

    @Override
    public void followedForum(Integer forumId) {
        userActionService.doUserAction(RequestContext.getUserId(), forumId, UserActionEnum.FOLLOW_FORUM);
    }

    @Override
    public PageResult<ForumListItemVO> forumListFollowed(ForumQuery query) {
        List<Integer> sourceIdList = userActionService.getActionList(RequestContext.getUserId(), UserActionEnum.FOLLOW_FORUM);
        if (sourceIdList.isEmpty()) {
            return new PageResult<>(List.of(), 0L);
        }
        Page<ForumEntity> page = getPage(query);
        LambdaQueryWrapper<ForumEntity> queryWrapper = new LambdaQueryWrapper<>();
        queryWrapper.in(ForumEntity::getId, sourceIdList).orderByDesc(ForumEntity::getCreateTime);
        Page<ForumEntity> pageResult = baseMapper.selectPage(page, queryWrapper);
        List<ForumListItemVO> resultList = pageResult.getRecords().stream().map(item -> {
            ForumListItemVO vo = ForumConvert.INSTANCE.convert(item);
            vo.setFollowCount(userActionService.getActionCount(item.getId(), UserActionEnum.FOLLOW_FORUM));
            return vo;
        }).sorted(Comparator.comparing(ForumListItemVO::getFollowCount)).toList();
        return new PageResult<>(resultList, pageResult.getTotal());
    }
}
