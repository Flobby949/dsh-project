import http from '@/api'
import { _API } from '@/api/axios/servicePort'

/**
 * @name 用户管理模块
 */
export const UserApi = {
  list: () => http.get(_API + '/user/list')
}
