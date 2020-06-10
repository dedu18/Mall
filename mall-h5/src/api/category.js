import http from '@/utils/http';

const url = "http://localhost:9003";

export function getAllCategoryNavList (params) {
  return http({
    baseURL: url,
    url: '/api/category/h5/list',
    method: 'get',
    params: params
  });
}

export function getAllParentCategoryNavList () {
  return http({
    baseURL: url,
    url: '/api/category/h5/parent/list',
    method: 'get'
  });
}

export function getAllNavigationPictureList (params) {
  return http({
    baseURL: url,
    url: '/api/category/h5/picture/list',
    method: 'get',
    params: params
  });
}
