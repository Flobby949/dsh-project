<template>
  <view>
    <view class="card">
      <view class="top" @click="toForumDetail">
        <image class="cover" :src="forumDetailInfo.cover"></image>
        <view class="info">
          <view class="bookName">{{ forumDetailInfo.bookName }}</view>
          <view class="count">{{ forumDetailInfo.numCount }} 等人参与</view>
        </view>
      </view>
      <uni-section title="书本简介" type="line">
        <text-expand>
          <view class="desc">{{ forumDetailInfo.bookDesc }}</view>
        </text-expand>
      </uni-section>
    </view>
    <view class="card">
      <uni-section title="交流区" type="line">
        <view v-for="(item, index) in displayedComments" :key="index">
          <comment-card :comment="item"></comment-card>
        </view>
        <view v-if="commentList.length > 3" class="more" @click="showMore">
          {{ showMoreFlag ? '查看全部' : '收起' }}
        </view>
      </uni-section>
    </view>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import TextExpand from '../../components/TextExpand/TextExpand.vue'
import CommentCard from '../../components/CommentCard/CommentCard.vue'

// 接收页面参数
const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
})

const forumDetailInfo = ref({
  id: 1,
  name: '读书汇',
  bookName: '书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称书本名称',
  numCount: 15,
  author: '作者',
  bookDesc: '书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述书本描述',
  cover: 'https://img2.baidu.com/it/u=3830664050,3289120979&fm=253&fmt=auto&app=138&f=JPEG?w=500&h=500'
})

const commentList = ref([
  {
    id: 1,
    user: 'Flobby',
    avatar: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
    bookName: '读书汇',
    content: '评论内容评论内容评论内容评论内容评论内容',
    createTime: '2024-07-01 16:27',
    likeNum: 1,
    reCommentList: [],
    favourite: true,
    isLike: false
  },
  {
    id: 2,
    user: 'Flobby',
    avatar: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
    bookName: '读书汇',
    content: '评论内容评论内容评论内容评论内容评论内容',
    createTime: '2024-07-01 16:27',
    likeNum: 21,
    reCommentList: [],
    favourite: true,
    isLike: false
  },
  {
    id: 3,
    user: 'Flobby',
    avatar: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
    bookName: '读书汇',
    content: '评论内容评论内容评论内容评论内容评论内容',
    createTime: '2024-07-01 16:27',
    likeNum: 3,
    reCommentList: [],
    favourite: true,
    isLike: false
  },
  {
    id: 4,
    user: 'Flobby',
    avatar: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
    bookName: '读书汇',
    content: '评论内容评论内容评论内容评论内容评论内容',
    createTime: '2024-07-01 16:27',
    likeNum: 4,
    reCommentList: [],
    favourite: true,
    isLike: false
  },
  {
    id: 5,
    user: 'Flobby',
    avatar: 'https://qiniu-web-assets.dcloud.net.cn/unidoc/zh/unicloudlogo.png',
    bookName: '读书汇',
    content: '评论内容评论内容评论内容评论内容评论内容',
    createTime: '2024-07-01 16:27',
    likeNum: 5,
    reCommentList: [],
    favourite: true,
    isLike: false
  }
])

const toForumDetail = () => {
  uni.navigateTo({
     url: '/pages/forum/forumDetail?id=' + props.id
  })
}

const showMoreFlag = ref(true)
// 计算属性，默认显示前3条评论，点击查看更多时显示全部评论
const displayedComments = computed(() => {
  return showMoreFlag.value ? commentList.value.slice(0, 3) : commentList.value;
});
const showMore = () => {
  showMoreFlag.value = !showMoreFlag.value
}
</script>

<style lang="scss" scoped>
page {
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
      width: 300rpx;
      height: 300rpx;
    }

    .info {
      flex: 1;

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
  }

  .desc {
    padding: 5rpx 20rpx;
    color: #666666;
    font-size: 28rpx;
    line-height: 1.5;
  }

  .more {
    color: #2b8def;
    font-size: 32rpx;
    width: 100%;
    height: 100rpx;
    line-height: 100rpx;
    text-align: center;
  }
}
</style>
