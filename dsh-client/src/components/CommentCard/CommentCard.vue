<template>
  <uni-card :title="comment.username" :isFull="true" :sub-title="comment.createTime" :extra="`[ ${comment.forumName} ]`" :thumbnail="comment.avatar" @click="commentDetail">
    <view class="content">{{ comment.content }}</view>
    <view class="img" v-if="comment.fileType === 0">
      <image v-for="(item, index) in comment.files" :key="index" :src="item" class="comment-img" @click="previewCommentImage(index)" />
    </view>
    <view slot="actions" class="card-actions">
      <view class="action-bar">
        <view class="card-actions-item" @click.stop="actionsClick(1)">
          <uni-icons v-if="!comment.like" type="heart" size="20" color="#999"></uni-icons>
          <uni-icons v-else type="heart-filled" size="20" color="red"></uni-icons>
          <text class="card-actions-item-text">{{ comment.likeNum > 0 ? comment.likeNum : '点赞' }}</text>
        </view>
        <view class="card-actions-item" @click.stop="actionsClick(2)">
          <uni-icons v-if="!comment.star" type="star" size="20" color="#999"></uni-icons>
          <uni-icons v-else type="star-filled" size="20" color="#edd20a"></uni-icons>
          <text class="card-actions-item-text">收藏</text>
        </view>
      </view>
      <view class="reply" v-if="comment.replyList.length > 0 && showReply">
        <view v-for="(item, index) in comment.replyList" :key="index">
          <view class="reply-item" v-if="item.parentId === comment.id" >
            <text style="color: rgb(33, 116, 212);">{{ item.username }}</text>
            ：
            <text>{{ item.content }}</text>
          </view>
          <view class="reply-item" v-else >
            <text style="color: rgb(33, 116, 212);">{{ item.username }}</text>
             回复
            <text style="color: rgb(33, 116, 212);">{{ item.parentUsername }}</text>
            ：
            <text>{{ item.content }}</text>
          </view>
        </view>
      </view>
    </view>
  </uni-card>
</template>

<script setup>
import { doCommentAction } from '@/service/forum'

const props = defineProps({
  comment: {
    type: Object,
    required: true,
  },
  showReply: {
    type: Boolean,
    default: true
  },
  clickable: {
    type: Boolean,
    default: true
  }
})

const commentDetail = () => {
  if (!props.clickable) return
  uni.navigateTo({
     url: '/pages/forum/CommentDetail?id=' + props.comment.id
  });
}

const actionsClick = async (params) => {
  // 1-点赞，2-收藏
  const { code } = await doCommentAction({
    commentId: props.comment.id,
    actionType: params
  })
  if (code !== 0) {
    uni.showToast({
      icon: 'error',
      duration: 300
    })
    return
  }
  if (params === 1) {
    // 点赞
    props.comment.like = !props.comment.like
    props.comment.like ? props.comment.likeNum++ : props.comment.likeNum--
  } else {
    props.comment.star = !props.comment.star
  }
  uni.showToast({duration: 300})
}

const previewCommentImage = (index) => {
  uni.previewImage({
                urls: props.comment.files,
                current: index, // 当前显示图片的索引
                indicator: 'default' // 图片指示器样式，默认为圆点
            })
}
</script>

<style lang="scss" scoped>
.content {
  padding: 10rpx;
}
.card-actions {

  .action-bar {
    display: flex;
    flex-direction: row;
    justify-content: space-around;
    align-items: center;
    height: 45px;
    border-top: 1px #eee solid;

    .card-actions-item {
      display: flex;
      flex-direction: row;
      align-items: center;
    }
    .card-actions-item-text {
      font-size: 14px;
      color: #666;
      margin-left: 5px;
    }
  }

  .reply {
    border-top: 1px #eee solid;
    padding: 20rpx;
    min-height: 100rpx;

    .reply-item {
      line-height: 1.5;
    }
  }
}
.comment-img {
  height: 100rpx;
  width: 100rpx;
  border: 1rpx solid #bcbcbc;
  margin: 10rpx;
}
</style>
