<template>
  <view>
  </view>
</template>

<script lang="js" setup>
import { wxVerify } from '@/service/auth'
import { onLoad } from '@dcloudio/uni-app'

onLoad((e) => {
  let currentUri = window.location.href
  // alert(currentUri)
  let params = currentUri.split('?')[1]
  let code = params.split('&')[0].split('=')[1]
  console.log(params);
  console.log(code);
  wxVerify(code).then(res => {
    uni.reLaunch({
      url: `/pages/exchange/exchange?wxId=${res.data}`
    });
  })
})

</script>

<style lang="scss" scoped>
page {
  height: 100%;
}
</style>
