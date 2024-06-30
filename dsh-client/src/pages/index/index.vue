<template>
  <view class="content">
    <image class="logo" src="/static/logo.png"></image>
    <view class="text-area">
      <button class="title" @click="wxLogin">{{ title }}</button>
    </view>
  </view>
</template>

<script setup>
import { ref } from 'vue'
import wx from "weixin-js-sdk";

const title = ref('首页')

wx.config({
  debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
  appId: 'wx731630b450248376', // 必填，公众号的唯一标识
  timestamp: 1719545221062, // 必填，生成签名的时间戳
  nonceStr: 'dsh', // 必填，生成签名的随机串
  signature: 'jsapi_ticket',// 必填，签名
  jsApiList: ['chooseImage'] // 必填，需要使用的JS接口列表
});

const wxLogin = () => {

  const appid = 'wx731630b450248376'
  const redirect_uri = encodeURIComponent('http://www.flobby.top')
  console.log(redirect_uri);
  const scope = 'snsapi_userinfo'
  const url = ref(`https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=${redirect_uri}&response_type=code&scope=${scope}&state=STATE#wechat_redirect`)
  console.log(url.value);
  // window.location.href = url.value
}

</script>

<style>
.content {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
}

.logo {
  height: 200rpx;
  width: 200rpx;
  margin-top: 200rpx;
  margin-left: auto;
  margin-right: auto;
  margin-bottom: 50rpx;
}

.text-area {
  display: flex;
  justify-content: center;
}

.title {
  font-size: 36rpx;
  color: #8f8f94;
}
</style>
