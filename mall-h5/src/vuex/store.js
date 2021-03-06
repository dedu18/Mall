import Vue from 'vue';
import Vuex from 'vuex';
import * as actions from './actions';
import * as mutations from './mutations';
import * as getters from './getters';

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    isLoading: false, // 是否展示loading动画
    orderBy: 'sale', // 根据什么字段排序
    goodsInfo: { // 商品详情
      goodsImg: [],
      title: '',
      phraseTitle: '',
      tags: [],
      discount: [],
      promotion: [],
      remarksNum: 0,
      setMeal: [],
      saleDetail: {
        skus: [],
        specs: []
      },
      hotSales: [],
      goodsDetailIntroImages: [],
      globalSpecs: [],
      remarks: [{
        goodAnalyse: '',
        remarksTags: [],
        remarksNumDetail: []
      }]
    },
    userInfo: { // 用户信息
      login: false,
      username: '',
      nackname: ''
    },
    address:[],
    registerStep: 0, // 注册步骤
    marketing: { // 营销
      carouselItems: [], // 轮播图
      activity: [] // 活动
    },
    seckills: { // 秒杀
      deadline: {
        hours: 0,
        minute: 0,
        seconds: 0
      },
      goodsList: []
    },
    computer: {}, // 电脑专栏
    eat: {}, // 爱吃专栏
    goodsNavInfo: [], //商品筛选规格列表
    goodsList: [], // 商品列表
    goodsListTotal: 0,
    advertisingList: [], // 广告
    shoppingCart: [], // 购物车
    newShoppingCart: [], // 刚加入的购物车，作为展示
    recommend: [] // 推荐购买
  },
  getters,
  actions,
  mutations
})
;
