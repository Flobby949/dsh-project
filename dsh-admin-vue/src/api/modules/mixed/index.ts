import http from '@/api'
import { _API } from '@/api/axios/servicePort'
import { Forum, ResPage } from '@/api/interface/index'

/**
 * @name 论坛融合管理模块
 */
export const MixedApi = {
  page: (params: Forum.ForumQuery) => http.post<ResPage<Forum.ForumVO>>(_API + '/forum/page', params),
  add: (params: any) => http.post(_API + '/forum/save', params),
  remove: (params: number[]) => http.post(_API + '/forum/delete', params),
  edit: (params: any) => http.post(_API + '/forum/update', params)
}
