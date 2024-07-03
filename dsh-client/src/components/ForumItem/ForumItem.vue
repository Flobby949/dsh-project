<template>
     <navigator
      :url="'/pages/forum/forum?id=' + forumInfo.id"
      class="scroll-item"
      :key="forumInfo.id"
    >
  <view class="card-item">
      <image :src="forumInfo.cover" class="cover-img"></image>
      <view class="title">{{ forumInfo.name }}</view>
      <view class="info">{{ forumInfo.followCount }} 人参与</view>
  </view>
    </navigator>
</template>

<script setup>
defineProps({
  forumInfo: {
    type: Object,
    default: {},
  },
})
</script>

<style lang="scss" scoped>
.card-item {
  display: flex;
  flex-direction: column;
  padding: 5rpx;
  margin: 0 10rpx;
  align-items: center;
  justify-content: center;
  width: 200rpx;
  height: 300rpx;
  background-color: #fff;
  box-shadow:  2rpx 2rpx 6rpx #d9d9d9,
             -2rpx -2rpx 6rpx #ffffff;
  border-radius: 10rpx;


  .cover-img {
    margin: 5rpx;
    height: 220rpx;
    width: 180rpx;
  }


  .title {
    font-size: 18rpx;
    font-weight: 700;
    width: 80%;
    color: #000;
    margin: 5rpx;
    white-space: nowrap;
    overflow: hidden;
    text-overflow: ellipsis;
    text-align: center;
  }

  .info {
    font-size: 14rpx;
    color: #878787;
  }
}
</style>
