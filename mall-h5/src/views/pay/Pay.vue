<template>
  <div>
    <div class="pay-container">
      <Alert show-icon>
        <Icon type="qr-scanner" slot="icon"></Icon>
        <template slot="desc">
          <div style="display: flex;width: 100%;">
            订单提交成功，请尽快付款！订单号：{{orderId}}
            <div style="margin-left: 50%;display: flex;">
              应付金额
              <div style="color: red;font-size: 16px;font-weight: 700;">
                {{totalPrice}}
              </div>
              元
            </div>
          </div>
        </template>
      </Alert>
      <div class="pay-box">
        <div class="pay-demo">
          <img src="static/img/pay/wx-pay.png">
        </div>
        <div class="pay-qr-scan">
          <img style="margin-left: 25px;" src="static/img/pay/pay-qrscan.png">
          <div class="pay-tips">
            <img src="static/img/pay/wx-pay-tip.png">
            <router-link to="/payDone"><p>点击我, 完成支付</p></router-link>
          </div>
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
      }
    },
    computed: {
      ...mapState(['userInfo'])
    },
    mounted() {
      let father = this;
      const data = {
        skuIds: father.$route.params.skuIds,
        sessionId: father.userInfo.sessionId,
        addressId: father.$route.params.addressId,
        sourceType: 2
      }
      createOrder(data).then(result => {
        if (result) {
          //创单成功
          father.orderId = result.orderId;
          father.totalPrice = result.totalPrice;
          father.timer = setInterval(this.syncOrderStatus, 5000);
        } else {
          this.$Message.error({
            content: '请稍后重试',
            duration: 5000,
            closable: true
          });
        }
      }).catch(result => {
        this.$Message.error({
          content: result,
          duration: 3000,
          closable: true
        });
      });
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
    height: 500px;
    display: flex;
    align-items: center;
    justify-content: space-between;
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
