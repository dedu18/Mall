import http from '@/utils/http';

const url = "http://localhost:9001";

/**
 * 用户收货地址
 * @param id
 */
export function getUserDeliverAddress(params) {
  return http({
    baseURL: url,
    url: '/api/user/addresses',
    method: 'get',
    params: params
  })
}

/**
 * 用户登录
 * @param datas
 */
export function loginUser(datas) {
  return http({
    baseURL: url,
    url: '/api/user/session',
    method: 'post',
    data: datas
  })
}

/**
 * 用户注册
 * @param datas
 */
export function registerUser(datas) {
  return http({
    baseURL: url,
    url: '/api/user/',
    method: 'post',
    data: datas
  })
}

/**
 * 发送验证码
 * @param datas
 */
export function sendVerificationCode(params) {
  return http({
    baseURL: url,
    url: '/api/user/code',
    method: 'get',
    params: params
  })
}
