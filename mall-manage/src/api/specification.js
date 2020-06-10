import http from '@/utils/http'
const url = "http://localhost:9003"
export function getSpecGroupByCatId(id) {
  return http({
    baseURL: url,
    url:'/api/spec/group/category/' + id,
    method:'get'
  })
}

export function addSpecGroup(data) {
  return http({
    baseURL: url,
    url:'/api/spec/group/category/',
    method:'post',
    data:data
  })
}

export function modifySpecGroup(data) {
  return http({
    baseURL: url,
    url:'/api/spec/group/category/',
    method:'put',
    data:data
  })
}

export function deleteSpecGroupById(id) {
  return http({
    baseURL: url,
    url:'/api/spec/group/' + id,
    method:'delete'
  })
}
