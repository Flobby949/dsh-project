<script setup>
import { ref } from 'vue'
import { onLoad } from '@dcloudio/uni-app'
import { resource } from '@/service/book'

const flag = ref(false)

onLoad((e) => {
  const resourceId = e.resourceId
  const codeSecret = e.secret
  resource({
    resourceId,codeSecret
  }).then((res) => {
    if (res.code === 0) {
      window.location.href = res.data
    } else {
      flag.value = true
    }
  })
})
</script>

<template>
  <view v-if="flag">
    资源验证失败！
  </view>
  <view v-else>
    跳转中...
  </view>
</template>
