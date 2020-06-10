import http from '@/utils/http'

const url = "http://localhost:9003"

export function getAllCategoryTree(params) {
  return http({
    baseURL: url,
    url:'/api/category/tree',
    method:'get',
    params:params
  })
}

export function getAllCategoryList(params) {
  return http({
    baseURL: url,
    url:'/api/category/list',
    method:'get',
    params:params
  })
}

export function modifyCategoryById(data) {
  return http({
    baseURL: url,
    url:'/api/category',
    method:'put',
    data:data
  })
}

export function deleteCategoryById(id) {
  return http({
    baseURL: url,
    url:'/api/category/' + id,
    method:'delete'
  })
}

export function addCategory(datas) {
  return http({
    baseURL: url,
    url:'/api/category/',
    method:'post',
    data:datas
  })
}
