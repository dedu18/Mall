<template>
  <div>
    <div class="pay-done-box">
      <div style="display: flex;">
        <img style="height: 45px;" src="static/img/pay/success.png">
        <div style="margin-left:10px;margin-top:5px;font-weight: bold; font-size: 25px;color: #7bbc52">支付成功！我们会尽快为您发货！
        </div>
      </div>
      <div style="margin-left: 10px;margin-top: 20px;font-weight: 700;font-size: 16px;">
        <div>订单号：{{orderId}}</div>
      </div>

      <router-link to="/">
        <div style="margin-top: 80px;margin-left: 150px;font-size: 16px;">点击返回首页</div>
      </router-link>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'PayDone',
    data() {
      return {
        orderId: ''
      }
    },
    mounted() {
      this.orderId = this.$route.params.orderId
    }
  };
</script>

<style scoped>
  .pay-done-box {
    height: 600px;
    display: flex;
    margin-left: 40%;
    flex-direction: column;
    justify-content: center;
    align-items: flex-start;
  }
</style>
