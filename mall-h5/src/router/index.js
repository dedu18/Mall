import Vue from 'vue';
import Router from 'vue-router';
import Index from '../views/Index';
const Login = resolve => require(['../views/login/Login'], resolve);
const Register = resolve => require(['../views/register/Register'], resolve);
const StepOne = resolve => require(['../views/register/StepOne'], resolve);
const StepTwo = resolve => require(['../views/register/StepTwo'], resolve);
const StepThree = resolve => require(['../views/register/StepThree'], resolve);
const GoodsList = resolve => require(['../views/goods/GoodsList'], resolve);
const GoodsDetail = resolve => require(['../views/goods/GoodsDetail'], resolve);
const ShoppingCart = resolve => require(['../views/cart/ShopCart'], resolve);
const Order = resolve => require(['../views/cart/ShopCartOrder'], resolve);
const Pay = resolve => require(['../views/pay/Pay'], resolve);
const PayDone = resolve => require(['../views/pay/PayDone'], resolve);
const Freeback = resolve => require(['../views/freeback/Freeback'], resolve);
const Home = resolve => require(['../views/home/Home'], resolve);
const MyAddress = resolve => require(['../views/home/MyAddress'], resolve);
const MyOrder = resolve => require(['../views/home/MyOrder'], resolve);
const MyShoppingCart = resolve => require(['../views/home/MyShoppingCart'], resolve);
const Merchant = resolve => require(['../views/shop/Shop'], resolve);

Vue.use(Router);

/**
 * 重写路由的push方法，解决当前页面路由到当前页面
 */
const routerPush = Router.prototype.push
Router.prototype.push = function push(location) {
  return routerPush.call(this, location).catch(error=> error)
}

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/', // 首页
      name: 'Index',
      component: Index
    },
    {
      path: '/Login', // 登录
      name: 'Login',
      component: Login
    },
    {
      path: '/Register', // 注册
      name: 'Register',
      component: Register,
      children: [
        {
          path: '/',
          name: 'index',
          component: StepOne
        },
        {
          path: 'stepOne',
          name: 'StepOne',
          component: StepOne
        },
        {
          path: 'stepTwo',
          name: 'StepTwo',
          component: StepTwo
        },
        {
          path: 'stepThree',
          name: 'StepThree',
          component: StepThree
        }
      ]
    },
    {
      path: '/goodsList', // 商品列表
      name: 'GoodsList',
      component: GoodsList
    },
    {
      path: '/goodsDetail', // 商品详情
      name: 'GoodsDetail',
      component: GoodsDetail
    },
    {
      path: '/shoppingCart', // 商品详情
      name: 'ShoppingCart',
      component: ShoppingCart
    },
    {
      path: '/order', // 订单页面
      name: 'Order',
      component: Order
    },
    {
      path: '/pay', // 支付页面
      name: 'Pay',
      component: Pay
    },
    {
      path: '/payDone', // 支付成功页面
      name: 'PayDone',
      component: PayDone
    },
    {
      path: '/freeback', // 反馈页面
      name: 'Freeback',
      component: Freeback
    },
    {
      path: '/home', // 主页
      name: 'Home',
      component: Home,
      children: [
        {
          path: '/',
          name: 'HomeIndex',
          component: MyOrder
        },
        {
          path: 'myAddress',
          name: 'MyAddress',
          component: MyAddress
        },
        {
          path: 'myOrder',
          name: 'MyOrder',
          component: MyOrder
        },
        {
          path: 'myShoppingCart',
          name: 'MyShoppingCart',
          component: MyShoppingCart
        }
      ]
    },
    {
      path: '/merchant',
      name: 'Merchant',
      component: Merchant
    }
  ]
});
