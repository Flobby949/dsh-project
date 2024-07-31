import { http } from '@/utils/https.js'

const AUTH_API = '/auth'

export const wxLogin = (code) => {
  return http({
    method: 'POST',
    url: AUTH_API + '/wxLogin?code=' + code
  })
}

export const logout = () => {
  return http({
    method: 'POST',
    url: AUTH_API + '/logout'
  })
}

export const wxVerify = (code) => {
  return http({
    method: 'POST',
    url: AUTH_API + '/wxVerify?code=' + code
  })
}
