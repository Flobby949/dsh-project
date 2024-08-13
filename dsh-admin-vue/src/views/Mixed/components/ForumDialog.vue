<template>
  <Dialog :model-value="dialogVisible" top="8vh" :title="dialogProps.title" width="75vw" :cancel-dialog="cancelDialog">
    <el-container>
      <el-row :gutter="20">
        <el-col :span="10" :offset="0">
          <el-descriptions :column="2" size="large" direction="vertical" border>
            <el-descriptions-item label="封面">
              <el-image :src="dialogProps.row.cover"></el-image>
            </el-descriptions-item>
            <el-descriptions-item label="头像">
              <el-image :src="dialogProps.row.avatar"></el-image>
            </el-descriptions-item>
          </el-descriptions>
        </el-col>
        <el-col :span="14" :offset="0">
          <el-row>
            <el-descriptions :column="1" size="large" border>
              <el-descriptions-item min-width="300" label="ID">
                <el-text>{{ dialogProps.row.id }}</el-text>
              </el-descriptions-item>
              <el-descriptions-item label="论坛名">
                <el-text>{{ dialogProps.row.name }}</el-text>
              </el-descriptions-item>
              <el-descriptions-item min-width="300" label="参与人数">
                <el-text>{{ dialogProps.row.userNumber }}</el-text>
              </el-descriptions-item>
              <el-descriptions-item min-width="300" label="创建时间">
                <el-text>{{ dialogProps.row.createTime }}</el-text>
              </el-descriptions-item>
            </el-descriptions>
          </el-row>
          <el-row class="mt-5">
            <el-descriptions :column="1" size="large" border>
              <el-descriptions-item min-width="300" label="作者介绍">
                <el-text>{{ dialogProps.row.writerIntroduction }}</el-text>
              </el-descriptions-item>
              <el-descriptions-item label="圈子介绍" min-width="300">
                <audio :src="dialogProps.row.voiceIntroduction" controls></audio>
              </el-descriptions-item>
            </el-descriptions>
          </el-row>
        </el-col>
      </el-row>
    </el-container>
  </Dialog>
</template>

<script setup lang="ts">
import { Dialog } from '@/components/Dialog'
import { ref } from 'vue'

const dialogVisible = ref(false)
const dialogProps = ref({
  isView: false,
  title: '圈子详情',
  row: {},
  labelWidth: 160,
  fullscreen: false,
  maxHeight: '500px'
})

// 接收父组件传过来的参数
const acceptParams = (params): void => {
  params.row = { ...dialogProps.value.row, ...params.row }
  console.log(params.row)
  dialogProps.value.title = params.row.name
  dialogProps.value = { ...dialogProps.value, ...params }
  dialogVisible.value = true
}

defineExpose({
  acceptParams
})

const cancelDialog = () => {
  dialogVisible.value = false
}
</script>

<style scoped></style>
