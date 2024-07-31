<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { exchange } from '@/service/book'

const wxOpenId = ref()
const cardNum = ref()
onLoad((e) => {
  if (e.cardNum) {
    cardNum.value = e.cardNum
  }
  if (e.wxId) {
    wxOpenId.value = e.wxId
    // 如果有防伪码，直接触发校验
    if (cardNum.value != null) {
      checkExchange()
    }
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
  if (cardNum.value == null) {
    uni.showToast({
      title: "请输入防伪码",
      icon: "error"
    })
    return
  }
  const dto = {
    'cardNum': cardNum.value,
    'openId': wxOpenId.value
  }
  exchange(dto).then((res) => {
    window.location.href = res.data
  })
}

</script>
<template>
  <view class="container">
    <button class="btn" v-if="!wxOpenId" @click="wxCheck">微信校验</button>
    <input class="input-bar" type="text" v-model="cardNum" placeholder="请输入防伪卡号" />
    <button class="btn" @click="checkExchange">校验资源</button>
  </view>
</template>

<style lang="scss" scoped>
page {
  background-color: #f7f7f7;
  height: 100%;
}
.container {
  padding: 10rpx;

  .btn {
    margin: 10rpx;
  }

  .input-bar {
    height: 150rpx;
    margin: 10rpx;
  }
}
</style>
