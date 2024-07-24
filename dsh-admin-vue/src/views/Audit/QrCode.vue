<template>
  <div class="table-box">
    <ProTable
      rowKey="id"
      ref="proTable"
      title="资源码列表"
      :columns="columns"
      :requestApi="getTableList"
      :initParam="initParam"
      :dataCallback="dataCallback"
      :searchCol="{ xs: 1, sm: 2, md: 3, lg: 4, xl: 4 }"
    >
    </ProTable>
  </div>
</template>

<script setup lang="tsx">
import { ref, reactive } from 'vue'
import { ColumnProps } from '@/components/ProTable/interface'
import ProTable from '@/components/ProTable/index.vue'
import { BookResourceApi } from '@/api/modules/book'
import { useAuthButtons } from '@/hooks/useAuthButtons'
const { BUTTONS } = useAuthButtons()
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
  return BookResourceApi.auditResourcePage(params)
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
    width: 300
  },
  {
    prop: 'resourceName',
    label: '资源名',
    width: 200
  },
  { prop: 'link', label: '资源链接', width: 400 },
  {
    prop: 'isChanged',
    label: '是否篡改',
    width: 150,
    render: (scope) => {
      return (
        <>
          {BUTTONS.value.status ? (
            <el-switch model-value={scope.row.status} active-text={scope.row.isChanged ? '是' : '否'} active-value={1} inactive-value={0} />
          ) : (
            <el-tag type={scope.row.isChanged ? 'danger' : 'success'}>{scope.row.isChanged ? '是' : '否'}</el-tag>
          )}
        </>
      )
    }
  }
]
</script>

<style scoped></style>
