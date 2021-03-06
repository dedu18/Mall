<template>
  <div>
    <Search></Search>
    <div class="goods-list-container">
      <Alert show-icon class="tips-box">
        小提示
        <Icon type="ios-lightbulb-outline" slot="icon"></Icon>
        <template slot="desc">请点击商品前的选择框，选择购物车中的商品，点击付款即可。</template>
      </Alert>
      <Table border ref="selection" :columns="columns" :data="shoppingCart" size="large" @on-selection-change="selectGoods"
             no-data-text="您的购物车没有商品，请先添加商品到购物车再点击购买"></Table>
      <div class="address-container">
        <h3>收货人信息</h3>
        <div class="address-box">
          <div class="address-check">
            <div class="address-check-name">
              <span><Icon type="ios-checkmark-outline"></Icon> {{checkAddress.name}}</span>
            </div>
            <div class="address-detail">
              <p>{{checkAddress.address}}</p>
            </div>
          </div>
          <Collapse>
            <Panel>
              选择地址
              <p slot="content">
                <RadioGroup vertical size="large" @on-change="changeAddress">
                  <Radio :label="item.addressId" v-for="(item, index) in address" :key="index">
                    <span>{{item.name}} {{item.province}} {{item.city}} {{item.address}} {{item.phone}} {{item.postalcode}}</span>
                  </Radio>
                </RadioGroup>
              </p>
            </Panel>
          </Collapse>
        </div>
      </div>
      <div class="remarks-container">
        <h3>备注</h3>
        <i-input v-model="remarks" size="large" placeholder="在这里填写备注信息" class="remarks-input"></i-input>
      </div>
      <div class="invoices-container">
        <h3>发票信息</h3>
        <p>该商品不支持开发票</p>
      </div>
      <div class="pay-container">
        <div class="pay-box">
          <p><span>提交订单应付总额：</span> <span class="money"><Icon type="social-yen"></Icon> {{totalPrice.toFixed(2)}}</span>
          </p>
          <div class="pay-btn">
            <Button style="background-color: #E4393C;" type="error" size="large" @click="submitOrder">支付订单</Button>
          </div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import Search from '../search/Search';
  import GoodsListNav from '../goods/GoodsListNav';
  import store from '@/vuex/store';
  import {mapState, mapActions} from 'vuex';

  export default {
    name: 'Order',
    beforeRouteEnter(to, from, next) {
      window.scrollTo(0, 0);
      next();
    },
    created() {
      this.getAddress();
    },
    data() {
      return {
        goodsSelectedList: [],
        columns: [
          {
            type: 'selection',
            width: 58,
            align: 'center'
          },
          {
            title: '图片',
            key: 'img',
            render: (h, params) => {
              return h('div', [
                h('img', {
                  attrs: {
                    src: params.row.img
                  },
                  style: {
                    width: '100px',
                    height: '100px'
                  }
                })
              ]);
            },
            align: 'center'
          },
          {
            title: '标题',
            key: 'title',
            align: 'center'
          },
          {
            title: '规格',
            key: 'package',
            align: 'center',
            render: (h, params) => {
              return h('div', params.row.packages.intro);
            }
          },
          {
            title: '数量',
            key: 'count',
            width: 58,
            align: 'center'
          },
          {
            title: '价格',
            key: 'price',
            align: 'center'
          }
        ],
        checkAddress: {
          addressId: '',
          name: '未选择',
          address: '请选择地址'
        },
        remarks: ''
      };
    },
    computed: {
      ...mapState(['userInfo', 'address', 'shoppingCart']),
      totalPrice() {
        let price = 0;
        this.goodsSelectedList.forEach(item => {
          price += item.price * item.count;
        });
        return price;
      }
    },
    methods: {
      ...mapActions(['loadAddress']),
      selectGoods(selection, row) {
        this.goodsSelectedList = selection;
      },
      submitOrder() {
        if (this.goodsSelectedList.length == 0) {
          this.$Message.error({
            content: '请选择下单商品！',
            duration: 3,
            closable: true
          });
        } else if (this.checkAddress.addressId == '') {
          this.$Message.error({
            content: '请选择收货地址！',
            duration: 3,
            closable: true
          });
        } else {
          var selectedGoodsIdList = this.goodsSelectedList.map(function (item) {
            return item.skuId;
          });
          this.$router.push({
            name: 'ToPay',
            params: {
              addressId: this.checkAddress.addressId,
              skuIds: selectedGoodsIdList.join(",")
            }
          });
        }
      },
      changeAddress(data) {
        const father = this;
        this.address.forEach(item => {
          if (item.addressId === data) {
            father.checkAddress.addressId = item.addressId;
            father.checkAddress.name = item.name;
            father.checkAddress.address = `${item.name} ${item.province} ${item.city} ${item.address} ${item.phone} ${item.postalcode}`;
          }
        });
      },
      getAddress() {
        this.loadAddress(this.userInfo.sessionId);
      }
    },
    mounted() {
      setTimeout(() => {
        this.$refs.selection.selectAll(true);
      }, 500);
    },
    components: {
      Search,
      GoodsListNav
    },
    store
  };
</script>

<style scoped>
  .goods-list-container {
    margin-top: 0.5%;
    margin-left: 15%;
    margin-right: 15%;
  }

  .tips-box {
    margin-bottom: 15px;
  }

  .address-container {
    margin-top: 15px;
  }

  .address-box {
    margin-top: 15px;
    padding: 15px;
    border: 1px #ccc dotted;
  }

  .address-check {
    margin: 15px 0px;
    height: 36px;
    display: flex;
    align-items: center;
  }

  .address-check-name {
    width: 120px;
    display: flex;
    justify-content: center;
    align-content: center;
    background-color: #ccc;
  }

  .address-check-name span {
    width: 120px;
    height: 36px;
    font-size: 14px;
    line-height: 36px;
    text-align: center;
    color: #fff;
    background-color: #f90013;
  }

  .address-detail {
    padding-left: 15px;
    font-size: 14px;
    color: #999999;
  }

  .remarks-container {
    margin: 15px 0px;
  }

  .remarks-input {
    margin-top: 15px;
  }

  .invoices-container p {
    font-size: 12px;
    line-height: 30px;
    color: #999;
  }

  .pay-container {
    margin: 15px;
    display: flex;
    justify-content: flex-end;
  }

  .pay-box {
    font-size: 18px;
    font-weight: bolder;
    color: #495060;
  }

  .money {
    font-size: 26px;
    color: #f90013;
  }

  .pay-btn {
    margin: 15px 0px;
    display: flex;
    justify-content: flex-end;
  }
</style>
