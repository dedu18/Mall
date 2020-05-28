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
            <p>Dedu</p>
          </div>
          <Icon type="location"/>
          <span style="font-size: 16px;font-weight: bold;">收货地址</span>
          <div style="margin-left: 10px;font-size: 14px;margin-top: 5px;" name="myAddress">我的收货地址</div>
          <div style="margin-left: 10px;font-size: 14px;margin-top: 5px;" name="addAddress">添加收货地址</div>

          <Icon style="margin-top: 15px;" type="clipboard"/>
          <span style="font-size: 16px;font-weight: bold;">购物订单</span>
          <br/>
          <div style="margin-left: 10px;font-size: 14px;margin-top: 5px;" name="myOrder">我的订单</div>

          <Icon style="margin-top: 15px;" type="ios-cart"/>
          <span style="font-size: 16px;font-weight: bold;">购物车</span>
          <div style="margin-left: 10px;font-size: 14px;margin-top: 5px;" name="myShoppingCart">我的购物车</div>
        </div>
      </div>
      <!--右边部分-->
      <Layout style="margin-top: 1%;margin-left: 2%;">
        <Header style="background: #fff;">
          <h2>{{activeTitle}}</h2>
        </Header>
        <div class="content">
          <transition mode="out-in">
            <router-view></router-view>
          </transition>
        </div>
      </Layout>
    </div>
  </div>
</template>

<script>

  import Search from '../search/Search';

  export default {
    name: 'Home',
    data() {
      return {
        activeTitle: '我的订单',
        bar: {
          'myAddress': '我的收货地址',
          'addAddress': '添加收货地址',
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
    components: {
      Search
    },
    created() {
      this.onSelect("myAddress");
    }
  };
</script>

<style scoped>
  .container {
    margin-top: 1%;
    margin-left: 15%;
    margin-right: 15%;
    display: flex;
    flex-direction: row;
    background-color: #F5F5F5;
    height: 100%;
  }

  .container-left {
    display: flex;
    flex-direction: column;
    width: 15%;
  }

  .side-bar a {
    color: #232323;
  }

  .user-icon {
    height: 200px;
    display: flex;
    flex-direction: column;
    justify-content: center;
    align-items: center;
  }

  .user-icon span {
    font-size: 96px;
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

  .content {
    margin: 15px;
    background-color: #fff;
  }
</style>
