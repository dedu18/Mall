import Vue from 'vue';
import Router from 'vue-router';
import Index from '@/components/Index';
const Login = resolve => require(['@/components/login/Login'], resolve);
const Register = resolve => require(['@/components/register/Register'], resolve);
const StepOne = resolve => require(['@/components/register/StepOne'], resolve);
const StepTwo = resolve => require(['@/components/register/StepTwo'], resolve);
const StepThree = resolve => require(['@/components/register/StepThree'], resolve);
const GoodsList = resolve => require(['@/components/goods/GoodsList'], resolve);
const GoodsDetail = resolve => require(['@/components/goods/GoodsDetail'], resolve);
const ShoppingCart = resolve => require(['@/components/cart/ShopCart'], resolve);
const Order = resolve => require(['@/components/cart/ShopCartOrder'], resolve);
const Pay = resolve => require(['@/components/pay/Pay'], resolve);
const PayDone = resolve => require(['@/components/pay/PayDone'], resolve);
const Freeback = resolve => require(['@/components/freeback/Freeback'], resolve);
const Home = resolve => require(['@/components/home/Home'], resolve);
const MyAddress = resolve => require(['@/components/home/MyAddress'], resolve);
const AddAddress = resolve => require(['@/components/home/AddAddress'], resolve);
const MyOrder = resolve => require(['@/components/home/MyOrder'], resolve);
const MyShoppingCart = resolve => require(['@/components/home/MyShoppingCart'], resolve);
const Merchant = resolve => require(['@/components/shop/Shop'], resolve);

Vue.use(Router);

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
          path: 'addAddress',
          name: 'AddAddress',
          component: AddAddress
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
