<template>
  <!-- 导航菜单 -->
  <div>
    <!-- 独立小标题-->
    <div class="nav-item">
      <ul>
        <li v-for="(item,index) in navItems" :key="index">
          <a href="#">{{item}}</a>
        </li>
      </ul>
    </div>
    <!-- 侧边导航和轮播图-->
    <div class="nav-body">
      <!-- 侧边导航 -->
      <div class="nav-side">
        <ul>
          <li @mouseenter="showDetail(0)" >
            <span class="nav-side-item">家用电器</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">手机</span> /
            <span class="nav-side-item">运营商</span> /
            <span class="nav-side-item">数码</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">电脑</span> /
            <span class="nav-side-item">办公</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">家居</span> /
            <span class="nav-side-item">家具</span> /
            <span class="nav-side-item">家装</span> /
            <span class="nav-side-item">厨具</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">男装</span> /
            <span class="nav-side-item">女装</span> /
            <span class="nav-side-item">童装</span> /
            <span class="nav-side-item">内衣</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">美妆个护</span> /
            <span class="nav-side-item">宠物</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">女鞋</span> /
            <span class="nav-side-item">箱包</span> /
            <span class="nav-side-item">钟表</span> /
            <span class="nav-side-item">珠宝</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">男鞋</span> /
            <span class="nav-side-item">运动</span> /
            <span class="nav-side-item">户外</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">汽车</span> /
            <span class="nav-side-item">汽车用品</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">母婴</span> /
            <span class="nav-side-item">玩具乐器</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">食品</span> /
            <span class="nav-side-item">酒类</span> /
            <span class="nav-side-item">生鲜</span> /
            <span class="nav-side-item">特产</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">礼品鲜花</span> /
            <span class="nav-side-item">农资绿植</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
            <span class="nav-side-item">医药保健</span> /
            <span class="nav-side-item">计生情趣</span>
          </li>
          <li @mouseenter="showDetail(1)" @mouseleave="hideDetail(1)">
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
              <CarouselItem  v-for="(item, index) in marketing.CarouselItems" :key="index">
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
    <transition name="fade">
      <div class="detail-item-panel panel-1" :duration="{ enter: 100, leave: 100 }" v-show="panel" @mouseenter="showDetail(1)" ref="itemPanel1" @mouseleave="hideDetail(1)">
        <div class="nav-detail-item">
          <span v-for="(item, index) in panelData.navTags" :key="index">{{item}} > </span>
        </div>
        <ul>
          <li v-for="(items, index) in panelData.navItems" :key="index" class="detail-item-row">
            <span class="detail-item-title">{{items.title}}
              <span class="glyphicon glyphicon-menu-right"></span>
            </span>
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
import { mapState } from 'vuex';
import {getAllCategoryNavList} from '@/api/category';

export default {
  name: 'IndexNav',
  data () {
    return {
      panel: false,
      navItems: [],
      panelData: {},
      panelDatas: []
    };
  },
  computed: {
    ...mapState(['marketing'])
  },
  methods: {
    showDetail (index) {
      this.panel = true;
      if (this.panelDatas.length > index) {
        this.panelData = this.panelDatas[index];
      }
    },
    hideDetail (index) {
      this.panel = false;
      this.panelData = {};
    }
  },
  mounted () {
    this.navItems = ['秒杀', '优惠券', 'PLUS会员', '品牌闪购', '拍卖', '时尚', '超市', '生鲜', '全球购'];

    getAllCategoryNavList(null).then(response => {
      this.panelDatas=response;
    });
    // {
    //   navTags: [ '清洁用品', '美妆商城', '美妆馆', '妆比社', '全球购美妆', '宠物馆' ],
    //   navItems: [
    //     {
    //       title: '面部护肤',
    //       tags: [ '补水保湿', '卸妆', '洁面', '爽肤水', '乳液面霜', '精华', '眼霜', '防晒', '面膜', '剃须', '套装' ]
    //     },
    //     {
    //       title: '洗发护发',
    //       tags: [ '洗发', '护发', '染发', '造型', '假发', '美发工具', '套装' ]
    //     },
    //     {
    //       title: '身体护理',
    //       tags: [ '补水保湿', '沐浴', '润肤', '精油', '颈部', '手足', '纤体塑形', '美胸', '套装' ]
    //     },
    //     {
    //       title: '口腔护理',
    //       tags: [ '牙膏/牙粉', '牙刷/牙线', '漱口水', '套装' ]
    //     },
    //     {
    //       title: '女性护理',
    //       tags: [ '卫生巾', '卫生护垫', '私密护理', '脱毛膏' ]
    //     },
    //     {
    //       title: '香水彩妆',
    //       tags: [ 'BB霜', '化妆棉', '女士香水', '男士香水', '底妆', '眉笔', '睫毛膏', '眼线', '眼影', '唇膏/彩' ]
    //     },
    //     {
    //       title: '清洁用品',
    //       tags: [ '纸品湿巾', '衣物清洁', '清洁工具', '家庭清洁', '一次性用品', '驱虫用品', '皮具护理' ]
    //     },
    //     {
    //       title: '宠物生活',
    //       tags: [ '水族世界', '狗粮', '猫粮', '猫狗罐头', '狗零食', '猫零食', '医疗保健', '宠物玩具', '宠物服饰' ]
    //     },
    //     {
    //       title: '香水彩妆',
    //       tags: [ 'BB霜', '化妆棉', '女士香水', '男士香水', '底妆', '眉笔', '睫毛膏', '眼线', '眼影', '唇膏/彩' ]
    //     },
    //     {
    //       title: '清洁用品',
    //       tags: [ '纸品湿巾', '衣物清洁', '清洁工具', '家庭清洁', '一次性用品', '驱虫用品', '皮具护理' ]
    //     },
    //     {
    //       title: '宠物生活',
    //       tags: [ '水族世界', '狗粮', '猫粮', '猫狗罐头', '狗零食', '猫零食', '医疗保健', '宠物玩具', '宠物服饰' ]
    //     }
    //   ]
    // });
    // this.$refs.itemPanel1.style.left =
    //   this.$refs.navSide.offsetLeft + this.$refs.navSide.offsetWidth + 'px';
    // this.$refs.itemPanel2.style.left =
    //   this.$refs.navSide.offsetLeft + this.$refs.navSide.offsetWidth + 'px';
    // this.$refs.itemPanel1.style.top = this.$refs.navSide.offsetTop + 'px';
    // this.$refs.itemPanel2.style.top = this.$refs.navSide.offsetTop + 'px';
  },
  updated () {
    // this.$refs.itemPanel1.style.left =
    //   this.$refs.navSide.offsetLeft + this.$refs.navSide.offsetWidth + 'px';
    // this.$refs.itemPanel2.style.left =
    //   this.$refs.navSide.offsetLeft + this.$refs.navSide.offsetWidth + 'px';
    // this.$refs.itemPanel1.style.top = this.$refs.navSide.offsetTop + 'px';
    // this.$refs.itemPanel2.style.top = this.$refs.navSide.offsetTop + 'px';
  },
  store
};
</script>

<style scoped>
.nav-item {
  width: 680px;
  height: 36px;
  margin: 0px auto;
}
.nav-item ul {
  list-style: none;
  margin-left: 15px;
}
.nav-item li {
  float: left;
  font-size: 16px;
  font-weight: bold;

  margin-left: 30px;
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
  width: 1020px;
  height: 485px;
  margin: 0px auto;
}
.nav-side {
  width: 200px;
  height: 100%;
  padding: 0px;
  color: #fff;
  float: left;
  background-color: #6e6568;
}
.nav-side ul {
  width: 100%;
  padding: 0px;
  padding-top: 15px;
  list-style: none;
}
.nav-side li {
  padding: 7.5px;
  padding-left: 15px;
  font-size: 14px;
  line-height: 18px;
}
.nav-side li:hover {
  background: #999395;
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

  margin-left: 14%;
  margin-top: 2px;
  background-color: #fff;
  position: absolute;
  top: 168px;
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
  background-color: #6e6568;
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
.detail-item{
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
