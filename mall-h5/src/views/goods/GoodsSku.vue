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
                <span class="item-price">￥{{price}}</span>
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
            <div class="product-delcom" v-for="(spec,n) in goodsDetail.specs">
              <div style="display: flex; flex-direction: row; align-items: center;">
                <p style="color: #999;font-size: 16px;">{{spec.name}}</p>
                <ul class="product-footerlist">
                  <li v-for="(specValue,index) in spec.specValues"
                      v-on:click="specificationBtn(specValue.name,n,$event,index)"
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
  import {mapState, mapActions} from 'vuex';

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
        selectBoxIndex: 1,
        imgIndex: 0,

        goodsDetail: {
          skulist: [
            { //所有的规格可能情况都在这个数组里
              "id": "19",
              "price": "200.00",
              "stock": "19",
              "specs": "100,白色"
            },
            {
              "id": "20",
              "price": "100.00",
              "stock": "29",
              "specs": "200,白色"
            },
            {
              "id": "21",
              "price": "300.00",
              "stock": "10",
              "specs": "100,黑色"
            },
            {
              "id": "22",
              "price": "900.00",
              "stock": "0",
              "specs": "200,黑色"
            },
            {
              "id": "23",
              "price": "600.00",
              "stock": "48",
              "specs": "100,绿色"
            },
            {
              "id": "24",
              "price": "500.00",
              "stock": "40",
              "specs": "200,绿色"
            },
            {
              "id": "25",
              "price": "90.00",
              "stock": "0",
              "specs": "100,蓝色"
            },
            {
              "id": "26",
              "price": "40.00",
              "stock": "20",
              "specs": "200,蓝色"
            }
          ],
          specs: [
            { //这里是要被渲染字段
              "name": "尺寸",
              "specValues": [
                {
                  "name": "100",
                },
                {
                  "name": "200",
                }
              ]
            },
            {
              "name": "颜色",
              "specValues": [
                {
                  "name": "白色",
                },
                {
                  "name": "蓝色",
                },
                {
                  "name": "黑色",
                },
                {
                  "name": "绿色",
                }
              ]
            }
          ]
        },
        selectArr: [], //存放被选中的值
        shopItemInfo: {}, //存放要和选中的值进行匹配的数据
        subIndex: [], //是否选中 因为不确定是多规格还是单规格，所以这里定义数组来判断
        price: '', //选中规格的价钱
        skuIdSelected: ''
      };
    },
    computed: {
      ...mapState(['goodsInfo']),
      ...mapState(['userInfo'])
    },
    methods: {
      ...mapActions(['addShoppingCart']),
      showBigImg(index) {
        this.imgIndex = index;
      },
      addShoppingCartBtn() {
        if (this.checkContainEmptyStringOfArray(this.selectArr)) {
          this.$Message.error('请选择商品的所有规格！');
        } else {
          const date = new Date();
          const goodsId = date.getTime();
          var sessionId = this.userInfo.sessionId;
          if (sessionId == null || sessionId == 'undefined' || sessionId == '') {
            this.$router.push('/login');
          } else {
            const data = {
              sessionId: sessionId,
              skuId: sessionId,
              goodsId: this.skuIdSelected,
              title: this.goodsInfo.title,
              count: this.count,
              img: this.goodsInfo.goodsImg[this.imgIndex],
              packages: this.selectArr
            };
            this.addShoppingCart(data);
            this.$router.push('/shoppingCart');
          }
        }
      },

      checkContainEmptyStringOfArray(data) {
        if (data.length == 0 || data.length < this.goodsDetail.specs.length) {
          return true;
        }
        for (var i = 0; i < data.length; i++) {
          if (data[i] === "")
            return true;
        }
        return false;
      },

      specificationBtn: function (item, n, event, index) {
        var self = this;
        if (self.selectArr[n] != item) {
          self.selectArr[n] = item;
          self.subIndex[n] = index;
        } else {
          self.selectArr[n] = "";
          self.subIndex[n] = -1; //去掉选中的颜色
        }
        self.checkItem();
      },
      checkItem: function () {
        var self = this;
        var option = self.goodsDetail.specs;
        var result = []; //定义数组储存被选中的值
        for (var i in option) {
          result[i] = self.selectArr[i] ? self.selectArr[i] : '';
        }
        for (var i in option) {
          var last = result[i]; //把选中的值存放到字符串last去
          for (var k in option[i].specValues) {
            result[i] = option[i].specValues[k].name; //赋值，存在直接覆盖，不存在往里面添加name值
            option[i].specValues[k].isShow = self.isMay(result); //在数据里面添加字段isShow来判断是否可以选择
          }
          result[i] = last; //还原，目的是记录点下去那个值，避免下一次执行循环时被覆盖
        }
        if (this.shopItemInfo[result]) {
          this.price = this.shopItemInfo[result].price || '';
          this.skuIdSelected = this.shopItemInfo[result].id || '';
        }
        self.$forceUpdate(); //重绘
      },
      isMay: function (result) {
        for (var i in result) {
          if (result[i] == '') {
            return true; //如果数组里有为空的值，那直接返回true
          }
        }
        return this.shopItemInfo[result].stock == 0 ? false : true; //匹配选中的数据的库存，若不为空返回true反之返回false
      }
    },
    mounted() {
      const self = this;
      for (var i in self.goodsDetail.skulist) {
        self.shopItemInfo[self.goodsDetail.skulist[i].specs] = self.goodsDetail.skulist[i]; //修改数据结构格式，改成键值对的方式，以方便和选中之后的值进行匹配
      }
      self.checkItem();

      setTimeout(() => {
        self.price = self.goodsInfo.setMeal[0][0].price || 0;
      }, 300);
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
