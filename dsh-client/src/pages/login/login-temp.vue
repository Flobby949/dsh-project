<template>
  <view class="loginPage">
  </view>
</template>

<script lang="js" setup>
import { wxLogin } from '@/service/auth'
import { useUserStore } from '@/stores/user'
const userStore = useUserStore()

let currentUri = window.location.href
console.log(currentUri)
let params = currentUri.split('?')[1]
let code = params.split('&')[0].split('=')[1]
wxLogin(code).then(res => {
  userStore.setUserInfo(res.data)
  uni.reLaunch({
     url: '/pages/index/index'
  });
})
</script>

<style lang="scss" scoped>
page {
  height: 100%;
}
</style>
