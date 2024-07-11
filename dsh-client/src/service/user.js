import { http } from '@/utils/https.js'

const USER_API = '/user'

export const queryUserInfo = () => {
  return http({
    method: 'POST',
    url: USER_API + '/userInfo'
  })
}
