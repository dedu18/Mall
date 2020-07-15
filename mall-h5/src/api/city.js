import http from '@/utils/http';

const url = "http://localhost:9001";

/**
 * 城市信息
 * @param id
 */
export function getCityInfo() {
  return http({
    baseURL: url,
    url: '/api/city',
    method: 'get',
  })
}
