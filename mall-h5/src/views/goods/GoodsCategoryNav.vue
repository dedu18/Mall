<template>
  <div class="item-class-show">
    <Row class="item-class-group" v-for="(items, index) in goodsNavInfo" :key="index">
      <i-col class="item-class-name" span="3">{{ items.navName }} :</i-col>
      <i-col class="item-class-select" span="21">
        <span v-for="(item, subIndex) in items.navValues" :key="subIndex">{{ item }}</span>
      </i-col>
    </Row>
  </div>
</template>

<script>
  import {mapState} from 'vuex';

  export default {
    name: 'GoodsCategoryNav',
    data() {
      return {
      };
    },
    computed: {
      ...mapState(['goodsNavInfo']),
    },
    created() {

    }
  };
</script>

<style scoped>
  .item-class-show {
    margin: 15px auto;
    width: 100%;
  }

  .item-class-group {
    margin-top: 1px;
    height: 45px;
    border-bottom: 1px solid #ccc;
  }

  .item-class-group:first-child {
    border-top: 1px solid #ccc;
  }

  .item-class-name {
    padding-left: 15px;
    line-height: 44px;
    color: #666;
    font-weight: bold;
    background-color: #f3f3f3;
  }

  .item-class-name:first-child {
    line-height: 43px;
  }

  .item-class-select span {
    margin-left: 15px;
    width: 160px;
    color: #005aa0;
    line-height: 45px;
    cursor: pointer;
  }
</style>
