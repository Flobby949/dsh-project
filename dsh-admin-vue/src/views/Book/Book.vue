<template>
  <div class="table-box">
    <ProTable
      rowKey="id"
      ref="proTable"
      title="书籍列表"
      :columns="columns"
      :requestApi="getTableList"
      :initParam="initParam"
      :dataCallback="dataCallback"
      :searchCol="{ xs: 1, sm: 2, md: 3, lg: 4, xl: 4 }"
    >
      <!-- 表格 header 按钮 -->
      <template #tableHeader>
        <el-button type="primary" :icon="CirclePlus" @click="openDrawer('新增')" v-hasPermi="['sys:book:add']">新增书籍</el-button>
      </template>
      <!-- 表格操作 -->
      <template #operation="scope">
        <el-button type="primary" link :icon="Crop" @click="openBookExchangeDialog(scope.row)">资源兑换</el-button>
        <el-button type="primary" link :icon="List" @click="openBookResourceDialog(scope.row)">资源码</el-button>
        <el-button type="primary" link :icon="Grid" @click="showQrCode(scope.row)">二维码</el-button>
        <el-button type="primary" link :icon="Edit" @click="openDrawer('编辑', scope.row)">编辑</el-button>
        <el-button type="danger" link :icon="Delete" @click="deleteData(scope.row.id)">删除</el-button>
      </template>
    </ProTable>
    <BookDialog ref="dialogRef" />
    <Dialog :model-value="showQrCodeFlag" :width="400" :maxHeight="200" title="书籍二维码" :cancel-dialog="cancelDialog">
      <el-image v-if="qrcode" :src="qrcode" width="500"></el-image>
      <div v-else>请先创建相关论坛后查看二维码</div>
      <template #footer>
        <slot name="footer">
          <el-button type="primary" v-loading.fullscreen.lock="fullscreenLoading" @click="downloadQrCode">下载</el-button>
        </slot>
      </template>
    </Dialog>
    <BookResourceDialog ref="bookResourceDialog" />
    <BookExchangeDialog ref="bookExchangeDialog" />
  </div>
</template>

<script setup lang="tsx" name="Book">
import { ref, reactive } from 'vue'
import { ColumnProps } from '@/components/ProTable/interface'
import ProTable from '@/components/ProTable/index.vue'
import BookDialog from './components/BookDialog.vue'
import { Edit, CirclePlus, Grid, List, Crop, Delete } from '@element-plus/icons-vue'
import { BookApi } from '@/api/modules/book'
import { useQRCode } from '@vueuse/integrations/useQRCode'
import { Dialog } from '@/components/Dialog'
import { Book } from '@/api/interface'
import BookResourceDialog from './components/BookResourceDialog.vue'
import BookExchangeDialog from './components/BookExchangeDialog.vue'
import { useHandleData } from '@/hooks/useHandleData'

// 获取 ProTable 元素，调用其获取刷新数据方法（还能获取到当前查询参数，方便导出携带参数）
const proTable = ref()
// 如果表格需要初始化请求参数，直接定义传给 ProTable(之后每次请求都会自动带上该参数，此参数更改之后也会一直带上，改变此参数会自动刷新表格数据)
const initParam = reactive({})

// dataCallback 是对于返回的表格数据做处理，如果你后台返回的数据不是 list && total 这些字段，那么你可以在这里进行处理成这些字段
const dataCallback = (data: any) => {
  return {
    list: data.list,
    total: data.total
  }
}

// 默认不做操作就直接在 ProTable 组件上绑定	:requestApi="getUserList"
const getTableList = (params: any) => {
  return BookApi.page(params)
}

// 表格配置项
const columns: ColumnProps[] = [
  { type: 'selection', fixed: 'left', width: 60 },
  {
    prop: 'bookCover',
    label: '封面',
    width: 150,
    render: (scope) => {
      return (
        <div class={['flex', 'justify-center', 'p-1']}>
          <el-avatar shape={'square'} size={100} src={scope.row.bookCover} />
        </div>
      )
    }
  },
  {
    prop: 'bookName',
    label: '书名',
    width: 150,
    search: { el: 'input' }
  },
  { prop: 'isbn', label: 'ISBN号', width: 150, search: { el: 'input' } },
  {
    prop: 'classification',
    label: '分类',
    width: 100
  },
  { prop: 'publishingHouse', label: '出版社', width: 180 },
  { prop: 'translator', label: '译者', width: 100 },
  { prop: 'writer', label: '作者', width: 100, search: { el: 'input' } },
  { prop: 'price', label: '价格', width: 70 },
  { prop: 'pageNumber', label: '页数', width: 70 },
  { prop: 'bookStyle', label: '装帧', width: 70 },
  {
    prop: 'publishDate',
    label: '出版时间',
    width: 150
    // search: {
    //   el: 'date-picker',
    //   props: { type: 'datetime', format: 'YYYY-MM-DD', valueFormat: 'YYYY-MM-DD', placeholder: '请选择日期' }
    // }
  },
  { prop: 'authorIntroduction', label: '作者简介', width: 150 },
  { prop: 'bookIntroduction', label: '书本简介', width: 150 },
  {
    prop: 'createTime',
    label: '创建时间',
    width: 200
  },
  { prop: 'operation', label: '操作', fixed: 'right', width: 240 }
]

// 打开 drawer(新增、查看、编辑)
const dialogRef = ref()
const openDrawer = (title: string, row = {}) => {
  let params = {
    title,
    row: { ...row },
    isView: title === '查看',
    api: title === '编辑' ? BookApi.edit : BookApi.add,
    getTableList: proTable.value.getTableList,
    maxHeight: '500px'
  }
  dialogRef.value.acceptParams(params)
}

let qrcode
const qrRow = ref()
const fullscreenLoading = ref(false)
const showQrCodeFlag = ref(false)
const showQrCode = (row = {}) => {
  qrcode = useQRCode(row.forumLink)
  showQrCodeFlag.value = true
  qrRow.value = row
}
const cancelDialog = () => {
  showQrCodeFlag.value = false
}

const downloadQrCode = () => {
  fullscreenLoading.value = true
  setTimeout(() => {
    fullscreenLoading.value = false
  }, 1500)
  let a = document.createElement('a')
  a.href = qrcode.value
  a.setAttribute('download', qrRow.value.isbn)
  a.click()
}

const bookResourceDialog = ref()
const openBookResourceDialog = (row: Book.BookVO) => {
  // 合并对应属性
  let params = {
    title: row.bookName,
    row: { ...row },
    maxHeight: '400px'
  }
  // 打开弹框
  bookResourceDialog.value.acceptParams(params)
}

const bookExchangeDialog = ref()
const openBookExchangeDialog = (row: Book.BookVO) => {
  // 合并对应属性
  let params = {
    title: row.bookName,
    row: { ...row },
    maxHeight: '400px'
  }
  // 打开弹框
  bookExchangeDialog.value.acceptParams(params)
}

const deleteData = async (id: number) => {
  await useHandleData(BookApi.remove, [id], `删除书籍`)
  proTable.value.getTableList()
}
</script>
