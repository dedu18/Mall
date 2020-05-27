<template>
  <div>
    <div class="logo"/>
    <div class="container">
      <div class="search">
        <input class="searchIpt" v-model="searchData" placeholder="输入你想查找的商品"/>
        <button class="searchBtn" @click="search">搜索</button>
      </div>
      <div class="hotwords">
        <a v-for="(item, index) in promotionTags" :key="index"><span @click="selectTags(index)">{{item}}</span></a>
      </div>
      <!-- 独立小标题-->
      <div class="nav-item">
        <ul>
          <li v-for="(item,index) in navItems" :key="index">
            <a href="/">{{item}}</a>
          </li>
        </ul>
      </div>
    </div>
  </div>
</template>

<script>
  export default {
    name: 'Search',
    data() {
      return {
        navItems: [],
        searchData: '',
        promotionTags: ['品质家具', '食品饮料', '5G', '手机配件', '家具换季', '买2免1', '领200神券', '199减100', '充100送20']
      };
    },
    methods: {
      closeTags(index) {
        this.promotionTags.splice(index, 1);
      },
      selectTags(index) {
        this.searchData = this.promotionTags[index];
      },
      search() {
        this.$router.push({path: '/goodsList', query: {searchData: this.searchData}});
      }
    },
    mounted() {
      this.navItems = ['秒杀', '优惠券', 'PLUS会员', '品牌闪购', '拍卖', '时尚', '超市', '生鲜', '全球购'];
    }
  };
</script>

<style scoped>
  .logo {
    position: absolute;
    left: 23%;
    top: 35px;
    background-image: url('../../../static/img/index/logo.jpg');
    width: 150px;
    height: 110px;
  }

  .container {
    padding-top: 15px;
    margin: 0px auto;
    display: flex;
    flex-direction: column;
    align-items: center;
    border-bottom: 1px solid #ddd;
    background-color: #fff;
  }

  .nav-item {
    display: inline;
    white-space: nowrap;
    padding-top: 10px;
  }

  .nav-item a {
    color: #e1251b;
    font-weight: bold;
  }

  .nav-item li {
    list-style: none;
    display: inline-block;
    overflow: hidden;
    height: 30px;
    line-height: 40px;
    font-size: 15px;
    color: #333;
    margin: 0 11px;
  }

  .search {
    display: flex;
    flex-direction: row;
    left: 260px;
    top: 25px;
    width: 520px;
    height: 32px;
    border: 2px solid #e2231a;
    /*background: #fff;*/
  }

  .searchIpt {
    width: 440px;
    height: 100%;
    padding: 2px 44px 2px 10px;
    border: 1px solid transparent;
    line-height: 26px;
    outline-color: transparent;
    font-size: 12px;
  }

  .searchBtn {
    border-radius: 0;
    width: 100px;
    height: 100%;
    line-height: 32px;
    border: none;
    background-color: #e1251b;
    font-size: 18px;
    font-weight: 700;
    color: #fff;
    outline-color: transparent;
    cursor: pointer; /*移入时手型指针*/
  }

  .hotwords {
    top: 85px;
    width: 550px;
    height: 20px;
    line-height: 20px;
    margin-top: 5px;
    margin-left: 30px;
  }

  .hotwords a {
    float: left;
    margin-right: 10px;
    white-space: nowrap;
    color: #999;
  }
</style>
