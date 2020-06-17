<template>
  <div>
    <div class="pay-container">
      <Alert show-icon>
        <Icon type="qr-scanner" slot="icon"/>
        <template slot="desc">
          <div style="display: flex;width: 100%;">
            订单提交成功，请尽快付款！订单号：{{orderId}}
            <div style="margin-left: 50%;display: flex;">
              应付金额
              <div style="color: red; font-size: 16px; font-weight: 700;">
                {{totalPrice}}
              </div>
              元
            </div>
          </div>
        </template>
      </Alert>
      <div class="pay-box">
        <div style="display: flex; flex-direction: row;">
          <div style="margin-top: 5px; margin-left: 20px; font-size: 30px; color: #76697a">微信支付</div>
          <div style="margin-left: 40%;margin-top: 25px; display: flex; flex-direction: row">
            距离二维码过期还剩
            <div style="color: red;">{{remainingTime}}
            </div>
            秒，过期后请刷新页面重新获取二维码。
          </div>
        </div>
        <div style="display: flex; align-items: center; justify-content: space-between;">
          <div class="pay-demo">
            <img src="static/img/pay/wx-pay.png">
          </div>
          <div class="pay-qr-scan">
            <img style="margin-left: 25px;" src="static/img/pay/pay-qrscan.png">
            <div class="pay-tips">
              <img src="static/img/pay/wx-pay-tip.png">
              <!--<router-link to="/payDone"><p>点击我, 完成支付</p></router-link>-->
            </div>
          </div>
        </div>
        <div style="display: flex; flex-direction: row; margin-left: 20px; cursor: pointer;" @click="backToPay">
          <Icon type="ios-arrow-left" size="25" color="#0aaefa"/>
          <div style="font-size: 15px;margin-left: 15px;color: #0aaefa;">选择其他支付方式</div>
        </div>
      </div>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {getOrderStatus, createOrder} from '../../api/order';

  export default {
    name: 'Pay',
    data() {
      return {
        orderId: '',
        totalPrice: '',
        remainingTime: '60',
        timer: ''
      };
    },
    methods: {
      syncOrderStatus() {
        if ('' != this.orderId) {
          let father = this;
          getOrderStatus(father.orderId).then(response => {
            console.log(response)
            if (response != null && response != 1) {
              clearInterval(father.timer);
              father.$router.push({
                name: 'PayDone',
                params: {
                  orderId: father.orderId
                }
              });
            }
          }).catch(err => {
            this.$Message.info({
              content: '请到订单中心查看订单支付结果！',
              duration: 5000,
              closable: true
            });
            clearInterval(father.timer);
          });
        }
      },
      backToPay() {
        this.$router.push({
          name: 'ToPay',
          params: {}
        })
      }
    },
    computed: {
      ...mapState(['userInfo'])
    },
    mounted() {
      this.orderId = this.$route.params.orderId;
      this.totalPrice = this.$route.params.totalPrice;
      this.timer = setInterval(this.syncOrderStatus, 5000);
    },
  };
</script>

<style scoped>
  .pay-container {
    margin-top: 5%;
    margin-left: 15%;
    margin-right: 15%;
  }

  .pay-box {
    /*background-color: #fff;*/
    /*box-shadow: darkgrey 5px 5px 15px 3px;*/
    /*top: 162px;*/
    /*left: 389px;*/
    /*z-index: 999;*/
    /*height: 500px;*/
    /*margin-left: 2%;*/
    /*margin-right: 2%;*/

    padding: 20px;
    border: 1px #ccc dotted;
  }

  .pay-demo {
    width: 50%;
    height: 100%;
    display: flex;
    justify-content: center;
    align-items: center;
  }

  .pay-demo img {
    height: 80%;
  }

  .pay-qr-scan {
    width: 50%;
    height: 100%;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
  }

  .pay-tips {
    width: 50%;
    text-align: center;
    font-size: 14px;
    line-height: 30px;
  }

  .pay-tips a {
    color: #999999;
  }
</style>
