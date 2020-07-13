import http from '@/utils/http'

const url = "http://localhost:9003"

export function getAllCategoryTree(params) {
  return http({
    baseURL: url,
    url:'/api/category/management/tree',
    method:'get',
    params:params
  })
}

export function getAllCategoryList(params) {
  return http({
    baseURL: url,
    url:'/api/category/management/list',
    method:'get',
    params:params
  })
}

export function modifyCategoryById(data) {
  return http({
    baseURL: url,
    url:'/api/category/management/',
    method:'put',
    data:data
  })
}

export function deleteCategoryById(id) {
  return http({
    baseURL: url,
    url:'/api/category/management/' + id,
    method:'delete'
  })
}

export function addCategory(datas) {
  return http({
    baseURL: url,
    url:'/api/category/management/',
    method:'post',
    data:datas
  })
}
