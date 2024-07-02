<template>
  <view class="navbar" :style="{ paddingTop: safeAreaInsets.top + 10 + 'px' }">
    <view class="logo">
      <text class="logo-text">读书汇</text>
    </view>
    <view class="search" @click="handleSearchClick">
      <text class="icon-search">请输入你想要搜索的书籍</text>
      <text class="icon-scan"></text>
    </view>
  </view>
</template>

<script setup>
// 获取屏幕边界到安全区域距离
const { safeAreaInsets } = uni.getSystemInfoSync()
// 点击搜索框跳转搜索页面
const handleSearchClick = () => {
  uni.navigateTo({
    url: '/pages/search/search',
  })
}
</script>

<style lang="scss" scoped>
/* 自定义导航条 */
.navbar {
  background: linear-gradient(to bottom, transparent, #fff 400rpx),
              linear-gradient(to right, #3faae3 20%, #d5c4bb);
  position: relative;
  display: flex;
  flex-direction: column;
  padding-top: 20px;
  .logo {
    display: flex;
    align-items: center;
    height: 64rpx;
    padding-left: 30rpx;
    .logo-text {
      flex: 1;
      line-height: 28rpx;
      color: #fff;
      margin: 2rpx 0 0 20rpx;
      padding-left: 20rpx;
      border-left: 1rpx solid #fff;
      font-size: 36rpx;
    }
  }
  .search {
    display: flex;
    align-items: center;
    justify-content: space-between;
    padding: 0 10rpx 0 26rpx;
    height: 64rpx;
    margin: 16rpx 20rpx;
    color: #fff;
    font-size: 28rpx;
    border-radius: 32rpx;
    background-color: rgba(255, 255, 255, 0.5);
  }
  .icon-search {
    &::before {
      margin-right: 10rpx;
    }
  }
  .icon-scan {
    font-size: 30rpx;
    padding: 15rpx;
  }
}
</style>
