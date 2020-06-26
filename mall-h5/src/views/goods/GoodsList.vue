<template>
  <div>
    <div class="search-container">
      <!-- 搜索 -->
      <Search></Search>
    </div>
    <!-- 商品列表-->
    <div class="container">
      <!-- 面包屑-->
      <div class="bread-crumb">
        <Breadcrumb>
          <BreadcrumbItem to="/" style="color: #666;font-size: 18px;font-weight: 700;font-family: 'microsoft yahei';">
            <Icon type="ios-home-outline"></Icon>
            首页
          </BreadcrumbItem>
          <BreadcrumbItem to="/goodsList?searchData=">
            <Icon type="bag"></Icon>
            {{searchItem}}
          </BreadcrumbItem>
        </Breadcrumb>
      </div>
      <!-- 商品标签导航 -->
      <GoodsCategoryNav></GoodsCategoryNav>
      <!-- 商品展示容器 -->
      <div class="goods-box">
        <!-- 侧边广告-->
        <div class="as-box">
          <div class="item-as-title">
            <span>商品精选</span>
            <span>广告</span>
          </div>
          <div class="item-as" v-for="(item,index) in advertisingList" :key="index">
            <div class="item-as-img">
              <img :src="item.img" alt="">
            </div>
            <div class="item-as-price">
              <span>
                <Icon type="social-yen text-danger"></Icon>
                <span class="seckill-price text-danger">{{item.price}}</span>
              </span>
            </div>
            <div class="item-as-intro">
              <span>{{item.intro}}</span>
            </div>
            <div class="item-as-selled">
              已有<span>{{item.num}}</span>人评价
            </div>
          </div>
        </div>
        <!-- 右边商品列表区-->
        <div class="goods-list-box">
          <!-- 排序按钮-->
          <div class="goods-list-tool">
            <ul>
              <li v-for="(item,index) in goodsTool" :key="index" @click="orderBy(item.en, index)"><span
                :class="{ 'goods-list-tool-active': isAction[index]}">{{item.title}} <Icon
                :type="icon[index]"></Icon></span></li>
            </ul>
          </div>
          <!-- 商品列表-->
          <div class="goods-list">
            <div class="goods-show-info" v-for="(item, index) in orderGoodsList" :key="index">
              <!-- 商品图片-->
              <div class="goods-show-img">
                <router-link to="/goodsDetail"><img :src="item.img"/></router-link>
              </div>
              <!-- 商品价格-->
              <div class="goods-show-price">
                <span>
                  <Icon type="social-yen text-danger"></Icon>
                  <span class="seckill-price text-danger">{{item.price}}</span>
                </span>
              </div>
              <!-- 商品简介-->
              <div class="goods-show-detail">
                <span>{{item.intro}}</span>
              </div>
              <!-- 商品评价-->
              <div class="goods-show-num">
                已有<span>{{item.remarks}}</span>人评价
              </div>
              <!-- 商品店铺名称-->
              <div class="goods-show-seller">
                <span>{{item.shopName}}</span>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div class="goods-page">
        <Page :total="100" show-sizer></Page>
      </div>
    </div>
    <Spin size="large" fix v-if="isLoading"></Spin>
  </div>
</template>

<script>
  import Search from '../search/Search';
  import GoodsListNav from '../goods/GoodsListNav';
  import GoodsCategoryNav from '../goods/GoodsCategoryNav';
  import store from '@/vuex/store';
  import {mapState, mapActions, mapGetters, mapMutations} from 'vuex';

  export default {
    name: 'GoodsList',
    beforeRouteEnter(to, from, next) {
      window.scrollTo(0, 0);
      next();
    },
    data() {
      return {
        searchItem: '',
        isAction: [true, false, false],
        icon: ['arrow-up-a', 'arrow-down-a', 'arrow-down-a'],
        goodsTool: [
          {title: '综合排序', en: 'common'},
          {title: '销量', en: 'number'},
          {title: '价格', en: 'price'},
          {title: '评论数', en: 'remarks'},
          {title: '上架时间', en: 'saletime'}
        ]
      };
    },
    computed: {
      ...mapState(['advertisingList', 'isLoading']),
      ...mapGetters(['orderGoodsList'])
    },
    methods: {
      ...mapActions(['loadGoodsList']),
      ...mapMutations(['SET_GOODS_ORDER_BY']),
      orderBy(data, index) {
        this.icon = ['arrow-down-a', 'arrow-down-a', 'arrow-down-a'];
        this.isAction = [false, false, false];
        this.isAction[index] = true;
        this.icon[index] = 'arrow-up-a';
        this.SET_GOODS_ORDER_BY(data);
      }
    },
    created() {
      this.loadGoodsList();
    },
    mounted() {
      this.searchItem = this.$route.query.searchData;
    },
    components: {
      Search,
      GoodsListNav,
      GoodsCategoryNav
    },
    store
  };
</script>

<style scoped>
  .search-container {
    /*margin: 0px auto;*/
    /*margin-bottom: 15px;*/
  }

  .container {
    margin-top: 15px;
    margin-left: 15%;
    margin-right: 15%;
    display: flex;
    flex-direction: column;
  }

  .text-danger {
    color: #e4393c;
  }

  .seckill-price {
    margin-right: 5px;
    font-size: 25px;
    font-weight: bold;
  }

  .goods-box {
    display: flex;
    flex-direction: row;
  }

  /* ---------------侧边广告栏开始------------------- */
  .as-box {
    /*width: 16%;*/
    border: 1px solid #ccc;
  }

  .item-as-title {
    width: 100%;
    height: 36px;
    color: #B1191A;
    line-height: 36px;
    font-size: 18px;
  }

  .item-as-title span:first-child {
    margin-left: 20px;
  }

  .item-as-title span:last-child {
    float: right;
    margin-right: 15px;
    font-size: 10px;
    color: #ccc;
  }

  .item-as {
    width: 200px;
    margin: 18px 10px 0px 10px;
  }

  .item-as-img {
    width: 100%;
    height: 100%;
    margin: 0px auto;
  }

  .item-as-price span {
    font-size: 18px;
  }

  .item-as-intro {
    margin-top: 5px;
    font-size: 12px;
  }

  .item-as-selled {
    margin-top: 5px;
    font-size: 12px;
  }

  .item-as-selled span {
    color: #005AA0;
  }

  /* ---------------侧边广告栏结束------------------- */

  /* ---------------商品栏开始------------------- */
  .goods-list-box {
    margin-left: 15px;
    width: 85%;
  }

  .goods-list-tool {
    width: 100%;
    height: 38px;
    border: 1px solid #ccc;
    background-color: #F1F1F1;
  }

  .goods-list-tool ul {
    padding-left: 15px;
    list-style: none;
  }

  .goods-list-tool li {
    cursor: pointer;
    float: left;
  }

  .goods-list-tool span {
    padding: 5px 8px;
    border: 1px solid #ccc;
    border-left: none;
    line-height: 36px;
    background-color: #fff;
  }

  .goods-list-tool span:hover {
    border: 1px solid #E4393C;
  }

  .goods-list-tool i:hover {
    color: #E4393C;
  }

  .goods-list {
    display: flex;
    flex-wrap: wrap;
    justify-content: space-between;
  }

  .goods-show-img {
    width: 220px;
    height: 220px;
  }

  .goods-show-info {
    width: 240px;
    padding: 10px;
    margin: 15px 0px;
    border: 1px solid #fff;
    cursor: pointer;
  }

  .goods-show-info:hover {
    border: 1px solid #ccc;
    box-shadow: 0px 0px 15px #ccc;
  }

  .goods-show-price {
    margin-top: 6px;
  }

  .goods-show-detail {
    font-size: 12px;
    margin: 6px 0px;
  }

  .goods-show-num {
    font-size: 12px;
    margin-bottom: 6px;
    color: #009688;
  }

  .goods-show-num span {
    color: #005AA0;
    font-weight: bold;
  }

  .goods-show-seller {
    font-size: 12px;
    color: #E4393C;
  }

  .goods-page {
    margin-top: 20px;
    display: flex;
    justify-content: flex-end;
  }

  /* ---------------商品栏结束------------------- */
</style>
