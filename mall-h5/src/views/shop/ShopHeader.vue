<template>
  <div class="shop-box">
    <div class="shop-container">
      <div class="shop-title">
        <div class="shop-title-icon">
          <img style="width: 100%;height: 100%;background-color: #fff;" :src="shopIntro.shopImg"/>
        </div>
        <div class="shop-title-content">
          <p><router-link to="/merchant">{{ shopIntro.shopName }}</router-link></p>
        </div>
      </div>
      <div class="shop-another-item">
        <div class="shop-another-item-detail" v-for="(item, index) in shopIntro.showGoods" :key="index">
          <div class="shop-another-item-img">
            <img :src="item.img" alt="">
          </div>
          <div class="shop-anoter-item-intro">
            <p>{{ item.intro[0] }}</p>
            <p>{{ item.intro[1] }}</p>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'ShopHeader',
  data () {
    return {
      shopIntro: {
        shopName: 'Apple 产品京东自营旗舰店',
        shopImg: 'static/img/shop/1.png',
        showGoods: [
          {
            img: 'static/img/goodsList/item-show-1.jpg',
            intro: [ '全身磨砂', '防指纹' ]
          },
          {
            img: 'static/img/goodsList/item-show-2.jpg',
            intro: [ '环保PP材质', '不发黄' ]
          },
          {
            img: 'static/img/goodsList/item-show-3.jpg',
            intro: [ '0.4mm纤细', '纤薄手感' ]
          }
        ]
      }
    };
  }
};
</script>

<style scoped>
/* 店铺介绍 */
.shop-box {
  width: 100%;
  height: 120px;
  background-color: #484848;
}

.shop-container {
  height: 100%;
  display: flex;
  flex-direction: row;
  justify-content: space-between;
  align-items: center;
  color: #fff;
}

.shop-title {
  display: flex;
  margin-left: 15%;
  flex-direction: row;
}

.shop-title-icon {
  width: 180px;
}

.shop-title-content {
  padding-top: 8px;
  margin-left: 15px;
}

.shop-title-content p {
  line-height: 26px;
  font-size: 20px;
}

.shop-title-content a {
  color: #fff;
}

.shop-another-item {
  display: flex;
  margin-right: 15%;
  flex-direction: row;
}

.shop-another-item-detail {
  display: flex;
  flex-direction: row;
  align-items: center;
  margin-left: 10px;
}

.shop-another-item-img {
  height: 80px;
  border-radius: 40px;
  overflow: hidden;
}

.shop-another-item-img img {
  width: 80px;
}

.shop-anoter-item-intro {
  margin-left: 15px;
}
</style>
