import http from '@/utils/http'
const url = "http://localhost:9003"
export function getAllGoods(params) {
  return http({
    baseURL: url,
    url:'/api/spu/management/list',
    method:'get',
    params:params
  })
}
