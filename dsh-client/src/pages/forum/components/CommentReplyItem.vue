<template>
  <uni-card class="reply-card" :title="reply.username" :isFull="true" :extra="reply.createTime" :thumbnail="reply.avatar">
    <view class="content" v-if="reply.parentId === parentId">
      {{ reply.content }}
      <view v-if="reply.fileType === 1">
        <view  @click="audioPlay(reply)"  class="voice-box">
          <view v-if="startPlayFlag"  class="voice-bg voice-play" ></view>
          <view v-if="!startPlayFlag"  class="voice-bg" ></view>
        </view>
      </view>
    </view>
    <view class="reply-item" v-else >
       回复
      <text style="color: rgb(33, 116, 212);">{{ reply.parentUsername }}</text>
      ：
      <text>{{ reply.content }}</text>
       <view v-if="reply.fileType === 1">
        <view  @click="audioPlay(reply)"  class="voice-box">
          <view v-if="startPlayFlag"  class="voice-bg voice-play" ></view>
          <view v-if="!startPlayFlag"  class="voice-bg" ></view>
        </view>
      </view>
    </view>
    <view slot="actions" class="card-actions">
        <view class="card-actions-item" @click.stop="actionsClick(1)">
          <uni-icons v-if="!reply.like" type="heart" size="20" color="#999"></uni-icons>
          <uni-icons v-else type="heart-filled" size="20" color="red"></uni-icons>
        </view>
        <view class="card-actions-item" @click.stop="actionsClick(2)">
          <uni-icons v-if="!reply.star" type="star" size="20" color="#999"></uni-icons>
          <uni-icons v-else type="star-filled" size="20" color="#edd20a"></uni-icons>
        </view>
    </view>
  </uni-card>
</template>

<script setup>
import { doCommentAction } from '@/service/forum'
import { ref } from 'vue'

const props = defineProps({
  reply: {
    type: Object,
    require: true
  },
  parentId: {
    type: Number,
    require: true
  }
})
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
    commentId: props.reply.id,
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
    props.reply.like = !props.reply.like
  } else {
    props.reply.star = !props.reply.star
  }
  uni.showToast({duration: 300})
}
</script>

<style scoped lang="scss">
// 语音
	.voice-box {
	  padding-top: 12px;
	  padding-left: 10px;
	  height: 35px;
	  width: 150px;
	  background:#b4b3b3;
	  border-radius: 0 7px 7px;
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
	}
	@keyframes voicePlay {
	  0% {
	    background-position: 0;
	  }
	  100% {
	    background-position: 100%;
	  }
	}
.card-actions {
  display: flex;
  padding: 10rpx 10rpx 0;
  justify-content: end;
  align-items: center;

  .card-actions-item {
    margin: 0 20rpx;
  }
}

</style>
