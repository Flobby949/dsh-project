import { useUserStore } from '@/stores/user'

const baseURL = 'http://8.153.16.66/dsh-client-api'

export const http = (options) => {
  // 1. 返回 Promise 对象
  return new Promise((resolve, reject) => {
    uni.request({
      ...options,
      // 响应成功
      success(res) {
        // 状态码 2xx，参考 axios 的设计
        if (res.statusCode >= 200 && res.statusCode < 300) {
          console.log('响应成功');
           if (res.data.code === 401) {
            console.log('登录失败');
            // 401错误  -> 清理用户信息，跳转到登录页
            const userStore = useUserStore()
            userStore.clearUserInfo()
            uni.reLaunch({ url: '/pages/login/login' })
            reject(res)
          } else if (res.data.code !== 0) {
            // 根据后端错误信息轻提示
            uni.showToast({
              icon: 'error',
              title: res.data.msg || '请求错误',
            })
          } else {
            // 提取核心数据 res.data
            resolve(res.data)
          }
        } else if (res.statusCode === 401) {
          // 401错误  -> 清理用户信息，跳转到登录页
          const userStore = useUserStore()
          userStore.clearUserInfo()
          uni.navigateTo({ url: '/pages/login/login' })
          reject(res)
        } else {
          // 其他错误 -> 根据后端错误信息轻提示
          uni.showToast({
            icon: 'none',
            title: res.data.msg || '请求错误',
          })
          reject(res)
        }
      },
      // 响应失败
      fail(err) {
        uni.showToast({
          icon: 'none',
          title: '网络错误，换个网络试试',
        })
        reject(err)
      },
    })
  })
}

const httpInterceptor = {
  invoke(options) {
    if (!options.url.startsWith('http')) {
      options.url = baseURL + options.url
    }
    options.timeout = 10000
    options.header = {
      ...options.header,
    }
    // const token = uni.getStorageSync('token') || 'no-token'
    const token = 'eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJuYmYiOjE3MjU0NjUyNzMsImV4cCI6MTcyNTYzODA3MywiaWF0IjoxNzI1NDY1MjczLCJ1c2VySWQiOjEyfQ.98Yu23nCdYDg0kkCegVW_ebB6PdIbokmKmvQ8WsYv4k'
    if (token) {
      options.header.Authorization = token
    }
  },
}

// 拦截 request 请求
uni.addInterceptor('request', httpInterceptor)
// 拦截 uploadFile 文件上传
uni.addInterceptor('uploadFile', httpInterceptor)
