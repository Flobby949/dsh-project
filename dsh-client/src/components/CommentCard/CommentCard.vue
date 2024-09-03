<template>
  <uni-card :title="comment.username" :isFull="true" :sub-title="comment.createTime" :extra="`[ ${comment.forumName} ]`" :thumbnail="comment.avatar" @click="commentDetail">
    <view class="content">{{ comment.content }}</view>
    <view class="img" v-if="comment.fileType === 0">
      <image v-for="(item, index) in comment.files" :key="index" :src="item" class="comment-img" @click="previewCommentImage(index)" />
    </view>
    <view class="img" v-if="comment.fileType === 1">
      <view  @click="audioPlay(comment)"  class="voice-box">
        <view v-if="startPlayFlag"  class="voice-bg voice-play" ></view>
        <view v-if="!startPlayFlag"  class="voice-bg" ></view>
      </view>
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
      <view class="reply" v-if="comment.replyList != null && comment.replyList.length > 0 && showReply">
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
import { ref } from 'vue'

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
const startPlayFlag = ref(false)
const audioPlay = (comment) => {
  const innerAudioContext = uni.createInnerAudioContext();
  innerAudioContext.autoplay = true;
  innerAudioContext.src = comment.files[0];
  innerAudioContext.onPlay(() =>{
    //播放开始
    startPlayFlag.value = !startPlayFlag.value
  })
  innerAudioContext.onEnded(() => {
		//播放结束
		startPlayFlag.value = !startPlayFlag.value
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
// 语音
	.voice-box {
	  padding-top: 12px;
	  padding-left: 10px;
	  height: 35px;
	  width: 150px;
	  background:#b4b3b3;
	  border-radius: 0 7px 7px;
	}
	
	.voice-bg {
		background: url(data:image/png;base64,iVBORw0KGgoAAAANSUhEUgAAAGAAAAAYCAYAAAAF6fiUAAAAGXRFWHRTb2Z0d2FyZQBBZG9iZSBJbWFnZVJlYWR5ccllPAAAAyZpVFh0WE1MOmNvbS5hZG9iZS54bXAAAAAAADw/eHBhY2tldCBiZWdpbj0i77u/IiBpZD0iVzVNME1wQ2VoaUh6cmVTek5UY3prYzlkIj8+IDx4OnhtcG1ldGEgeG1sbnM6eD0iYWRvYmU6bnM6bWV0YS8iIHg6eG1wdGs9IkFkb2JlIFhNUCBDb3JlIDUuNi1jMDY3IDc5LjE1Nzc0NywgMjAxNS8wMy8zMC0yMzo0MDo0MiAgICAgICAgIj4gPHJkZjpSREYgeG1sbnM6cmRmPSJodHRwOi8vd3d3LnczLm9yZy8xOTk5LzAyLzIyLXJkZi1zeW50YXgtbnMjIj4gPHJkZjpEZXNjcmlwdGlvbiByZGY6YWJvdXQ9IiIgeG1sbnM6eG1wTU09Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC9tbS8iIHhtbG5zOnN0UmVmPSJodHRwOi8vbnMuYWRvYmUuY29tL3hhcC8xLjAvc1R5cGUvUmVzb3VyY2VSZWYjIiB4bWxuczp4bXA9Imh0dHA6Ly9ucy5hZG9iZS5jb20veGFwLzEuMC8iIHhtcE1NOkRvY3VtZW50SUQ9InhtcC5kaWQ6NzlFRDZDRDNENzlFMTFFNkJDN0NFMjA2QTFFRTRDQkIiIHhtcE1NOkluc3RhbmNlSUQ9InhtcC5paWQ6NzlFRDZDRDJENzlFMTFFNkJDN0NFMjA2QTFFRTRDQkIiIHhtcDpDcmVhdG9yVG9vbD0iQWRvYmUgUGhvdG9zaG9wIENDIDIwMTcgKFdpbmRvd3MpIj4gPHhtcE1NOkRlcml2ZWRGcm9tIHN0UmVmOmluc3RhbmNlSUQ9InhtcC5paWQ6MTAxQkEzQ0RENzM2MTFFNjgyMEI5MTNDRkQ0OTM5QUEiIHN0UmVmOmRvY3VtZW50SUQ9InhtcC5kaWQ6MTAxQkEzQ0VENzM2MTFFNjgyMEI5MTNDRkQ0OTM5QUEiLz4gPC9yZGY6RGVzY3JpcHRpb24+IDwvcmRmOlJERj4gPC94OnhtcG1ldGE+IDw/eHBhY2tldCBlbmQ9InIiPz4K4iKVAAACUUlEQVR42uSazytEURTHvTHjR4kaU8xsSDZSdmbjx4oSK8XGQrJlpSwYTSmxEWWhUIpsZK3kD7DRNBuSBZFCNjZ+JPKcV6ecXu/d3sy7595bc+vbfXPue5/749z77o83lm3bZYYFC8RZqAbQAigP2tXNj5aZF7gdkAZNk9+7WvnOCCgxRUCb9n/o1sk3pUH6QDHF/GNsoM+QeYfiy6qkFeLZDBb0GlTB4AAR/xXT9nXxZVa0WCekQd9Y0HOJjg3CHySviiZmfjO3AyIhnu0gBc0wjAIR/wLtW8z87aAOWAI9gqaYRoAff4ZUoi7EKCiUP462j4CdSCrfK4N1Ahpi6I0i/hPa50M4oFB+Dbm/SzXfL5MD4rUogxP8+Itozynm59E+q5ovyuQdHxphWh568XvR5kxq1SEn40L4e0XMA1L4EcEe7RTjLqYdqRf/gezQUwr5LxjXq+aLHPCFcTmTA7z4tutIQhXfLiJPKXyRA/oxzgW8v9DgxU+S62eF/ATGr6r5fg26Corj9RHD4Z0fvwfjS9CbQn4bxrfK+R6TyzxZNk260solTL4i/g3al10TsMXIryA72T7VfK8MnJO8X9CKy14lafXjxx8jFUsSeyUzfxhtPwHPoqTy/TJJMJzJiPgNpJdsuNJizPwztB/q4JtwHN2KW3sn3HuMOouR30l6bbsOvgkOyGIBnaPbRldalJl/h2knuvgmOKAWNAFKMUz4Iv4O6Z1xXXxTPxtazHy6khnVyS/Fb8IDpHGyuvmWgX9L4Q4toDnQFWhNN/9PgAEAR4w1ULjdCbEAAAAASUVORK5CYII=) right 0 no-repeat;
		width: 24px;
	  height: 24px;
	  background-size: 400%;
	}
	
	.voice-play {
	  animation-name: voicePlay;
	  animation-duration: 1s;
	  animation-direction: normal;
	  animation-iteration-count: infinite;
	  animation-timing-function: steps(3);
	}
	
	@keyframes voicePlay {
	  0% {
	    background-position: 0;
	  }
	  100% {
	    background-position: 100%;
	  }
	}
</style>
