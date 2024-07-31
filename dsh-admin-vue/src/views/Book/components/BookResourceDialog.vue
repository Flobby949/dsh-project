<template>
  <Dialog :model-value="dialogVisible" :maxHeight="400" :title="dialogProps.title" :fullscreen="dialogProps.fullscreen" :cancel-dialog="cancelDialog">
    <div class="el-dialog__body">
      <ProTable rowKey="id" ref="proTable" title="书籍资源列表" :columns="columns" :requestApi="getTableList" :dataCallback="dataCallback">
        <!-- 表格 header 按钮 -->
        <template #tableHeader>
          <el-button type="primary" :icon="CirclePlus" @click="openDrawer('新增')" v-hasPermi="['sys:book:add']">新增资源</el-button>
          <el-button type="primary" :icon="DocumentCopy" @click="uploadTemplate" v-hasPermi="['sys:book:add']">下载上传模板</el-button>
          <el-button type="primary" :icon="Download" @click="downloadFile" v-hasPermi="['sys:book:view']">下载资源码</el-button>
          <ImportResource v-model:code="importRes" :file-size="1" :api="BookResourceApi.importResource" @check-validate="afterUpload" :bookId="dialogProps.row.id">
            <template #empty>
              <el-button type="primary" :icon="UploadFilled">导入资源码</el-button>
            </template>
          </ImportResource>
        </template>
        <!-- 表格操作 -->
        <template #operation="scope">
          <!-- <el-button type="primary" link :icon="List">资源码</el-button> -->
          <el-button type="primary" link :icon="Grid" @click="showQrCode(scope.row)">二维码</el-button>
          <el-button type="primary" link :icon="Edit" @click="openDrawer('编辑', scope.row)">编辑</el-button>
          <el-button type="danger" link :icon="Delete" @click="deleteData(scope.row.id)">删除</el-button>
        </template>
      </ProTable>
    </div>
  </Dialog>
  <Dialog :model-value="showQrCodeFlag" :maxHeight="350" :width="500" title="资源二维码" :cancel-dialog="cancelResourceDialog">
    <el-image :src="qrcode" style="height: 300px; width: 300px"></el-image>
    <template #footer>
      <slot name="footer">
        <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading" @click="downloadQrCode">下载</el-button>
      </slot>
    </template>
  </Dialog>
  <BookResourceEditDialog :maxHeight="100" ref="dialogRef" />
</template>

<script setup lang="tsx">
import { Dialog } from '@/components/Dialog'
import { ref } from 'vue'
import { BookResourceApi } from '@/api/modules/book'
import { ColumnProps } from '@/components/ProTable/interface'
import { Edit, CirclePlus, Grid, Download, DocumentCopy, UploadFilled, Delete } from '@element-plus/icons-vue'
import ProTable from '@/components/ProTable/index.vue'
import BookResourceEditDialog from './BookResourceEditDialog.vue'
import { useQRCode } from '@vueuse/integrations/useQRCode'
import { useDownload } from '@/hooks/useDownload'
import { ElMessageBox } from 'element-plus'
import ImportResource from '@/components/Upload/ImportResource.vue'
import { useHandleData } from '@/hooks/useHandleData'

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
  maxHeight: '80vh'
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
  return BookResourceApi.page(params)
}

const columns: ColumnProps[] = [
  { type: 'selection', fixed: 'left', width: 60 },
  {
    prop: 'resourceName',
    label: '资源名',
    width: 180
  },
  {
    prop: 'link',
    label: '链接',
    width: 350
  },
  { prop: 'operation', label: '操作', fixed: 'right', width: 300 }
]

const dialogRef = ref()
const openDrawer = (title: string, row = {}) => {
  console.log('row', row)
  let params = {
    title,
    row: { ...row, bookId: dialogProps.value.row.id },
    isView: title === '查看',
    api: title === '编辑' ? BookResourceApi.edit : BookResourceApi.add,
    getTableList: proTable.value.getTableList,
    maxHeight: '500px'
  }
  dialogRef.value.acceptParams(params)
}

let qrcode
const showQrCodeFlag = ref(false)
const showQrCode = (row = {}) => {
  qrcode = useQRCode(row.link)
  qrRow.value = row
  showQrCodeFlag.value = true
}
const fullscreenLoading = ref(false)
const qrRow = ref()
const downloadQrCode = () => {
  fullscreenLoading.value = true
  setTimeout(() => {
    fullscreenLoading.value = false
  }, 1500)
  let a = document.createElement('a')
  a.href = qrcode.value
  a.setAttribute('download', qrRow.value.resourceName)
  a.click()
}

const cancelResourceDialog = () => {
  showQrCodeFlag.value = false
}

const downloadFile = async () => {
  ElMessageBox.confirm('确认下载全部资源?', '温馨提示', { type: 'warning' }).then(() => useDownload(BookResourceApi.download, '资源二维码', dialogProps.value.row.id, true, '.zip'))
}

const uploadTemplate = () => {
  window.location.href = 'http://106.15.104.19:9000/dsh/%E5%A4%9A%E4%BA%8C%E7%BB%B4%E7%A0%81%E6%A8%A1%E6%9D%BF.xlsx'
}

const importRes = ref()
const afterUpload = () => {
  console.log(importRes)
  if (importRes.value == 0) {
    proTable.value.getTableList()
  }
}

const deleteData = async (id: number) => {
  await useHandleData(BookResourceApi.remove, [id], `删除书籍资源`)
  proTable.value.getTableList()
}
</script>

<style scoped lang="less">
.el-dialog__body {
  height: 50vh;
  overflow: auto;
}
</style>
