<template>
  <div>
    <div class="pay-container">
      <Alert show-icon>
        <Icon type="qr-scanner" slot="icon"></Icon>
        <template slot="desc">
          <div style="display: flex;width: 100%;">
            订单提交成功，请尽快付款！订单号：123456789
            <div style="margin-left: 60%;display: flex;">
              应付金额
              <div style="color: red;font-size: 16px;font-weight: 700;">
                5999.00
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
  export default {
    name: 'Pay'
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
