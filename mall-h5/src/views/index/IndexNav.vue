<template>
  <!-- 导航菜单 -->
  <div class="container">
    <!-- 侧边导航和轮播图-->
    <div class="nav-body">
      <!-- 侧边导航 -->
      <div class="nav-side">
        <ul>
          <li style="padding: 1px 15px 4px 20px;" v-for="(items, index) in parentNavItems" :key="items.id"
              @mouseenter="showDetail(items.id)" @mouseleave="hideDetail()">
            <span class="nav-side-item">{{items.name}}</span>
          </li>
        </ul>
      </div>
      <!-- 右边图区 -->
      <div class="nav-content">
        <!-- 幻灯图 -->
        <div style="margin-left: 5px; width: 590px;">
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
              <img style="width: auto;height: auto;max-width: 100%;max-height: 100%;" :src="item">
            </router-link>
          </div>
        </div>
      </div>
    </div>
    <!-- 导航伸展-->
    <transition>
      <div class="detail-item-panel" :duration="{ enter: 1000, leave: 1000 }" v-show="panel"
           @mouseenter="showTransitionDetail()"
           @mouseleave="hideTransitionDetail()">
        <div class="nav-detail-item">
          <span v-for="(item, index) in panelData.navTags" :key="index">{{item}}> </span>
        </div>
        <ul>
          <li class="detail-item-row" v-for="(items, index) in panelData.navItems" :key="index">
            <span class="detail-item-title">{{items.title}}</span>
            <router-link :to="{path:'/goodsList', query: {categoryId : item.id}}" v-for="(item, subIndex) in items.tags"
                         :key="subIndex">
              <span class="detail-item">{{item.name}}</span>
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
  import {getAllCategoryNavList, getAllParentCategoryNavList} from '@/api/category';

  export default {
    name: 'IndexNav',
    data() {
      return {
        parentNavItems: [],
        panel: false,
        panelId: '',
        navItems: [],
        panelData: {
          navTags: [],
          navItems: []
        },
        allPanelData: new Map()
      };
    },
    computed: {
      ...mapState(['marketing'])
    },
    methods: {
      showDetail(index) {
        this.panel = true;
        if (this.allPanelData.get(index)) {
          this.panelData = this.allPanelData.get(index);
        } else {
          getAllCategoryNavList({
            parentId: index
          }).then(response => {
            this.panelData = response;
            this.allPanelData.set(index, response);
          });
        }
      },
      hideDetail() {
        this.panel = false;
      },
      showTransitionDetail() {
        this.panel = true;
      },
      hideTransitionDetail() {
        this.panel = false;
      }
    },
    mounted() {
      this.navItems = ['秒杀', '优惠券', 'PLUS会员', '品牌闪购', '拍卖', '时尚', '超市', '生鲜', '全球购'];
      getAllParentCategoryNavList().then(response => {
        this.parentNavItems = response;
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
    margin-left: 1%;
    margin-right: 25%;
    display: flex;
    height: 100%;
    flex-direction: row;
  }

  .nav-show {
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    margin-left: 10px;
    height: 100%;
    width: 190px;
  }

  /*导航图片*/
  .nav-show-img {
    cursor: pointer;
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
