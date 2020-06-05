import axios from 'axios'
import {Message} from 'element-ui'

// 创建axios实例
const http = axios.create({
  timeout: 30000
})

// respone拦截器
http.interceptors.response.use(
  response => {
    if (response.status !== 200 || response.data.code !== "0") {
      Message({
        message: response.data.msg,
        type: 'error',
        duration: 3 * 1000
      })
      return Promise.reject(response.data.msg)
    } else {
      return response.data.data
    }
  },
  error => {
    console.log('err' + error)// for debug
    return Promise.reject(error)
  }
)

export default http
