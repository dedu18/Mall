<template>
  <div class="container">
    <div class="search">
      <input class="searchIpt" v-model="searchData" size="large" placeholder="输入你想查找的商品"/>
      <button class="searchBtn" @click="search">搜索</button>
    </div>
    <Tag v-for="(item, index) in promotionTags" :key="index"><span @click="selectTags(index)">{{item}}</span></Tag>
  </div>
</template>

<script>
  export default {
    name: 'Search',
    data() {
      return {
        searchData: '',
        promotionTags: ['手机配件', '家具换季', '买2免1', '领200神券', '199减100', '充100送20']
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
    }
  };
</script>

<style scoped>
  .container {
    padding-top: 15px;
    margin: 0px auto;
    margin-bottom: 15px;
    width: 500px;
  }

  .search {
    /*position: absolute;*/
    display: flex;
    flex-direction: row;
    left: 260px;
    top: 25px;
    width: 520px;
    height: 32px;
    border: 2px solid #e2231a;
    background: #fff;
    /*margin: 5px 0px;*/
    /*border: 2px solid #e2231a;*/
  }

  .searchIpt {
    width: 440px;
    height: 100%;
    padding: 2px 44px 2px 10px;
    border: 1px solid transparent;
    line-height: 26px;
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
  }
</style>
