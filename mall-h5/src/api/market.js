import http from '@/utils/http';

const url = "http://localhost:9003";

export function getSeckillInfoList (params) {
  return http({
    baseURL: url,
    url: '/api/market/h5/seckill/list',
    method: 'get',
    params: params
  });
}

/**
 * 专栏服务
 * @param id
 */
export function getSpecialByType(type) {
  return http({
    baseURL: url,
    url:'/api/market/h5/special/list/' + type,
    method:'get'
  })
}
