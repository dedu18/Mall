<template>
    <div class="search-nav">
      <div class="search-nav-container">
        <ul>
          <li>全部商品分类</li>
          <li><router-link to="/"><strong>首页</strong></router-link></li>
          <li><router-link to="/"><strong>美妆馆</strong></router-link></li>
          <li><router-link to="/"><strong>超市</strong></router-link></li>
          <li><router-link to="/"><strong>生鲜</strong></router-link></li>
          <li><router-link to="/"><strong>全球购</strong></router-link></li>
          <li><router-link to="/"><strong>闪购</strong></router-link></li>
          <li><router-link to="/"><strong>拍卖</strong></router-link></li>
          <li><router-link to="/"><strong>金融</strong></router-link></li>
        </ul>
      </div>
  </div>
</template>

<script>
export default {
  name: 'GoodsListNav'
};
</script>

<style scoped>
.search-nav{
  width: 100%;
  height: 1%;
  border-bottom: 2px solid #ea2b33;
}
.search-nav-container{
  width: 80%;
  margin-left: 15% ;
  height: 64px;
}
.search-nav-container ul{
  margin: 0px;
  padding-left: 0px;
  list-style: none;
}
.search-nav-container li{
  cursor: pointer;
  margin-left: 30px;
  line-height: 64px;
  color: #C81623;
  font-size: 18px;
  float: left;
}
.search-nav-container a{
  color: #333;
  text-decoration: none;
  ext-align: center;
  text-decoration: none;
  font-size: 20px;
  line-height: 33px;
}
.search-nav-container li:first-child{
  padding: 0px 38px;
  background: #ea2b33;
  margin: 0px;
  color: #fff;
}
</style>
