<template>
  <view class="container">
    <scroll-view
      enable-back-to-top
      refresher-enabled
      @refresherrefresh="onRefresherrefresh"
      :refresher-triggered="isTriggered"
      @scrolltolower="onScrolltolower"
      class="scroll-view"
      scroll-y
    >
      <view class="card" v-for="(item, index) in commentList" :key="index">
        <comment-card :comment="item"></comment-card>
      </view>
    </scroll-view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { starCommentList, reviewCommentList, myCommentList } from '@/service/user'
import CommentCard from '../../components/CommentCard/CommentCard.vue'

const props = defineProps({
  commentType: {
    type: Number,
    require: true,
  },
})
const titleArr = ['我发布的', '我回复的', '我收藏的']
onLoad(() => {
  getActionList()
  uni.setNavigationBarTitle({
		title: titleArr[props.commentType - 1],
	});
})

const params = ref({
  page: 1,
  limit: 8,
})
const totalNum = ref()
const commentList = ref()
const getActionList = async () => {
  console.log(props.commentType);
  console.log(props.commentType == 1);
  if (props.commentType == 1) {
    // 发布
    let res = await myCommentList(params.value)
    console.log(res)
    if (params.value.page === 1) {
      commentList.value = res.data.list
    } else {
      commentList.value = commentList.value.concat(res.data.list)
    }
    totalNum.value = res.data.total
  } else if (props.commentType == 2) {
    // 回复
    let res = await reviewCommentList(params.value)
    console.log(res)
    if (params.value.page === 1) {
      commentList.value = res.data.list
    } else {
      commentList.value = commentList.value.concat(res.data.list)
    }
    totalNum.value = res.data.total
  } else if (props.commentType == 3) {
    // 收藏
    let res = await starCommentList(params.value)
    console.log(res)
    if (params.value.page === 1) {
      commentList.value = res.data.list
    } else {
      commentList.value = commentList.value.concat(res.data.list)
    }
    totalNum.value = res.data.total
  }
}

const onRefresherrefresh = async () => {
  console.log('refresh')
  isTriggered.value = true
  params.value.page = 1
  await getActionList()
  isTriggered.value = false
}

// 是否触发下拉刷新
const isTriggered = ref(false)

// 滚动到底部
const onScrolltolower = () => {
  console.log('bottom')
  params.value.page++
  if (commentList.value.length < totalNum.value) {
    getActionList()
  } else {
    uni.showToast({
      icon: 'error',
      duration: 300,
      title: '没有更多记录！',
    })
  }
}
</script>

<style lang="scss" scoped>
page {
  background-color: #f9f9f9;
}
.scroll-view {
  height: 94vh;
  padding: 0 0 10rpx;
}
.container {
  padding: 10rpx;

  .card {
    margin: 20rpx 0;
    border-radius: 10rpx;
  }
}
</style>
