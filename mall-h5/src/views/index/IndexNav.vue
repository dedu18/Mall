<template>
  <!-- 导航菜单 -->
  <div class="container">
    <!-- 侧边导航和轮播图-->
    <div class="nav-body">
      <!-- 侧边导航 -->
      <div class="nav-side">
        <ul>
          <li @mouseenter="showDetail(0)" @mouseleave="hideDetail()">
            <span class="nav-side-item">家用电器</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail()">
            <span class="nav-side-item">手机</span> /
            <span class="nav-side-item">运营商</span> /
            <span class="nav-side-item">数码</span>
          </li>
          <li @mouseenter="showDetail(2)" @mouseleave="hideDetail()">
            <span class="nav-side-item">电脑</span> /
            <span class="nav-side-item">办公</span>
          </li>
          <li @mouseenter="showDetail(3)" @mouseleave="hideDetail()">
            <span class="nav-side-item">家居</span> /
            <span class="nav-side-item">家具</span> /
            <span class="nav-side-item">家装</span> /
            <span class="nav-side-item">厨具</span>
          </li>
          <li @mouseenter="showDetail(4)" @mouseleave="hideDetail()">
            <span class="nav-side-item">男装</span> /
            <span class="nav-side-item">女装</span> /
            <span class="nav-side-item">童装</span> /
            <span class="nav-side-item">内衣</span>
          </li>
          <li @mouseenter="showDetail(5)" @mouseleave="hideDetail()">
            <span class="nav-side-item">美妆个护</span> /
            <span class="nav-side-item">宠物</span>
          </li>
          <li @mouseenter="showDetail(6)" @mouseleave="hideDetail()">
            <span class="nav-side-item">女鞋</span> /
            <span class="nav-side-item">箱包</span> /
            <span class="nav-side-item">钟表</span> /
            <span class="nav-side-item">珠宝</span>
          </li>
          <li @mouseenter="showDetail(7)" @mouseleave="hideDetail()">
            <span class="nav-side-item">男鞋</span> /
            <span class="nav-side-item">运动</span> /
            <span class="nav-side-item">户外</span>
          </li>
          <li @mouseenter="showDetail(8)" @mouseleave="hideDetail()">
            <span class="nav-side-item">汽车</span> /
            <span class="nav-side-item">汽车用品</span>
          </li>
          <li @mouseenter="showDetail(9)" @mouseleave="hideDetail()">
            <span class="nav-side-item">母婴</span> /
            <span class="nav-side-item">玩具乐器</span>
          </li>
          <li @mouseenter="showDetail(10)" @mouseleave="hideDetail()">
            <span class="nav-side-item">食品</span> /
            <span class="nav-side-item">酒类</span> /
            <span class="nav-side-item">生鲜</span> /
            <span class="nav-side-item">特产</span>
          </li>
          <li @mouseenter="showDetail(11)" @mouseleave="hideDetail()">
            <span class="nav-side-item">礼品鲜花</span> /
            <span class="nav-side-item">农资绿植</span>
          </li>
          <li @mouseenter="showDetail(12)" @mouseleave="hideDetail()">
            <span class="nav-side-item">医药保健</span> /
            <span class="nav-side-item">计生情趣</span>
          </li>
          <li @mouseenter="showDetail(13)" @mouseleave="hideDetail()">
            <span class="nav-side-item">图书</span> /
            <span class="nav-side-item">音像</span> /
            <span class="nav-side-item">电子书</span>
          </li>
        </ul>
      </div>
      <!-- 右边图区 -->
      <div class="nav-content">
        <!-- 幻灯图 -->
        <div>
          <Carousel autoplay loop>
            <CarouselItem v-for="(item, index) in marketing.carouselItems" :key="index">
              <router-link to="/goodsList">
                <img :src="item">
              </router-link>
            </CarouselItem>
          </Carousel>
        </div>
        <!-- 卡片图-->
        <div class="nav-show">
          <div class="nav-show-img" v-for="(item, index) in marketing.activity" :key="index">
            <router-link to="/goodsList">
              <img :src="item">
            </router-link>
          </div>
        </div>
      </div>
    </div>
    <!-- 导航伸展-->
    <transition>
      <div class="detail-item-panel" :duration="{ enter: 1000, leave: 1000 }" v-show="panel" @mouseenter="showDetail(1)" @mouseleave="hideDetail()">
        <div class="nav-detail-item">
          <span v-for="(item, index) in panelData.navTags" :key="index">{{item}} > </span>
        </div>
        <ul>
          <li class="detail-item-row" v-for="(items, index) in panelData.navItems" :key="index">
            <span class="detail-item-title">{{items.title}}</span>
            <router-link to="/goodsList" v-for="(item, subIndex) in items.tags" :key="subIndex">
              <span class="detail-item">{{item}}</span>
            </router-link>
          </li>
        </ul>
      </div>
    </transition>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapState} from 'vuex';
  import {getAllCategoryNavList} from '@/api/category';

  export default {
    name: 'IndexNav',
    data() {
      return {
        panel: false,
        navItems: [],
        panelData: {
          navTags: [],
          navItems: []
        },
        panelDatas: []
      };
    },
    computed: {
      ...mapState(['marketing'])
    },
    methods: {
      showDetail(index) {
        this.panel = true;
        if (this.panelDatas.length > index) {
          this.panelData = this.panelDatas[index];
        }
      },
      hideDetail() {
        this.panel = false;
        // this.panelData = {};
      }
    },
    mounted() {
      this.navItems = ['秒杀', '优惠券', 'PLUS会员', '品牌闪购', '拍卖', '时尚', '超市', '生鲜', '全球购'];
      getAllCategoryNavList(null).then(response => {
        this.panelDatas = response;
      });
    },
    store
  };
</script>

<style scoped>
  .container {
    margin-top: 10px;
  }

  .nav-item ul {
    list-style: none;
  }

  .nav-item li {
    float: left;
    font-size: 16px;
    font-weight: bold;
  }

  .nav-item a {
    text-decoration: none;
    color: #555555;
  }

  .nav-item a:hover {
    color: #d9534f;
  }

  /*大的导航信息，包含导航，幻灯片等*/
  .nav-body {
    margin-left: 23%;
    height: 485px;
  }

  .nav-side {
    width: 200px;
    height: 100%;
    padding: 0px;
    float: left;
    background-color: #fefefe;
  }

  .nav-side ul {
    width: 100%;
    list-style: none;
  }

  .nav-side li {
    padding: 7.5px;
    font-size: 14px;
    line-height: 18px;
  }

  .nav-side li:hover {
    background: #e3e4e5;
  }

  .nav-side-item:hover {
    cursor: pointer;
    color: #c81623;
  }

  /*导航内容*/
  .nav-content {
    width: 792px;
    margin-left: 15px;
    overflow: hidden;
    float: left;
  }

  /*导航图片*/
  .nav-show-img {
    margin-top: 10px;
    float: left;
  }

  .nav-show-img:nth-child(2) {
    margin-left: 12px;
  }

  /*显示商品详细信息*/
  .detail-item-panel {
    width: 815px;
    height: 490px;
    margin-left: 13%;
    background-color: #fff;
    box-shadow: darkgrey 5px 5px 15px 3px;
    position: absolute;
    top: 162px;
    left: 389px;
    z-index: 999;
  }

  .nav-detail-item {
    margin-left: 26px;
    margin-top: 15px;
    margin-bottom: 15px;
    cursor: pointer;
    color: #eee;
  }

  .nav-detail-item span {
    padding: 6px;
    padding-left: 12px;
    margin-left: 15px;
    font-size: 12px;
    background-color: #333333;
  }

  .nav-detail-item span:hover {
    margin-left: 15px;
    background-color: #f44336;
  }

  .detail-item-panel ul {
    list-style: none;
  }

  .detail-item-panel li {
    line-height: 38px;
    margin-left: 40px;
  }

  .detail-item-title {
    padding-right: 6px;
    font-weight: bold;
    font-size: 12px;
    cursor: pointer;
    color: #555555;
  }

  .detail-item-title:hover {
    color: #d9534f;
  }

  .detail-item-row a {
    color: #555555;
  }

  .detail-item {
    font-size: 14px;
    padding-left: 12px;
    padding-right: 8px;
    cursor: pointer;
    border-left: 1px solid #ccc;
  }

  .detail-item:hover {
    color: #d9534f;
  }
</style>
