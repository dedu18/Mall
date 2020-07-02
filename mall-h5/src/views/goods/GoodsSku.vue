<template>
  <div>
    <div class="item-detail-show">
      <!-- 左边图片区 -->
      <div class="item-detail-left">
        <div class="item-detail-big-img">
          <img :src="goodsInfo.goodsImg[imgIndex]" alt="">
        </div>
        <div class="item-detail-img-row">
          <div class="item-detail-img-small" v-for="(item, index) in goodsInfo.goodsImg" :key="index"
               @mouseover="showBigImg(index)">
            <img :src="item" alt="">
          </div>
        </div>
      </div>
      <!-- 右边商品信息区 -->
      <div class="item-detail-right">
        <!-- 标题短语 -->
        <div class="item-detail-title">
          <p>
            <span v-if="goodsInfo.phraseTitle.length != 0" class="item-detail-express">{{goodsInfo.phraseTitle}}</span>
            {{goodsInfo.title}}</p>
        </div>
        <!-- 小标题 -->
        <div class="item-detail-tag">
          <p>
            <span v-for="(item,index) in goodsInfo.tags" :key="index">【{{item}}】</span>
          </p>
        </div>
        <!-- 商品价格信息 -->
        <div class="item-detail-price-row">
          <div class="item-price-left">
            <div class="item-price-row">
              <p>
                <span class="item-price-title">京东价</span>
                <span class="item-price">￥{{Number(price).toFixed(2)}}</span>
              </p>
            </div>
            <div class="item-price-row">
              <p>
                <span class="item-price-title">优 惠 价</span>
                <span class="item-price-full-cut" v-for="(item,index) in goodsInfo.discount"
                      :key="index">{{item}}</span>
              </p>
            </div>
            <div class="item-price-row">
              <p>
                <span class="item-price-title">促&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;销</span>
                <span class="item-price-full-cut" v-for="(item,index) in goodsInfo.promotion"
                      :key="index">{{item}}</span>
              </p>
            </div>
          </div>
          <div class="item-price-right">
            <div class="item-remarks-sum">
              <p>累计评价</p>
              <p>
                <span class="item-remarks-num">{{goodsInfo.remarksNum}} 条</span>
              </p>
            </div>
          </div>
        </div>
        <!-- 选择SKU选择 -->
        <div class="item-select">
          <!-- SKU 开始 -->
          <div class="product-box">
            <div class="product-delcom" v-for="(spec,n) in saleDetail.specs">
              <div style="display: flex; flex-direction: row; align-items: center;">
                <p style="color: #999;font-size: 16px;">{{spec.name}}</p>
                <ul class="product-footerlist">
                  <li v-for="(specValue,index) in spec.specValues"
                      v-on:click="specificationBtn(specValue.name, n, $event, index)"
                      v-bind:class="[specValue.isShow ? '' : 'noneActive', subIndex[n] == index ? 'productActive' : '']">
                    {{specValue.name}}
                  </li>
                </ul>
              </div>
            </div>
          </div>
          <!-- SKU 结束 -->
        </div>
        <br>
        <div class="add-buy-car-box">
          <div class="add-buy-car">
            <InputNumber style="border: 1px solid #b8b8b8;" :min="1" v-model="count" size="large"></InputNumber>
            <Button style="background-color: #E4393C;" type="error" size="large" @click="addShoppingCartBtn()">加入购物车
            </Button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapActions, mapState} from 'vuex';
  import {getGoodsBySpuId} from '../../api/goods';

  export default {
    name: 'GoodsSku',
    props: {
      spuId: {
        type: String
      }
    },
    data() {
      return {
        count: 1,
        imgIndex: 0,
        saleDetail: {
          skus: [],
          specs: []
        },
        selectedSpecValueArray: [], //存放所有被选中的规格属性值
        skuInfoCacheMap: {}, //存放要和选中的值进行匹配的数据，这个对象的每个字段为逗号分隔的specs字符串，字段值为对应的sku对象
        subIndex: [], //是否选中 因为不确定是多规格还是单规格，所以这里定义数组来判断
        price: 0, //选中的规格所对应的SKU价钱
        selectedSkuId: '' //选中的规格所对应的SKUID
      };
    },
    computed: {
      ...mapState(['goodsInfo', 'userInfo'])
    },
    methods: {
      ...mapActions(['addShoppingCart', 'loadGoodsInfo']),
      showBigImg(index) {
        this.imgIndex = index;
      },
      addShoppingCartBtn() {
        if (this.checkContainEmptyStringOfArray(this.selectedSpecValueArray)) {
          this.$Message.error({
            content: '请选择商品的所有规格！',
            duration: 5,
            closable: true
          });
        } else {
          var sessionId = this.userInfo.sessionId;
          if (sessionId == null || sessionId == 'undefined' || sessionId == '') {
            this.$router.push('/login');
          } else {
            const data = {
              sessionId: sessionId,
              skuId: this.selectedSkuId,
              goodsId: 1,
              title: this.goodsInfo.title,
              count: this.count,
              img: this.goodsInfo.goodsImg[this.imgIndex],
              packages: {
                intro: this.selectedSpecValueArray.join("、"),
                img: this.goodsInfo.goodsImg[this.imgIndex]
              },
              price: this.price
            };
            this.addShoppingCart(data);
            this.$router.push('/shoppingCart');
          }
        }
      },
      checkContainEmptyStringOfArray(data) {
        if (data.length == 0 || data.length < this.saleDetail.specs.length) {
          return true;
        }
        for (var i = 0; i < data.length; i++) {
          if (data[i] === "")
            return true;
        }
        return false;
      },
      specificationBtn(item, n, event, index) {
        var self = this;
        if (self.selectedSpecValueArray[n] != item) {
          self.selectedSpecValueArray[n] = item;
          self.subIndex[n] = index;
        } else {
          self.selectedSpecValueArray[n] = "";
          self.subIndex[n] = -1; //去掉选中的颜色
        }
        self.checkEachSpecItem();
      },
      checkEachSpecItem() {
        var self = this;
        var specArray = self.saleDetail.specs;
        var result = []; //定义数组,储存被选中的规格属性值，如果该规格属性没被选，则为空值
        for (var idx in specArray) {
          result[idx] = self.selectedSpecValueArray[idx] ? self.selectedSpecValueArray[idx] : '';
        }
        for (var idx in specArray) { //这里的idx代表第几个规格属性
          var selectedSpecValue = result[idx]; //把选中的值存放到字符串last去
          for (var specValueIdx in specArray[idx].specValues) { //这里的specValueIdx代表该规格属性的第一个可选属性值，如颜色有红色，白色
            result[idx] = specArray[idx].specValues[specValueIdx].name; //赋值，存在直接覆盖，不存在往里面添加name值
            specArray[idx].specValues[specValueIdx].isShow = self.isSpecShow(result); //在数据里面添加字段isShow来判断是否可以选择
          }
          result[idx] = selectedSpecValue; //还原，目的是记录点下去那个值，避免下一次执行循环时被覆盖
        }
        if (this.skuInfoCacheMap[result]) {
          this.price = this.skuInfoCacheMap[result].price || '';
          this.selectedSkuId = this.skuInfoCacheMap[result].id || '';
        } else {
          this.price = 0
          this.selectedSkuId = ''
        }
        self.$forceUpdate(); //重绘
      },
      isSpecShow(result) {
        for (var i in result) {
          if (result[i] == '') {
            return true; //如果数组里有为空的值，那直接返回true
          }
        }
        if (this.skuInfoCacheMap[result]) {
          return this.skuInfoCacheMap[result].stock == 0 ? false : true; //匹配选中的数据的库存，若不为空返回true反之返回false
        } else {
          return false;
        }
      }
    },
    mounted() {
      const self = this;
      console.log(self.spuId)
      getGoodsBySpuId(self.spuId).then(response => {
        self.saleDetail = response.saleDetail;
        for (var i in self.saleDetail.skus) {
          self.skuInfoCacheMap[self.saleDetail.skus[i].specs] = self.saleDetail.skus[i]; //修改数据结构格式，改成键值对的方式，以方便和选中之后的值进行匹配
        }
        self.checkEachSpecItem();
      });
    },
    store
  };
</script>

<style scoped>
  <!--
  SKU样式

  -->
  .product-box {
    width: 100%;
    display: block;
    margin: 0 auto;
  }

  .product-delcom {
    padding: 10px 0;
  }

  .product-footerlist {
    margin-left: 5px;
    padding: 3px;
    font-size: 12px;
  }

  .product-footerlist li {
    border: 1px solid #606060;
    color: #606060;
    text-align: center;
    padding: 5px 20px;
    float: left;
    margin-right: 10px;
    cursor: pointer;
  }

  .product-footerlist li.productActive {
    border: 1px solid #e3393c;
  }

  .product-footerlist li.noneActive {
    background-color: #ccc;
    opacity: 0.4;
    color: #000;
    pointer-events: none;
  }

  .product-footer a {
    color: #fff;
    text-decoration: none;
    height: 88px;
    line-height: 88px;
    font-size: 28px;
  }

  /******************商品图片及购买详情开始******************/
  .item-detail-show {
    width: 80%;
    margin-left: 15%;
    display: flex;
    flex-direction: row;
    background-color: #fff;
  }

  .item-detail-left {
    width: 350px;
    margin-right: 30px;
  }

  .item-detail-big-img {
    width: 350px;
    height: 350px;
    box-shadow: 0px 0px 8px #ccc;
    cursor: pointer;
  }

  .item-detail-big-img img {
    width: 100%;
  }

  .item-detail-img-row {
    margin-top: 15px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
  }

  .item-detail-img-small {
    width: 68px;
    height: 68px;
    box-shadow: 0px 0px 8px #ccc;
    cursor: pointer;
  }

  .item-detail-img-small img {
    width: 100%;
  }

  /*商品选购详情*/
  .item-detail-right {
    width: 100%;
    display: flex;
    flex-direction: column;
  }

  .item-detail-title p {
    color: #666;
    font-size: 20px;
  }

  .item-detail-express {
    font-size: 14px;
    padding: 2px 3px;
    border-radius: 3px;
    background-color: #e4393c;
    color: #fff;
  }

  /*商品标签*/
  .item-detail-tag {
    font-size: 12px;
    color: #e4393c;
  }

  /*价格详情等*/
  .item-detail-price-row {
    padding: 5px;
    display: flex;
    flex-direction: row;
    justify-content: space-between;
    background-color: #f3f3f3;
  }

  .item-price-left {
    display: flex;
    flex-direction: column;
  }

  .item-price-title {
    color: #999999;
    font-size: 14px;
    margin-right: 15px;
  }

  .item-price-row {
    margin: 5px 0px;
  }

  .item-price {
    color: #e4393c;
    font-size: 23px;
    cursor: pointer;
  }

  .item-price-full-cut {
    margin-right: 5px;
    padding: 3px;
    color: #e4393c;
    font-size: 12px;
    background-color: #ffdedf;
    border: 1px dotted #e4393c;
    cursor: pointer;
  }

  .item-price-right {
    margin-top: 10px;
    margin-right: 20px;
  }

  .item-remarks-sum {
    padding: 9px 8px 0;
    border-left: 1px solid #ccc;
  }

  .item-remarks-sum p {
    color: #999999;
    font-size: 12px;
    line-height: 10px;
    text-align: center;
  }

  .item-remarks-num {
    line-height: 18px;
    color: #005eb7;
  }

  .item-select {
    display: flex;
    flex-direction: row;
    margin-top: 15px;
  }

  .item-select-img img {
    width: 100%;
  }

  .item-select-intro p {
    margin: 0px;
    padding: 5px;
  }

  .add-buy-car-box {
    width: 100%;
    margin-top: 15px;
    border-top: 1px dotted #ccc;
  }

  .add-buy-car {
    margin-top: 15px;
  }

  /******************商品图片及购买详情结束******************/
</style>
