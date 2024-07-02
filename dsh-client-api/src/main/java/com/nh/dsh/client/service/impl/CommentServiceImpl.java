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
import com.nh.dsh.client.model.vo.CommentItemVO;
import com.nh.dsh.client.service.CommentService;
import com.nh.dsh.client.service.UserActionService;
import com.nh.dsh.client.utils.DateUtil;
import lombok.AllArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.LinkedList;
import java.util.List;
import java.util.Queue;
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

    @Override
    public void addComment(CommentDTO comment) {
        CommentEntity entity = CommentConvert.INSTANCE.convert(comment);
        entity.setUserId(RequestContext.getUserId());
        baseMapper.insert(entity);
    }

    @Override
    public List<CommentItemVO> queryForumCommentList(Integer forumId) {
        Integer userId = RequestContext.getUserId();
        LambdaQueryWrapper<CommentEntity> commentQueryWrapper = new LambdaQueryWrapper<>();
        commentQueryWrapper.eq(CommentEntity::getForumId, forumId)
                .isNull(CommentEntity::getParentId)
                .orderByDesc(CommentEntity::getCreateTime);

        List<CommentEntity> topLevelComments = baseMapper.selectList(commentQueryWrapper);

        return topLevelComments.stream().map(item -> {
            CommentItemVO vo = convertToCommentItemVO(item, userId);
            vo.setReplyList(getAllReplies(item.getId(), userId)); // 获取所有回复并平铺
            return vo;
        }).collect(Collectors.toList());
    }

    // 获取所有直接或间接回复并平铺
    private List<CommentItemVO> getAllReplies(Integer parentId, Integer userId) {
        List<CommentItemVO> allReplies = new ArrayList<>();
        Queue<Integer> queue = new LinkedList<>();
        queue.add(parentId);

        while (!queue.isEmpty()) {
            Integer currentParentId = queue.poll();
            LambdaQueryWrapper<CommentEntity> replyQueryWrapper = new LambdaQueryWrapper<>();
            replyQueryWrapper.eq(CommentEntity::getParentId, currentParentId)
                    .orderByDesc(CommentEntity::getCreateTime);

            List<CommentEntity> replies = baseMapper.selectList(replyQueryWrapper);

            for (CommentEntity reply : replies) {
                CommentItemVO replyVO = convertToCommentItemVO(reply, userId);
                allReplies.add(replyVO);
                queue.add(reply.getId()); // 将当前回复的ID加入队列，以便获取其子回复
            }
        }

        return allReplies;
    }

    // 转换 CommentEntity 为 CommentItemVO
    private CommentItemVO convertToCommentItemVO(CommentEntity entity, Integer userId) {
        CommentItemVO vo = new CommentItemVO();
        vo.setId(entity.getId());
        vo.setParentId(entity.getParentId());
        vo.setType(entity.getType());
        vo.setContent(entity.getContent());
        vo.setUserId(entity.getUserId());
        vo.setUsername(userMapper.selectById(entity.getUserId()).getWxName());
        vo.setCreateTime(DateUtil.formatTimeAgo(DateUtil.format(entity.getCreateTime())));
        vo.setLikeNum(userActionService.getActionCount(entity.getId(), UserActionEnum.LIKE_COMMENT));
        vo.setLike(userActionService.checkUserAction(userId, entity.getId(), UserActionEnum.LIKE_COMMENT));
        vo.setStar(userActionService.checkUserAction(userId, entity.getId(), UserActionEnum.STAR_COMMENT));
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
