<template>
  <div>
    <div class="pay-container">
      <Alert show-icon>
        <Icon type="qr-scanner" slot="icon"></Icon>
        <template slot="desc">
          <div style="display: flex;width: 100%;">
            <div>订单提交成功，请尽快付款！订单号：{{orderId}}</div>
            <div style="margin-left: 20px; display: flex;font-size: 10px;">
              请您在
              <div style="color: red;font-weight: 700;">{{remainingTime}}</div>
              内完成支付，否则订单会被自动取消
            </div>
            <div style="margin-left: 30%;display: flex;">
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
        <h2 style="margin-top: 20px;">支付方式</h2>
        <RadioGroup vertical size="large" @on-change="changePayChannel">
          <Radio :label="item" v-for="(item, index) in channel" :key="index"
                 style="margin-top: 50px;display: flex; flex-direction: row;">
            <span v-if="item == 1" style="display: flex; flex-direction: row; ">
              <img style="width: 30px;height: 30px;" src="../../../static/img/pay/PAY-UNION.png"/>
              <div>中国银联</div>
            </span>
            <span v-if="item == 2" style="display: flex; flex-direction: row;">
              <img style="width: 30px;height: 30px;" src="../../../static/img/pay/PAY-WEIXIN.png"/>
              <div>微信支付</div>
            </span>
          </Radio>
        </RadioGroup>
        <!--<div style="display: inline-block;color: #ddd;margin: 0 12px 0 12px;"> s s s</div>-->
        <div class="toPayBtn" @click="toPay">立即支付</div>
      </div>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {createOrder} from '../../api/order';

  export default {
    name: 'ToPay',
    data() {
      return {
        orderId: '',
        totalPrice: '',
        remainingTime: '01时59分58秒',
        channel: ['1', '2'],
        channelSelect: '',
        timer: ''
      };
    },
    methods: {
      changePayChannel(channel) {
        this.channelSelect = channel;
      },
      toPay() {
        if ('' == this.channelSelect) {
          this.$Message.error({
            content: '请选择支付方式！',
            duration: 5000,
            closable: true
          });
        } else {
          this.$router.push({
            name: 'Pay',
            params: {
              payChannel: this.channelSelect,
              orderId: this.orderId,
              totalPrice: this.totalPrice
            }
          })
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
    display: flex;
    flex-direction: column;
    justify-content: space-between;
    padding: 20px;
    border: 1px #ccc dotted;
  }

  .pay-demo img {
    height: 80%;
  }

  .toPayBtn {
    margin-top: 80px;
    width: 200px;
    height: 50px;
    line-height: 50px;
    text-align: center;
    background: #e31613;
    border: 1px solid #e31613;
    border-radius: 2px;
    font-family: Microsoft Yahei;
    font-size: 18px;
    font-weight: 700;
    color: #fff;
    margin-left: 80%;
    cursor: pointer;
  }

  .pay-tips a {
    color: #999999;
  }
</style>
