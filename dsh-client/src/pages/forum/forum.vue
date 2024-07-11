<template>
  <view>
    <view class="card">
      <view class="top" @click="toForumDetail">
        <image class="cover" :src="forumDetailInfo.cover"></image>
        <view class="info">
          <view class="bookName">{{ forumDetailInfo.bookName }}</view>
          <view class="count">{{ forumDetailInfo.followCount }} 人参与</view>
        </view>
      </view>
      <uni-section title="书本简介" type="line">
        <text-expand>
          <view class="desc">{{ forumDetailInfo.bookIntroduction }}</view>
        </text-expand>
      </uni-section>
    </view>
    <view class="card">
      <uni-section title="交流区" type="line">
        <view v-for="(item, index) in displayedComments" :key="index">
          <comment-card :comment="item"></comment-card>
        </view>
        <view v-if="commentLists.length > 3" class="more" @click="showMore">
          {{ showMoreFlag ? '查看全部' : '收起' }}
        </view>
      </uni-section>
    </view>
    <view class="follow-btn" @click="followAction">{{ forumDetailInfo.follow ? '取消关注' : '点我关注' }}</view>
    <uni-fab ref="fab" :pattern="fabPattern" horizontal="right" @click="showComment" />
    <uni-popup ref="commentPop" type="bottom" background-color="#fff">
      <view class="commentPop">
        <uni-easyinput type="textarea" placeholder="请输入评论" v-model="commentContent" />
          <view class="flex justify-start items-center bg-red-50 h-5">
            <image v-for="(item, index) in commentImgList" :key="index" :src="item" class="comment-img" />
          </view>
        <view style="display: flex; justify-content: space-between; padding: 10rpx">
          <uni-icons type="image" size="30" @click="onCommentImg"></uni-icons>
          <uni-icons type="paperplane-filled" size="30" @click="sendComment"></uni-icons>
        </view>
      </view>
    </uni-popup>
  </view>
</template>

<script setup>
import { ref, computed } from 'vue'
import TextExpand from '../../components/TextExpand/TextExpand.vue'
import CommentCard from '../../components/CommentCard/CommentCard.vue'
import { forumDetail, commentList, forumFollowed, forumCommentAdd } from '@/service/forum.js'
import { onLoad } from '@dcloudio/uni-app'
const props = defineProps({
  id: {
    type: Number,
    required: true,
  },
})

const fabPattern = {
  icon: 'chat-filled'
}

onLoad(() => {
  getDetailInfo()
  getCommentList()
})

const forumDetailInfo = ref()

const getDetailInfo = async() => {
  const { data } = await forumDetail(props.id)
  forumDetailInfo.value = data
}

const toForumDetail = () => {
  uni.navigateTo({
     url: '/pages/forum/forumDetail?id=' + props.id
  })
}

const commentLists = ref([])
const getCommentList = async () => {
  const { data } = await commentList(props.id)
  commentLists.value = data
}
const showMoreFlag = ref(true)
// 计算属性，默认显示前3条评论，点击查看更多时显示全部评论
const displayedComments = computed(() => {
  return showMoreFlag.value ? commentLists.value.slice(0, 3) : commentLists.value;
});
const showMore = () => {
  showMoreFlag.value = !showMoreFlag.value
}

const followAction = async () => {
  const { code } = await forumFollowed(props.id)
  if (code === 0) {
    getDetailInfo()
    uni.showToast({duration: 300})
  } else {
    uni.showToast({icon: 'error', duration: 300})
  }
}

const commentPop = ref()
const showComment = () => {
  commentPop.value.open('bottom')
}
const commentContent = ref()
const sendComment = async () => {
  const commentDto = {
    forumId: props.id,
    content: commentContent.value,
    type: 1,
    fileType: 0,
    files: commentImgList.value
  }
  const res = await forumCommentAdd(commentDto)
  console.log(res);
if (res.code === 0) {
    uni.showToast()
    uni.showLoading()
    await getCommentList()
    commentContent.value = ''
    uni.hideLoading()
  } else {
    uni.showToast({
      'icon': 'error',
      'title': res.msg
    })
  }
  commentPop.value.close()
}

const commentImgList = ref([])
const onCommentImg = async () => {
  uni.chooseImage({
    count: 1,
    success: (res) => {
      console.log(res);
      // 文件路径
      const tempFiles = res.tempFilePaths
      // 上传
      uploadFile(tempFiles[0]).then((fileRes) => {
        console.log(fileRes);
      })
    },
  })
}

const uploadFile = (file) => {
  // 文件上传
  uni.uploadFile({
    url: '/common/upload/img',
    name: 'file', // 后端数据字段名
    filePath: file,
    success: (res) => {
      // 判断状态码是否上传成功
      if (res.statusCode === 200) {
        commentImgList.value = commentImgList.value.concat(JSON.parse(res.data).data.urlList)
        uni.showToast({ icon: 'success', title: '上传' })
      } else {
        uni.showToast({ icon: 'error', title: '出现错误' })
      }
    },
  })
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

.follow-btn {
  position: absolute;
  top: 100rpx;
  z-index: 10;
  right: 0;
  border-radius: 10rpx;
  line-height: 100rpx;
  height: 100rpx;
  width: 120rpx;
  background-color: rgba(48, 225, 195, 0.615);
  color: #fff;
  text-align: center;
}

.commentPop {
  padding: 20rpx;
}

.comment-img {
  height: 100rpx;
  width: 100rpx;
  border: 1rpx solid #bcbcbc;
  margin: 10rpx;
}
</style>
