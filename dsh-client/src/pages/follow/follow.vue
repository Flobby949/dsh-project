<template>
  <view>
    <view class="top-bar">
      <view>关注的读书会</view>
      <view>{{ followForumList.length || 0 }} 个</view>
    </view>
    <view class="follow-body">
      <uni-grid v-if="followForumList.length > 0" :show-border="false" :column="3" :highlight="true">
        <uni-grid-item v-for="(item, index) in followForumList" :key="index" style="height: 350rpx">
          <forum-item :forum-info="item" />
        </uni-grid-item>
      </uni-grid>
      <view v-else class="none">
        <text>微信扫码</text>
        <text>关注更多读书汇</text>
      </view>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import ForumItem from '../../components/ForumItem/ForumItem.vue';

const followForumList = ref([
  // {
  //     id: 1,
  //     cover: 'https://img2.baidu.com/it/u=3830664050,3289120979&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
  //     bookName: '读书汇读书汇读书汇读书汇读书汇1',
  //     numCount: 10
  //   },
  //   {
  //     id: 2,
  //     cover: 'https://img2.baidu.com/it/u=3830664050,3289120979&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
  //     bookName: '读书汇2',
  //     numCount: 15
  //   },
  //   {
  //     id: 2,
  //     cover: 'https://img2.baidu.com/it/u=3830664050,3289120979&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
  //     bookName: '读书汇2',
  //     numCount: 15
  //   },
  //   {
  //     id: 2,
  //     cover: 'https://img2.baidu.com/it/u=3830664050,3289120979&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500',
  //     bookName: '读书汇2',
  //     numCount: 15
  //   }
])
</script>

<style lang="scss" scoped>
page {
  background-color: #f7f7f7;
}
.top-bar {
  display: flex;
  justify-content: space-between;
  align-items: center;
  background-color: #fff;
  color: #000;
  font-size: 38rpx;
  height: 150rpx;
  padding: 0 50rpx;
  border-bottom: 1rpx solid #ddd;
}

.follow-body {
  padding: 20rpx;

  .none {
    display: flex;
    flex-direction: column;
    padding: 5rpx;
    margin: 0 10rpx;
    align-items: center;
    justify-content: center;
    width: 200rpx;
    height: 300rpx;
    border: 1rpx solid #ddd;
    font-size: 24rpx;
    line-height: 1.5;
    color: #8e8e8e;
  }
}
</style>
