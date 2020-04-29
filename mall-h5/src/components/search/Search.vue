<template>
  <div class="container">
    <div class="search">
      <input class="searchIpt" v-model="sreachData" size="large" placeholder="输入你想查找的商品"/>
      <button class="searchBtn" @click="search"></button>
    </div>
    <Tag v-for="(item, index) in promotionTags" :key="index"><span @click="selectTags(index)">{{item}}</span></Tag>
  </div>
</template>

<script>
  export default {
    name: 'Search',
    data() {
      return {
        sreachData: '',
        promotionTags: ['手机配件', '家具换季', '买2免1', '领200神券', '199减100', '充100送20']
      };
    },
    methods: {
      closeTags(index) {
        this.promotionTags.splice(index, 1);
      },
      selectTags(index) {
        this.sreachData = this.promotionTags[index];
      },
      search() {
        this.$router.push({path: '/goodsList', query: {sreachData: this.sreachData}});
      }
    }
  };
</script>

<style scoped>
  .container {
    padding-top: 15px;
    margin: 0px auto;
    margin-bottom: 15px;
    width: 460px;
  }

  .search {
    /*position: absolute;*/
    display: flex;
    flex-direction: row;
    left: 260px;
    top: 25px;
    width: 500px;
    height: 32px;
    border: 2px solid #e2231a;
    background: #fff;
    /*margin: 5px 0px;*/
    /*border: 2px solid #e2231a;*/
  }

  .searchIpt {
    width: 440px;
    height: 100%;
    font-family: Microsoft YaHei,Heiti SC,tahoma,arial,Hiragino Sans GB,"\5B8B\4F53",sans-serif;
  }
  .searchIpt .text {
    left: 0;
    padding: 2px 44px 2px 17px;
    width: 425px;
    height: 26px;
    border: 1px solid transparent;
    line-height: 26px;
    font-size: 12px;
  }

  .searchBtn {
    /*margin-left: 440px;*/
    border-radius: 0;
    right: 0;
    width: 58px;
    height: 100%;
    line-height: 32px;
    border: none;
    background-color: #e1251b;
    font-size: 20px;
    font-weight: 700;
    color: #fff;
  }
</style>
