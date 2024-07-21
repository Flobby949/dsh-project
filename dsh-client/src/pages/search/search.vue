<template>
  <view class="searchLayout">
    <view class="search">
      <uni-search-bar
        @confirm="onSearch"
        @cancel="onClear"
        @clear="onClear"
        focus
        placeholder="搜索"
        v-model="queryParams.keyword"
      >
      </uni-search-bar>
    </view>
    <!-- 历史记录 -->
    <view class="history" v-if="historySearch.length">
      <view class="topTitle">
        <view class="text">最近搜索</view>
        <view class="icon" @tap="removeHistory">
          <uni-icons type="trash" size="25"></uni-icons>
        </view>
      </view>
      <view class="tabs">
        <view class="tab" v-for="tab in historySearch" :key="tab" @tap="clickHistoryTab(tab)">{{
          tab
        }}</view>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'

// 搜索内容
const queryParams = ref({
  keyword: ''
})

//点击清除按钮 重置搜索内容
const onClear = () => {
  queryParams.value.keyword = ''
}

//点击搜索
const onSearch = res => {
  console.log(res)
  if (res.value) {
    addHistory(res.value)
  }
}

// 添加历史搜索
const addHistory = value => {
  // 去重处理
  historySearch.value = [...new Set([value, ...historySearch.value])].slice(0, 10)
  uni.setStorageSync('historySearch', historySearch.value)
  // 跳转到搜索结果页面
  uni.navigateBack({
     delta: 1
  });
  // 初始化搜索参数
  onClear()
}

// 搜索历史
const historySearch = ref(uni.getStorageSync('historySearch') || [])

//点击清空搜索记录
const removeHistory = () => {
  uni.showModal({
    title: '是否清空历史搜索？',
    success: res => {
      if (res.confirm) {
        uni.removeStorageSync('historySearch')
        historySearch.value = []
      }
    },
  })
}

//点击历史记录
const clickHistoryTab = tab => {
  queryParams.value.keyword = tab
}
</script>

<style lang="scss" scoped>
.searchLayout {
  /* 省略其他样式代码 */
  .topTitle {
    display: flex;
    justify-content: space-between;
    align-items: center;
    font-size: 32rpx;
    color: #000;
  }
  .history {
    padding: 30rpx;
  }
  .tabs {
    display: flex;
    align-items: center;
    flex-wrap: wrap;
    padding-top: 20rpx;
    .tab {
      background: #fff;
      font-size: 28rpx;
      color: #333;
      padding: 10rpx 28rpx;
      border-radius: 50rpx;
      margin-right: 20rpx;
      margin-top: 20rpx;
    }
  }
}
</style>
