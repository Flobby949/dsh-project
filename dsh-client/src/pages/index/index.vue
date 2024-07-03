<template>
<view class="index">
    <CustomNavbar />
    <Swiper :swiperList="indexData.swiper" />
    <uni-section class="mb-10" title="人文社科"  type="line">
      <scroll-view scroll-x="true">
        <view class="scroll-container">
          <ForumItem v-for="(item, index) in indexData.forumList" :key="index" :forumInfo="item" />
          <ForumItem v-for="(item, index) in indexData.forumList" :key="index" :forumInfo="item" />
          <navigator
            :url="'/pages/forum/allForum'"
          >
            <view class="more">查看更多</view>
          </navigator>
        </view>
      </scroll-view>
    </uni-section>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import Swiper from './components/Swiper.vue'
import CustomNavbar from './components/CustomNavbar.vue'
import ForumItem from '../../components/ForumItem/ForumItem.vue'
import { onShow } from '@dcloudio/uni-app'
import { forumPage } from '@/service/forum.js'

/**
* 定义首页数据对象，包含了公告数组和轮播图数组
*/
const indexData = ref({
  swiper: [
    {
      id: 1,
      cover: 'https://img1.baidu.com/it/u=1465900350,3687781509&fm=253&app=138&size=w931&n=0&f=JPEG&fmt=auto?sec=1719939600&t=f545745ff0440f907c20149eccebc1ad'
    },
    {
      id: 2,
      cover: 'https://img0.baidu.com/it/u=111322774,1061492612&fm=253&fmt=auto&app=138&f=JPEG?w=753&h=500'
    }
  ],
  forumList: []
})

const queryForumList = async () => {
  const params = {
    page: 1,
    limit: 5
  }
  const { data } = await forumPage(params)
  indexData.value.forumList = data.list
}

onShow(() => {
  queryForumList()
})

</script>

<style lang="scss" scoped>
page {
  background-color: #f7f7f7;
  height: 100%;
  overflow: hidden;
}
.index {
  height: 100%;
  display: flex;
  flex-direction: column;
}

.scroll-container {
  display: flex;
  padding: 10rpx;

  .more {
    display: flex;
    padding: 5rpx ;
    margin: 0 10rpx;
    background-color: #b0b0b0;
    align-items: center;
    justify-content: center;
    width: 200rpx;
    height: 300rpx;
		font-size: 36rpx;
    box-shadow:  2rpx 2rpx 6rpx #d9d9d9,
                -2rpx -2rpx 6rpx #ffffff;
    border-radius: 10rpx;
  }
}
</style>
