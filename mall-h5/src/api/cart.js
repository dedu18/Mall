import http from '@/utils/http';

const url = "http://localhost:9002";

/**
 * 用户购物车
 * @param id
 */
export function getUserShopCartByUserId(userId) {
  return http({
    baseURL: url,
    url: '/api/cart/' + userId,
    method: 'get',
  })
}

/**
 * 添加购物车
 * @param id
 */
export function addGoodsToShopCart(datas) {
  return http({
    baseURL: url,
    url: '/api/cart/',
    method: 'post',
    data: datas
  })
}
