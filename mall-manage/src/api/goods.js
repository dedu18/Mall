import http from '@/utils/http'
const url = "http://localhost:9003"
export function addGoods(data) {
  return http({
    baseURL: url,
    url:'/api/goods/',
    method:'post',
    data:data
  })
}
