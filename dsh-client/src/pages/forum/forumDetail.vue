<template>
  <view>
    <view class="card">
      <view class="top" @click="toForumDetail">
        <image class="cover" :src="forumDetailInfo.cover"></image>
        <view class="info">
          <view class="bookName">{{ forumDetailInfo.bookName }}</view>
          <view class="count">作者：{{ forumDetailInfo.writer }}</view>
          <view class="count">分类：{{ forumDetailInfo.category }}</view>
        </view>
        <view class="share">
          <uni-icons type="redo" size="24" color="#8e8e8e" @click="shareLink"></uni-icons>
          分享
        </view>
      </view>
      <uni-section title="作者简介" type="line">
        <text-expand>
          <view class="desc">{{ forumDetailInfo.writerIntroduction }}</view>
        </text-expand>
      </uni-section>
      <uni-section title="书本简介" type="line">
        <text-expand>
          <view class="desc">{{ forumDetailInfo.bookIntroduction }}</view>
        </text-expand>
      </uni-section>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import { forumDetail } from '@/service/forum.js'
import TextExpand from '../../components/TextExpand/TextExpand.vue'
import { onLoad } from '@dcloudio/uni-app'

const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
})

onLoad(() => {
  getDetailInfo()
})

const forumDetailInfo = ref()
const getDetailInfo = async() => {
  const { data } = await forumDetail(props.id)
  forumDetailInfo.value = data
}

const shareLink = () => {
  uni.setClipboardData({
    data: window.location.href,
    success: () => {
      uni.showToast({icon: 'none', title: '复制链接成功'})
    }
  });
}
</script>

<style lang="scss" scoped>
page{
  background-color: #f7f7f7;
}
.card {
  display: flex;
  flex-direction: column;
  margin: 10rpx;
  padding: 10rpx;
  background-color: #fff;
  border-radius: 10rpx;

  .top {
    display: flex;
    padding: 20rpx 10rpx;
    border-bottom: 1rpx solid #ddd;

    .cover {
      width: 250rpx;
      height: 350rpx;
      margin: 10rpx;
    }

    .info {
      flex: 1;
      padding: 0 10rpx;

      .bookName {
        font-size: 36rpx;
        font-weight: 700;
        width: 90%;
        display: -webkit-box;
        -webkit-box-orient: vertical;
        -webkit-line-clamp: 2;
        overflow: hidden;
        text-overflow: ellipsis;
      }

      .count {
        margin: 15rpx 0;
        font-size: 24rpx;
        color: #8e8e8e
      }
    }

    .share {
      display: flex;
      font-size: 24rpx;
    }
  }

  .desc {
    padding: 5rpx 20rpx;
    color: #666666;
    font-size: 28rpx;
    line-height: 1.5;
  }
}
</style>
