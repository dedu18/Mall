<template>
  <div>
    <Search></Search>
    <!-- 店铺头-->
    <ShopHeader></ShopHeader>
    <GoodsDetailNav></GoodsDetailNav>
    <!-- 商品面包屑-->
    <div class="shop-item-path">
      <div class="shop-nav-container">
        <Breadcrumb>
          <BreadcrumbItem to="/">首页</BreadcrumbItem>
          <BreadcrumbItem style="font-weight: 700;color: #495060;">手机壳</BreadcrumbItem>
          <BreadcrumbItem>手机保护套</BreadcrumbItem>
        </Breadcrumb>
      </div>
    </div>
    <!-- 商品Sku信息展示 -->
    <GoodsSku/>
    <!-- 商品Intro详细展示 -->
    <br/>
    <GoodsSpec/>
    <Spin size="large" fix v-if="isLoading" />
  </div>
</template>

<script>
  import Search from '../search/Search';
  import GoodsDetailNav from '../goods/GoodsDetailNav';
  import ShopHeader from '../shop/ShopHeader';
  import GoodsSku from '../goods/GoodsSku';
  import GoodsSpec from '../goods/GoodsSpec';
  import store from '@/vuex/store';
  import {mapState, mapActions} from 'vuex';

  export default {
    name: 'GoodsDetail',
    beforeRouteEnter(to, from, next) {
      window.scrollTo(0, 0);
      next();
    },
    data() {
      return {
        tagsColor: ['blue', 'green', 'red', 'yellow'],
        spuId: "4"
      };
    },
    methods: {
      ...mapActions(['loadGoodsInfo'])
    },
    computed: {
      ...mapState(['goodsInfo', 'isLoading'])
    },
    mounted() {
      this.spuId = this.$route.query.spuId;
      this.loadGoodsInfo(this.spuId);
    },
    components: {
      Search,
      ShopHeader,
      GoodsDetailNav,
      GoodsSku,
      GoodsSpec
    },
    store
  };
</script>

<style scoped>
  .shop-item-path {
    height: 38px;
    background-color: rgb(236, 235, 235);
    line-height: 38px;
    color: #2c2c2c;
  }

  .shop-nav-container {
    margin-left: 15%;
    width: 80%;
  }
</style>
