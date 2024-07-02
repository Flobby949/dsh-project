<template>
  <uni-card :title="comment.user" :isFull="true" :sub-title="comment.createTime" :extra="`[ ${comment.bookName} ]`" :thumbnail="comment.avatar" @click="commentDetail">
    <view class="content">{{ comment.content }}</view>
    <view slot="actions" class="card-actions">
      <view class="card-actions-item" @click.stop="actionsClick('点赞')">
        <uni-icons type="heart" size="20" color="#999"></uni-icons>
        <text class="card-actions-item-text">{{ comment.likeNum > 0 ? comment.likeNum : '点赞' }}</text>
      </view>
      <view class="card-actions-item" @click.stop="actionsClick('收藏')">
        <uni-icons type="star" size="20" color="#999"></uni-icons>
        <text class="card-actions-item-text">收藏</text>
      </view>
    </view>
  </uni-card>
</template>

<script setup>
const props = defineProps({
  comment: {
    type: Object,
    required: true,
  }
})

const commentDetail = () => {
  uni.navigateTo({
     url: '/pages/forum/CommentDetail?id=' + props.comment.id
  });
}

const actionsClick = (params) => {
  console.log(params)
}
</script>

<style lang="scss" scoped>
.content {
  padding: 10rpx;
}
.card-actions {
		display: flex;
		flex-direction: row;
		justify-content: space-around;
		align-items: center;
		height: 45px;
		border-top: 1px #eee solid;
	}
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
</style>
