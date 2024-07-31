<template>
  <view class="loginPage">
    <view class="form">
      <button class="button" @click="wxLogin">
        <uni-icons type="weixin" color="#005538" size="20" ></uni-icons>
        微信一键登录
      </button>
      <view class="extra">
        <view class="caption">
          <text>其他登录方式</text>
        </view>
        <view class="options">
        </view>
      </view>
      <view class="tips">登录/注册即视为你同意《服务条款》和《隐私协议》</view>
    </view>
  </view>
</template>

<script lang="js" setup>
import { ref } from 'vue'
// import wx from "weixin-js-sdk";
/**
 * 微信登录
 */

// wx.config({
//   debug: true, // 开启调试模式,调用的所有api的返回值会在客户端alert出来，若要查看传入的参数，可以在pc端打开，参数信息会通过log打出，仅在pc端时才会打印。
//   appId: 'wx731630b450248376', // 必填，公众号的唯一标识
//   timestamp: new Date().getTime(), // 必填，生成签名的时间戳
//   nonceStr: 'dsh', // 必填，生成签名的随机串
//   signature: 'jsapi_ticket',// 必填，签名
//   jsApiList: ['chooseImage'] // 必填，需要使用的JS接口列表
// });

const wxLogin = () => {
  // const appid = 'wx731630b450248376'
  const appid = 'wx0055deef26d951ff'
  const redirect_uri = encodeURIComponent('http://demo.dianhuiyun.com.cn/dsh-client-h5/#/pages/login/login-temp')
  const scope = 'snsapi_userinfo'
  const url = ref(`https://open.weixin.qq.com/connect/oauth2/authorize?appid=${appid}&redirect_uri=${redirect_uri}&response_type=code&scope=${scope}&state=STATE#wechat_redirect`)
  window.location.href = url.value
}

const wxLoginMock = () => {
  uni.setStorageSync('token', "tokentokentokentoken")
  uni.reLaunch({
     url: '/pages/index/index'
  });
}
</script>

<style lang="scss" scoped>
page {
  height: 100%;
}

.loginPage {
  padding: 60rpx;
  display: flex;
  flex-direction: column;
  .top {
    .title {
      font-size: 48rpx;
      color: #000;
      margin-bottom: 30rpx;
    }
    .info {
      font-size: 24rpx;
      color: #999;
    }
  }

  .form {
    padding: 80rpx 0;

    .input {
      width: 100%;
      height: 100rpx;
      font-size: 28rpx;
      border-bottom: 1px solid #ddd;
      margin-bottom: 20rpx;
    }

    .code {
      display: flex;
      align-items: center;
      height: 100rpx;
      justify-content: space-between;
      border-bottom: 1px solid #ddd;
      .password {
        flex: 1;
        height: 80rpx;
        font-size: 28rpx;
        margin-bottom: 20rpx;
      }

      .btn {
        border: 1px solid #d2d2d2;
        padding: 10rpx 40rpx;
        border-radius: 10rpx;
        font-size: 24rpx;
        color: #333;
        text-align: center;
      }
    }

    .button {
      margin-top: 60rpx;
      border-radius: 10rpx;
      font-size: 32rpx;
      background: linear-gradient(to right, #18e965, #23f58c);
      color: #fff;
    }

    .extra {
      flex: 1;
      padding: 100rpx 70rpx 0;
      .caption {
        width: 440rpx;
        line-height: 1;
        border-top: 1rpx solid #ddd;
        font-size: 26rpx;
        color: #999;
        position: relative;
        text {
          transform: translate(-40%);
          background-color: #fff;
          position: absolute;
          top: -12rpx;
          left: 50%;
        }
      }

      .options {
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 70rpx;
        button {
          padding: 0;
          background-color: transparent;
        }
      }

      .icon {
        font-size: 24rpx;
        color: #444;
        display: flex;
        flex-direction: column;
        align-items: center;

        &::before {
          display: flex;
          align-items: center;
          justify-content: center;
          width: 80rpx;
          height: 80rpx;
          margin-bottom: 6rpx;
          font-size: 40rpx;
          border: 1rpx solid #444;
          border-radius: 50%;
        }
      }
      .icon-weixin::before {
        border-color: #1296db;
        color: #1296db;
      }
    }
  }

  .tips {
    position: absolute;
    bottom: 80rpx;
    left: 20rpx;
    right: 20rpx;
    font-size: 22rpx;
    color: #999;
    text-align: center;
  }
}
</style>
