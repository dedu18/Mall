import http from '@/utils/http'

const url = "http://localhost:9004"

export function getAllOrderByPage(params) {
  return http({
    baseURL: url,
    url: '/api/order/list',
    method: 'get',
    params: params
  })
}

export function getOrderDetail(id) {
  return http({
    baseURL: url,
    url: '/api/order/' + id,
    method: 'get'
  })
}

export function getOrderStatus(id) {
  return http({
    baseURL: url,
    url: '/api/order/status/' + id,
    method: 'get'
  })
}

export function createOrder(datas) {
  return http({
    baseURL: url,
    url: '/api/order/',
    method: 'post',
    data: datas
  })
}
