<script lang="js" setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { exchange, check } from '@/service/book'

const wxOpenId = ref()
const cardNum = ref()
const verifyCode = ref()
/**
 * 1. 获取路由携带的参数，cardNum和verifyCode，保存
 * 2. 微信认证，获取微信openId
 * 3. 根据cardNum和OpenId，判断是否需要输入verifyCode，如果不需要，直接跳转
 * 4. 如果需要，自动填入或手动输入，然后点击校验
 */
onLoad((e) => {
  cardNum.value = uni.getStorageSync("cardNum") || null
  verifyCode.value = uni.getStorageSync("verifyCode") || null
  if (e.cardNum) {
    uni.setStorageSync("cardNum", e.cardNum)
    cardNum.value = e.cardNum
  }
  if (e.verifyCode) {
    uni.setStorageSync("verifyCode", e.verifyCode)
    verifyCode.value = e.verifyCode
  }
  if (e.wxId) {
    wxOpenId.value = e.wxId
    checkVerifyAvailable()
  } else {
    wxCheck()
  }
})

const wxCheck = () => {
  // const appid = 'wx731630b450248376'
  const appid = 'wx0055deef26d951ff'
  const redirect_uri = encodeURIComponent('http://demo.dianhuiyun.com.cn/dsh-client-h5/#/pages/exchange/exchange-temp')
  const scope = 'snsapi_userinfo'
  const url = ref(`https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=${redirect_uri}&response_type=code&scope=${scope}&state=STATE#wechat_redirect`)
  window.location.href = url.value
}

const checkExchange = () => {
  if (verifyCode.value == null) {
    uni.showToast({
      title: "请输入防伪码",
      icon: "error"
    })
    return
  }
  const dto = {
    'verifyCode': verifyCode.value,
    'cardNum': cardNum.value,
    'openId': wxOpenId.value
  }
  exchange(dto).then((res) => {
    window.location.href = res.data
  })
}

const checkVerifyAvailable = () => {
    const dto = {
    'cardNum': cardNum.value,
    'openId': wxOpenId.value
  }
  check(dto).then((res) => {
    if (res.data != null) {
      window.location.href = res.data
    }
  })
}

</script>

<template>
  <view class="container">
    <!-- <button class="btn" v-if="!wxOpenId" @click="wxCheck">微信校验</button> -->
    <view class="row">
        卡号：<input class="input-bar" type="text" v-model="verifyCode" placeholder="请输入防伪卡号" />
    </view>
    
    <button class="btn" @click="checkExchange">校验资源</button>
  </view>
</template>

<style lang="scss" scoped>
page {
  background-color: #f7f7f7;
  height: 100%;
}
.container {
  height: 100vh;
  padding: 30rpx;
  border-radius: 20rpx;
  display: flex;
  flex-direction: column;
  align-items: center;
  background-color: #fff;
  .row{
    display: flex;
    flex-direction: row;
    justify-content: center;
    align-items: center;
    margin-top: 100rpx;
  }
  .input-bar {
    background-color: #fff;
    border: solid 1rpx #d3d3d3;
    border-radius: 8rpx;
    padding-left:20rpx;
    width: 400rpx;
    height: 70rpx;
    margin: 10rpx;
  }
  .btn {
        width: 200rpx;
        height: 70rpx;
        font-size: 30rpx;
        border-radius: 10rpx;
        margin: 10rpx;
        text-align: center;
        color:#fff;
        border: #057748 1rpx solid;
        background-color: #12b089;
  }
}
</style>
