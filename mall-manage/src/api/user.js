import http from '@/utils/http'
const url = "http://localhost:9001"
export function login(params) {
  return http({
    baseURL: url,
    url:'/api/user/manage',
    method:'get',
    params:params
  })
}
