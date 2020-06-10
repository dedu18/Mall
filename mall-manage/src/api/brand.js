import http from '@/utils/http'
const url = "http://localhost:9003"
export function getAllBrand(params) {
  return http({
    baseURL: url,
    url:'/api/brand/list',
    method:'get',
    params:params
  })
}

export function addBrand(datas) {
  return http({
    baseURL: url,
    url:'/api/brand',
    method:'post',
    data:datas
  })
}

export function editBrand(datas) {
  return http({
    baseURL: url,
    url:'/api/brand',
    method:'put',
    data:datas
  })
}

export function deleteBrand(id) {
  return http({
    baseURL: url,
    url:'/api/brand/' + id,
    method:'delete'
  })
}

export function getBrandByCategoryId(id) {
  return http({
    baseURL: url,
    url:'/api/brand/category/' + id,
    method:'get'
  })
}
