import Vue from 'vue'
import Router from 'vue-router'

Vue.use(Router)
/**
 * 重写路由的push方法
 */
const routerPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return routerPush.call(this, location).catch(error=> error)
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '',
      name: 'login',
      redirect: '/login',
    },
    {
      path: '/login',
      component: resolve => require(['../views/login/Login.vue'], resolve)
    },
    {
      path: '/home',
      component: resolve => require(['../components/Layout.vue'], resolve),
      name: 'home',
      meta: {title: '首页', needLogin: true},
      children: [{
        path: '/',
        component: resolve => require(['@/views/home/Dashboard.vue'], resolve),
        name: 'dashboard',
        meta: {title: '首页', needLogin: true},
      }]
    },
    {
      path: '/category',
      component: resolve => require(['../components/Layout.vue'], resolve),
      name: 'goodsmanage',
      meta: {title: '商品管理', needLogin: true},
      children: [{
        path: '/category',
        component: resolve => require(['@/views/category/Category'], resolve),
        name: 'category',
        meta: {title: '类目', needLogin: true},
      },
        {
          path: '/brand',
          component: resolve => require(['@/views/brand/Brand'], resolve),
          name: 'brand',
          meta: {title: '品牌', needLogin: true},
        },
        {
          path: '/specification',
          component: resolve => require(['@/views/specification/Specification'], resolve),
          name: 'specification',
          meta: {title: '规格', needLogin: true},
        },
        {
          path: '/goods',
          component: resolve => require(['@/views/goods/Goods'], resolve),
          name: 'goods',
          meta: {title: '商品', needLogin: true},
        },
        {
          path: '/goodsedit',
          component: resolve => require(['@/views/goods/GoodsEdit'], resolve),
          name: 'goodsedit',
          meta: {title: '商品编辑', needLogin: true},
        }]
    },
    {
      path: '/order',
      component: resolve => require(['../components/Layout.vue'], resolve),
      name: 'ordermanage',
      meta: {title: '订单管理', needLogin: true},
      children: [{
        path: '/order',
        component: resolve => require(['@/views/order/Order'], resolve),
        name: 'order',
        meta: {title: '订单列表', needLogin: true},
      },
        {
          path: '/orderdetail',
          component: resolve => require(['@/views/order/OrderDetail'], resolve),
          name: 'orderdetail',
          meta: {title: '订单详情', needLogin: true},
        }]
    },
    {
      path: '/404',
      component: resolve => require(['@/views/error/404.vue'], resolve)
    }
  ],
  model: history
})
