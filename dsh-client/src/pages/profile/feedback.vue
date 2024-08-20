<template>
  <view class="container">
    <uni-section class="mb-10" title="反馈内容" type="line">
      <uni-easyinput type="textarea" v-model="feedback" placeholder="请描述您反馈的问题或提出宝贵意见"></uni-easyinput>
      <view class="image" @click="uploadImage">
        <image v-show="hasImg" style="width: 200rpx; height: 200rpx;" mode="scaleToFill" :src="imgUrl"></image>
        <uni-icons v-show="!hasImg" type="images" size="60" color="#a9a9a9"></uni-icons>
      </view>
    </uni-section>
    <uni-section title="联系方式" type="line" padding>
			<uni-easyinput class="uni-mt-5" trim="all" v-model="contact" placeholder="请输入您的电话或邮箱，方便我们联系您"></uni-easyinput>
		</uni-section>
  </view>
</template>

<script setup>
import { ref } from 'vue'
const feedback = ref()
const hasImg = ref(false)
const imgUrl = ref()

const uploadImage = () => {
  uni.chooseImage({
    count: 1,
    success: (chooseImageRes) => {
      const tempFilePaths = chooseImageRes.tempFilePaths;
      uni.uploadFile({
        url: 'http://8.153.16.66/dsh-client-api/common/upload/img', //仅为示例，非真实的接口地址
        filePath: tempFilePaths[0],
        name: 'file',
        success: (uploadFileRes) => {

          if (uploadFileRes.statusCode === 200) {
            const res = JSON.parse(uploadFileRes.data)
            imgUrl.value = res.data.urlList[0]
            hasImg.value = true
            uni.showToast({ icon: 'success', title: '上传成功' })
          } else {
            uni.showToast({ icon: 'error', title: '出现错误' })
          }

        }
      });
    }
  });
}
</script>

<style scoped>
page {
  background-color: #f9f9f9;
}
.container {
  padding: 10rpx;
}
.image {
  margin: 10rpx 0;
  display: flex;
  justify-content: center;
  align-items: center;
  height: 200rpx;
  width: 200rpx;
  border: 1rpx dashed #a9a9a9;
}
</style>
