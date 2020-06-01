<template>
  <div>
    <!-- 上面搜索 -->
    <Search></Search>
    <div class="container">
      <!-- 左边部分 -->
      <div class="container-left">
        <div>
          <div class="user-icon">
            <div class="user-img">
              <img src="/static/img/head.png">
            </div>
            <p style="margin-top:10px; font: 700 14px/25px Arial;">{{userInfo.nackname}}</p>
          </div>
          <div class="container-menu">
            <span class="container-left-menu">收货地址</span>
            <div class="container-left-submenu" @click="onSelect('myAddress')">我的收货地址</div>
          </div>

          <div class="container-menu">
            <span class="container-left-menu">购物订单</span>
            <div class="container-left-submenu" @click="onSelect('myOrder')">我的订单</div>
          </div>
          <div class="container-menu">
            <span class="container-left-menu">购物车</span>
            <div class="container-left-submenu" @click="onSelect('myShoppingCart')">我的购物车</div>
          </div>
        </div>
      </div>
      <!--右边部分-->
      <div class="container-right">
        <transition mode="out-in">
          <router-view></router-view>
        </transition>
      </div>
    </div>
  </div>
</template>

<script>
  import Search from '../search/Search';
  import {mapState} from 'vuex';

  export default {
    name: 'Home',
    data() {
      return {
        activeTitle: '我的订单',
        bar: {
          'myAddress': '我的收货地址',
          'myOrder': '我的订单',
          'myShoppingCart': '我的购物车'
        }
      };
    },
    methods: {
      onSelect(name) {
        this.activeTitle = this.bar[name];
        this.$router.push(`/home/${name}`);
      }
    },
    computed: {
      ...mapState(['userInfo'])
    },
    components: {
      Search
    },
    mounted() {
      this.onSelect('myOrder');
    }
  };
</script>

<style scoped>
  .container {
    display: flex;
    flex-direction: row;
    background-color: #F5F5F5;
    height: 100%;
  }

  .container-left {
    display: flex;
    flex-direction: column;
    width: 15%;
    margin-left: 3%;
  }

  .container-menu {
    background-color: #fff;
    border-bottom: 1px solid #f3f3f3;
    padding: 15px 20px;
  }

  .container-left-menu {
    margin-left: 10px;
    font-size: 16px;
    font-weight: 700;
  }

  .container-left-submenu {
    margin-left: 10px;
    font-size: 14px;
    margin-top: 5px;
    line-height: 32px;
    color: #333;
  }

  .container-right {
    margin-top: 15px;
    margin-left: 15px;
    margin-right: 3%;
    width: 100%;
  }

  .user-icon {
    height: 200px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
    background-color: #fff;
    border-bottom: 1px solid #f3f3f3;
  }

  .user-img {
    width: 96px;
    height: 96px;
    border-radius: 48px;
    overflow: hidden;
  }

  .user-img img {
    width: 100%;
  }
</style>
