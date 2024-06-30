<template>
  <Dialog
    :model-value="dialogVisible"
    :title="dialogProps.title"
    :fullscreen="dialogProps.fullscreen"
    width="80%"
    :max-height="dialogProps.maxHeight"
    :cancel-dialog="cancelDialog"
  >
    <div class="el-dialog__body">
      <ProTable rowKey="id" ref="proTable" title="资源兑换列表" :columns="columns" :requestApi="getTableList" :dataCallback="dataCallback">
        <!-- 表格 header 按钮 -->
        <template #tableHeader>
          <el-button type="primary" :icon="CirclePlus" @click="openGenerateDialog">生成二维码</el-button>
        </template>
        <!-- 表格操作 -->
        <template #operation="scope">
          <el-button type="primary" link :icon="Grid" @click="showQrCode(scope.row)">二维码</el-button>
        </template>
      </ProTable>
    </div>
  </Dialog>
  <Dialog :model-value="showQrCodeFlag" title="资源二维码" :cancel-dialog="cancelResourceDialog">
    <el-image :src="qrcode"></el-image>
    <template #footer>
      <slot name="footer">
        <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading" @click="downloadQrCode">下载</el-button>
      </slot>
    </template>
  </Dialog>
  <Dialog :model-value="generateDialog" title="资源二维码" :cancel-dialog="cancelGenerateDialog">
    <el-form-item label="资源二维码生成数量">
      <el-input-number v-model="num" placeholder="输入生成数量" :min="1"></el-input-number>
    </el-form-item>
    <template #footer>
      <slot name="footer">
        <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading" @click="generateTask">生成</el-button>
      </slot>
    </template>
  </Dialog>
</template>

<script setup lang="tsx">
import { Dialog } from '@/components/Dialog'
import { ref } from 'vue'
import { BookApi } from '@/api/modules/book'
import { ColumnProps } from '@/components/ProTable/interface'
import { Grid, CirclePlus } from '@element-plus/icons-vue'
import ProTable from '@/components/ProTable/index.vue'
import { useQRCode } from '@vueuse/integrations/useQRCode'
import { ElMessage } from 'element-plus'

// 定义弹出框类型
interface DialogProps {
  title: string
  isView: boolean
  fullscreen?: boolean
  row: any
  labelWidth?: number
  maxHeight?: number | string
  api?: (params: any) => Promise<any>
  getTableList?: () => Promise<any>
}
// 弹出框是否显示
const dialogVisible = ref(false)
// 弹出框属性
const dialogProps = ref<DialogProps>({
  isView: false,
  title: '',
  row: {},
  labelWidth: 160,
  fullscreen: true,
  maxHeight: '20vh'
})

// 接收父组件传过来的参数
const acceptParams = async (params: DialogProps) => {
  params.row = { ...dialogProps.value.row, ...params.row }
  dialogProps.value = { ...dialogProps.value, ...params }
  dialogVisible.value = true
}

defineExpose({
  acceptParams
})

// 关闭弹框
const cancelDialog = () => {
  dialogVisible.value = false
}

// 获取 ProTable 元素，调用其获取刷新数据方法（还能获取到当前查询参数，方便导出携带参数）
const proTable = ref()

// dataCallback 是对于返回的表格数据做处理，如果你后台返回的数据不是 list && total 这些字段，那么你可以在这里进行处理成这些字段
const dataCallback = (data: any) => {
  return {
    list: data.list,
    total: data.total
  }
}

const getTableList = (params: any) => {
  params.bookId = dialogProps.value.row.id
  return BookApi.exchangePage(params)
}
const columns: ColumnProps[] = [
  {
    prop: 'id',
    label: '编号',
    width: 180
  },
  {
    prop: 'status',
    label: '状态',
    width: 350,
    render: (scope) => {
      return <el-tag type={scope.row.status ? 'danger' : 'success'}>{scope.row.status ? '已使用' : '未使用'}</el-tag>
    }
  },
  {
    prop: 'exchangeTime',
    label: '兑换时间',
    width: 350
  },
  { prop: 'operation', label: '操作', fixed: 'right', width: 300 }
]

let qrcode
const showQrCodeFlag = ref(false)
const showQrCode = (row = {}) => {
  qrcode = useQRCode(`${import.meta.env.VITE_API_URL}/dsh-admin-api/book/exchange/${row.id}`)
  console.log(`${import.meta.env.VITE_API_URL}/dsh-admin-api/book/exchange/${row.id}`)
  showQrCodeFlag.value = true
}
const fullscreenLoading = ref(false)
const downloadQrCode = () => {
  fullscreenLoading.value = true
  setTimeout(() => {
    fullscreenLoading.value = false
  }, 1500)
  let a = document.createElement('a')
  a.href = qrcode.value
  a.setAttribute('download', '二维码')
  a.click()
}

const cancelResourceDialog = () => {
  showQrCodeFlag.value = false
}

const generateDialog = ref(false)
const num = ref(0)
const openGenerateDialog = async () => {
  generateDialog.value = true
  num.value = 0
}

const cancelGenerateDialog = () => {
  generateDialog.value = false
}

const generateTask = async () => {
  await BookApi.generateExchange(dialogProps.value.row.id, num.value)
  ElMessage.success({ message: `二维码生成成功！` })
  proTable.value.getTableList()
  cancelGenerateDialog()
}
</script>

<style scoped lang="less">
.el-dialog__body {
  height: 50vh;
  overflow: auto;
}
</style>
