<template>
  <div>
    <Row class="container">
      <div class="title">
        <h1>欢迎注册账号</h1>
      </div>
      <div class="step-box">
        <Steps :current="registerStep">
          <Step title="验证手机号" icon="iphone"></Step>
          <Step title="填写账号信息" icon="person-add"></Step>
          <Step title="注册成功" icon="ios-checkmark-outline"></Step>
        </Steps>
        <div class="box">
          <transition mode="out-in">
            <router-view></router-view>
          </transition>
        </div>
      </div>
    </Row>
    <Footer />
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapMutations, mapState} from 'vuex';

  export default {
    name: 'Register',
    data() {
      return {
        index: 0
      };
    },
    computed: {
      ...mapState(['registerStep'])
    },
    methods: {
      ...mapMutations(['SET_REGISTER_SETP'])
    },
    store,
    mounted() {
      this.SET_REGISTER_SETP(0);
    }
  };
</script>

<style scoped>
  .container {
    margin-top: 1%;
    height: 500px;
    overflow: hidden;
  }

  .title {
    width: 430px;
    margin: 15px auto;
    height: 50px;
  }

  .step-box {
    margin: 15px auto;
    padding-top: 30px;
    font-size: 30px;
    width: 430px;
    height: 380px;
  }

  .box {
    margin: 30px;
    width: 350px;
    display: flex;
    align-items: center;
  }
</style>
