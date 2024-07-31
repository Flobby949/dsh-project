<template>
  <Dialog :model-value="dialogVisible" :title="dialogProps.title" :fullscreen="dialogProps.fullscreen" width="80%" :maxHeight="500" :cancel-dialog="cancelDialog">
    <div class="el-dialog__body">
      <ProTable rowKey="id" ref="proTable" title="资源兑换列表" :columns="columns" :requestApi="getTableList" :dataCallback="dataCallback">
        <!-- 表格 header 按钮 -->
        <template #tableHeader>
          <ImportResource v-model:code="importRes" :file-size="1" :api="BookApi.importExchange" @check-validate="afterUpload" :bookId="dialogProps.row.id">
            <template #empty>
              <el-button type="primary" :icon="UploadFilled">导入资源码</el-button>
            </template>
          </ImportResource>
        </template>
        <!-- 表格操作 -->
        <template #operation="scope">
          <el-button type="primary" link :icon="Grid" @click="showQrCode(scope.row)">二维码</el-button>
          <el-button type="danger" link :icon="Delete" @click="deleteData(scope.row.id)">删除</el-button>
        </template>
      </ProTable>
    </div>
  </Dialog>
  <Dialog :model-value="showQrCodeFlag" title="兑换二维码" :cancel-dialog="cancelResourceDialog">
    <el-image :src="qrcode"></el-image>
    <template #footer>
      <slot name="footer">
        <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading" @click="downloadQrCode">下载</el-button>
      </slot>
    </template>
  </Dialog>
</template>

<script setup lang="tsx">
import { Dialog } from '@/components/Dialog'
import { ref } from 'vue'
import { BookApi } from '@/api/modules/book'
import { ColumnProps } from '@/components/ProTable/interface'
import { Grid, UploadFilled, Delete } from '@element-plus/icons-vue'
import ProTable from '@/components/ProTable/index.vue'
import { useQRCode } from '@vueuse/integrations/useQRCode'
import { useHandleData } from '@/hooks/useHandleData'
import ImportResource from '@/components/Upload/ImportResource.vue'

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
  maxHeight: 700
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
    width: 100
  },
  {
    prop: 'verifyCode',
    label: '校验码',
    width: 400
  },
  {
    prop: 'bookLink',
    label: '内容链接',
    width: 500
  },
  {
    prop: 'status',
    label: '状态',
    width: 150,
    render: (scope) => {
      return <el-tag type={scope.row.status ? 'danger' : 'success'}>{scope.row.status ? '已使用' : '未使用'}</el-tag>
    }
  },
  {
    prop: 'exchangeTime',
    label: '兑换时间',
    width: 300
  },
  { prop: 'operation', label: '操作', fixed: 'right', width: 200 }
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

const importRes = ref()
const afterUpload = () => {
  if (importRes.value == 0) {
    proTable.value.getTableList()
  }
}

const deleteData = async (id: number) => {
  await useHandleData(BookApi.removeExchange, [id], `删除书籍兑换`)
  proTable.value.getTableList()
}
</script>

<style scoped lang="less">
.el-dialog__body {
  height: 50vh;
  overflow: auto;
}
</style>
