<template>
  <div>
    <!-- 上面搜索 -->
    <Search></Search>
    <!--下面菜单与展示-->
    <div>
      <!-- 导航菜单和轮播图 -->
      <div class="container">
        <IndexNav></IndexNav>
      </div>
      <!-- 商品活动显示区域 -->
      <div class="content">
        <!-- 秒杀 -->
        <div class="seckill">
          <!-- 头部 -->
          <div class="seckill-head">
            <div class="seckill-icon">
              <img src="static/img/index/clock.png">
            </div>
            <div class="seckill-text">
              <span class="seckill-title">限时秒杀</span>
              <span class="seckill-remarks">总有你想不到的低价</span>
            </div>
            <div class="count-down">
              <span class="count-down-text">当前场次</span>
              <span class="count-down-num">{{ seckillsHours }}</span>
              <span class="count-down-point">:</span>
              <span class="count-down-num">{{ seckillsMinutes }}</span>
              <span class="count-down-point">:</span>
              <span class="count-down-num">{{ seckillsSeconds }}</span>
              <span class="count-down-text">后结束抢购</span>
            </div>
          </div>
          <!-- 内容 -->
          <div class="seckill-content">
            <div class="seckill-item" v-for="(item, index) in seckills.goodsList" :key="index">
              <div class="seckill-item-img">
                <router-link to="/goodsList">
                  <img :src="item.img">
                </router-link>
              </div>
              <div class="seckill-item-info">
                <p>{{item.intro}}</p>
                <p>
                <span class="seckill-price text-danger">
                  <Icon type="social-yen"></Icon>
                  {{item.price}}
                </span>
                  <span class="seckill-old-price">
                  <s>{{item.realPrice}}</s>
                </span>
                </p>
              </div>
            </div>
          </div>
        </div>
        <!-- 电脑专场 -->
        <div class="item-class">
          <!-- 头部 -->
          <div class="item-class-head">
            <span class="item-class-title">{{computer.title}}</span>
            <ul>
              <li v-for="(item, index) in computer.link" :key="index">
                <router-link to="/goodsList">{{item}}</router-link>
              </li>
            </ul>
          </div>
          <!-- 内容 -->
          <div class="item-class-content" v-for="(item, index) in computer.detail" :key="index">
            <!-- 上2/3部分 -->
            <div class="item-content-top">
              <div class="item-big-img">
                <router-link to="/goodsList">
                  <img :src="item.bigImg" alt="">
                </router-link>
              </div>
              <div class="item-four-img">
                <div class="item-four-detail" v-for="(subItem, index) in item.itemFour" :key="index">
                  <div class="item-four-detail-text">
                    <p class="pt_bi_tit">{{subItem.title}}</p>
                    <p class="pt_bi_promo">{{subItem.intro}}</p>
                  </div>
                  <div class="item-four-detail-img">
                    <router-link to="/goodsList">
                      <img :src="subItem.img" alt="">
                    </router-link>
                  </div>
                </div>
              </div>
            </div>
            <!-- 下1/3部分 -->
            <div class="item-content-bottom">
              <div class="item-content-bottom-img" v-for="(subImg, index) in item.itemContent" :key="index">
                <router-link to="/goodsList">
                  <img :src="subImg">
                </router-link>
              </div>
            </div>
          </div>
        </div>
        <!-- 爱吃专场 -->
        <div class="item-class">
          <div class="item-class-head item-class-eat-head">
            <span class="item-class-title">{{eat.title}}</span>
            <ul>
              <li v-for="(item, index) in eat.link" :key="index">
                <router-link to="/goodsList">{{item}}</router-link>
              </li>
            </ul>
          </div>
          <div class="item-class-content" v-for="(item, index) in eat.detail" :key="index">
            <div class="item-content-top">
              <div class="item-big-img">
                <img :src="item.bigImg" alt="">
              </div>
              <div class="item-four-img">
                <div class="item-four-detail" v-for="(subItem, index) in item.itemFour" :key="index">
                  <div class="item-four-detail-text">
                    <p class="pt_bi_tit pt_bi_tit-eat">{{subItem.title}}</p>
                    <p class="pt_bi_promo">{{subItem.intro}}</p>
                  </div>
                  <div class="item-four-detail-img">
                    <router-link to="/goodsList">
                      <img :src="subItem.img" alt="">
                    </router-link>
                  </div>
                </div>
              </div>
            </div>
            <div class="item-content-bottom">
              <div class="item-content-bottom-img" v-for="(subImg, index) in item.itemContent" :key="index">
                <router-link to="/goodsList">
                  <img :src="subImg">
                </router-link>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Search from '../search/Search';
  import IndexNav from '../index/IndexNav';
  import store from '../../vuex/store';
  import {mapState, mapActions, mapGetters, mapMutations} from 'vuex';

  export default {
    name: 'Index',
    created() {
      this.loadSeckillsInfo();
      this.loadCarouselItems();
      this.loadComputer();
      this.loadEat();
      if (this.userInfo.login) {
        this.loadShoppingCart();
      }
    },
    mounted() {
      const father = this;
      this.setIntervalObj = setInterval(function () {
        father.REDUCE_SECKILLS_TIME();
      }, 1000);
    },
    data() {
      return {
        setIntervalObj: null
      };
    },
    methods: {
      ...mapActions(['loadSeckillsInfo', 'loadCarouselItems', 'loadComputer', 'loadEat', 'loadShoppingCart']),
      ...mapMutations(['REDUCE_SECKILLS_TIME'])
    },
    computed: {
      ...mapState(['seckills', 'computer', 'eat', 'userInfo']),
      ...mapGetters(['seckillsHours', 'seckillsMinutes', 'seckillsSeconds'])
    },
    components: {
      Search,
      IndexNav
    },
    destroyed() {
      clearInterval(this.setIntervalObj);
    },
    store
  };
</script>

<style scoped>
  .container {
    background: #F6F6F6 url('../../../static/img/index/indexbgimg.png');
    height: 480px;
  }

  .content {
    margin: 0px auto;
    background-color: #F6F6F6;
  }

  /*****************************秒杀专栏开始*****************************/
  /*秒杀专栏*/
  .seckill {
    width: 1190px;
    height: 330px;
    margin: 15px auto;
    background-color: #fff;
  }

  .seckill-head {
    width: 100%;
    height: 50px;
    background-color: #e01222;
  }

  .seckill-icon {
    width: 68px;
    height: 100%;
    float: left;
  }

  .seckill-icon img {
    width: 35px;
    height: 35px;
    margin-top: 6px;
    margin-left: 15px;
    animation-name: shake-clock;
    animation-duration: 0.3s;
    animation-iteration-count: infinite; /*设置无线循环*/
  }

  /*定义闹钟震动动画关键帧*/
  @keyframes shake-clock {
    0% {
      transform: rotate(-8deg);
    }
    50% {
      transform: rotate(8deg);
    }
    100% {
      transform: rotate(-8deg);
    }
  }

  .seckill-text {
    width: 300px;
    height: 100%;
    float: left;
  }

  .seckill-text .seckill-title {
    font-size: 22px;
    line-height: 50px;
    color: #fff;
  }

  .seckill-text .seckill-remarks {
    margin-left: 5px;
    font-size: 10px;
    color: #fff;
  }

  /*倒计时*/
  .count-down {
    height: 100%;
    margin-right: 30px;
    line-height: 50px;
    float: right;
  }

  .count-down-text {
    color: #fff;
  }

  .count-down-num {
    padding: 3px;
    border-radius: 5px;
    background-color: #440106;
    font-size: 26px;
    font-weight: bold;
    color: #f90013;
  }

  .count-down-point {
    font-size: 26px;
    font-weight: bold;
    color: #440106;
  }

  .seckill-content {
    width: 100%;
    height: 280px;
  }

  .seckill-item {
    width: 183px;
    height: 250px;
    margin-top: 15px;
    margin-left: 15px;
    box-shadow: 0px 0px 8px #ccc;
    cursor: pointer;
    float: left;
  }

  .seckill-item-img {
    width: 160px;
    height: 160px;
    margin: 0px auto;
    overflow: hidden;
    border-bottom: 1px solid #ccc;
    background-color: #fff;
  }

  .seckill-item-img img {
    width: 130px;
    height: 130px;
    margin-left: 15px;
    margin-top: 15px;
    transition: margin-top 0.3s;
  }

  .seckill-item-img:hover img {
    margin-top: 6px;
    transition: margin-top 0.3s;
  }

  .seckill-item-info {
    padding: 5px;
    padding-left: 15px;
    padding-right: 15px;
    font-size: 12px;
    color: #009688;
  }

  .seckill-item-info i:first-child {
    font-size: 14px;
  }

  .seckill-price {
    margin-right: 5px;
    font-size: 25px;
    font-weight: bold;
  }

  /*****************************秒杀专栏结束*****************************/

  /*****************************商品专栏开始*****************************/
  .item-class {
    width: 1190px;
    height: 450px;
    margin: 15px auto;
    background-color: #fff;
  }

  .item-class-head {
    width: 100%;
    height: 50px;
    background-color: #4488a7;
  }

  .item-class-eat-head {
    width: 100%;
    height: 50px;
    background-color: #ecb226;
  }

  .item-class-head ul {
    list-style: none;
    float: right;
    margin-right: 30px;
    line-height: 50px;
  }

  .item-class-head a {
    padding: 6px;
    margin-left: 15px;
    font-size: 12px;
    background-color: #6da6be;
    border: 1px solid #6da6be;
    text-decoration: none;
    color: #fff;
  }

  .item-class-eat-head a {
    background-color: #eeb955;
    border: 1px solid #eeb955;
  }

  .item-class-head a:hover {
    border: 1px solid #fff;
  }

  .item-class-head li {
    float: left;
  }

  .item-class-title {
    font-size: 25px;
    line-height: 50px;
    color: #fff;
    margin-left: 15px;
  }

  .item-class-content {
    width: 49%;
    cursor: pointer;
    border-right: 1px solid #ccc;
    margin-left: 0.9%;
    float: left;
  }

  .item-class-content:nth-child(odd) {
    border: none;
  }

  .item-content-top {
    width: 580px;
    margin: 5px auto;
    background-color: #fff;
  }

  .item-big-img {
    width: 180px;
    height: 260px;
    overflow: hidden;
    float: left;
  }

  .item-big-img img {
    margin-left: 0px;
    transition: margin-left 0.3s;
  }

  .item-big-img:hover img {
    margin-left: -15px;
    transition: margin-left 0.3s;
  }

  .item-four-img {
    width: 350px;
    margin-left: 42px;
    float: left;
  }

  .item-four-detail img {
    margin-left: 0px;
    transition: margin-left 0.3s;
  }

  .item-four-detail:hover img {
    margin-left: -6px;
    transition: margin-left 0.3s;
  }

  .item-four-detail {
    width: 152px;
    height: 130px;
    float: left;
  }

  .item-four-detail:first-child {
    border-right: 0.5px solid #ccc;
    border-bottom: 0.5px solid #ccc;
  }

  .item-four-detail:nth-child(2) {
    border-left: 0.5px solid #ccc;
    border-bottom: 0.5px solid #ccc;
  }

  .item-four-detail:nth-child(3) {
    border-top: 0.5px solid #ccc;
    border-right: 0.5px solid #ccc;
  }

  .item-four-detail:last-child {
    border-top: 0.5px solid #ccc;
    border-left: 0.5px solid #ccc;
  }

  .item-four-detail-text {
    width: 50px;
    margin-left: 5px;
    margin-top: 15px;
    float: left;
  }

  .item-four-detail-img {
    width: 96px;
    margin-top: 15px;
    overflow: hidden;
    float: left;
  }

  .item-four-detail-img img {
    margin-left: 5px;
    width: 90px;
  }

  .pt_bi_tit {
    font-weight: bold;
    font-size: 12px;
    color: #4488a7;
  }

  .pt_bi_tit-eat {
    color: #ecb127;
  }

  .pt_bi_promo {
    color: #00695c;
  }

  .item-content-bottom {
    margin-top: 38px;
  }

  .item-content-bottom-img {
    width: 180px;
    margin-right: 10px;
    overflow: hidden;
    float: left;
  }

  .item-content-bottom-img img {
    margin-left: 0px;
    transition: margin-left 0.3s;
  }

  .item-content-bottom-img:hover img {
    margin-left: -15px;
    transition: margin-left 0.3s;
  }

  /*****************************商品专栏结束*****************************/
</style>
