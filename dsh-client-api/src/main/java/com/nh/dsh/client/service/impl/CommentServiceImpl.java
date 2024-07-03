package com.nh.dsh.client.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import com.nh.dsh.client.common.cache.RequestContext;
import com.nh.dsh.client.common.exception.ServerException;
import com.nh.dsh.client.convert.CommentConvert;
import com.nh.dsh.client.enums.UserActionEnum;
import com.nh.dsh.client.mapper.CommentMapper;
import com.nh.dsh.client.mapper.UserMapper;
import com.nh.dsh.client.model.BaseServiceImpl;
import com.nh.dsh.client.model.dto.CommentActionDTO;
import com.nh.dsh.client.model.dto.CommentDTO;
import com.nh.dsh.client.model.entity.CommentEntity;
import com.nh.dsh.client.model.entity.ForumEntity;
import com.nh.dsh.client.model.entity.UserEntity;
import com.nh.dsh.client.model.vo.CommentItemVO;
import com.nh.dsh.client.service.CommentService;
import com.nh.dsh.client.service.ForumService;
import com.nh.dsh.client.service.UserActionService;
import com.nh.dsh.client.utils.DateUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.*;
import java.util.stream.Collectors;

/**
 * @author : Flobby
 * @program : dsh-client-api
 * @description :
 * @create : 2024-07-02 10:33
 **/

@Service
@AllArgsConstructor
public class CommentServiceImpl extends BaseServiceImpl<CommentMapper, CommentEntity> implements CommentService {
    private final UserActionService userActionService;
    private final UserMapper userMapper;
    private final ForumService forumService;

    @Override
    public void addComment(CommentDTO comment) {
        CommentEntity entity = CommentConvert.INSTANCE.convert(comment);
        entity.setUserId(RequestContext.getUserId());
        baseMapper.insert(entity);
    }

    @Override
    public List<CommentItemVO> queryForumCommentList(Integer forumId) {
        Integer userId = RequestContext.getUserId();

        // 一次性加载所有评论
        LambdaQueryWrapper<CommentEntity> commentQueryWrapper = new LambdaQueryWrapper<>();
        commentQueryWrapper.eq(CommentEntity::getForumId, forumId)
                .orderByAsc(CommentEntity::getCreateTime);

        List<CommentEntity> allComments = baseMapper.selectList(commentQueryWrapper);

        // 获取所有涉及到的用户ID
        Set<Integer> userIds = allComments.stream()
                .map(CommentEntity::getUserId)
                .collect(Collectors.toSet());

        // 批量查询用户信息
        List<UserEntity> users = userMapper.selectBatchIds(userIds);
        Map<Integer, UserEntity> userMap = users.stream()
                .collect(Collectors.toMap(UserEntity::getId, user -> user));

        // 构建 ID 到 CommentItemVO 的映射
        Map<Integer, CommentItemVO> commentMap = new HashMap<>();
        for (CommentEntity comment : allComments) {
            CommentItemVO vo = convertToCommentItemVO(comment, userId, userMap, commentMap);
            commentMap.put(comment.getId(), vo);
        }

        // 构建顶级评论列表
        List<CommentItemVO> topLevelComments = new ArrayList<>();
        for (CommentEntity comment : allComments) {
            if (comment.getParentId() == null) {
                topLevelComments.add(commentMap.get(comment.getId()));
            } else {
                // 追溯到顶级评论
                CommentEntity parent = comment;
                while (parent.getParentId() != null) {
                    CommentEntity finalParent = parent;
                    parent = allComments.stream().filter(c -> c.getId().equals(finalParent.getParentId())).findFirst().orElse(null);
                }
                CommentItemVO topLevelCommentVO = commentMap.get(parent.getId());
                if (topLevelCommentVO != null) {
                    topLevelCommentVO.getReplyList().add(commentMap.get(comment.getId()));
                }
            }
        }

        return topLevelComments;
    }

    // 转换 CommentEntity 为 CommentItemVO
    private CommentItemVO convertToCommentItemVO(CommentEntity entity, Integer userId, Map<Integer, UserEntity> userMap, Map<Integer, CommentItemVO> commentMap) {
        CommentItemVO vo = new CommentItemVO();
        vo.setId(entity.getId());
        vo.setParentId(entity.getParentId());

        if (entity.getParentId() != null) {
            CommentItemVO parentVO = commentMap.get(entity.getParentId());
            if (parentVO != null) {
                vo.setParentUsername(parentVO.getUsername());
            }
        }

        ForumEntity forum = forumService.getById(entity.getForumId());
        vo.setForumName(forum.getName());
        vo.setType(entity.getType());
        vo.setContent(entity.getContent());
        vo.setUserId(entity.getUserId());
        UserEntity user = userMap.get(entity.getUserId());
        if (user != null) {
            vo.setUsername(user.getWxName());
            vo.setAvatar(user.getAvatar());
        }
        vo.setCreateTime(DateUtil.formatTimeAgo(DateUtil.format(entity.getCreateTime())));
        vo.setLikeNum(userActionService.getActionCount(entity.getId(), UserActionEnum.LIKE_COMMENT));
        vo.setLike(userActionService.checkUserAction(userId, entity.getId(), UserActionEnum.LIKE_COMMENT));
        vo.setStar(userActionService.checkUserAction(userId, entity.getId(), UserActionEnum.STAR_COMMENT));
        vo.setReplyList(new ArrayList<>()); // 初始化回复列表
        return vo;
    }

    @Override
    public void doCommentAction(CommentActionDTO dto) {
        if (dto.getActionType().equals(UserActionEnum.FOLLOW_FORUM.getType())) {
            throw new ServerException("行为类型错误");
        }
        userActionService.doUserAction(RequestContext.getUserId(), dto.getCommentId(), UserActionEnum.getByType(dto.getActionType()));
    }

    @Override
    public void modifyComment(CommentDTO dto) {
        CommentEntity commentEntity = baseMapper.selectById(dto.getId());
        commentEntity.setContent(dto.getContent());
        baseMapper.updateById(commentEntity);
    }

}
