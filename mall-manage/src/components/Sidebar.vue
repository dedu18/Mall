<template>
    <div class="sidebar">
      <el-menu
        router
        class="sidebar-el-menu"
        background-color="#374255"
        text-color="#fff"
        active-text-color="#ffd04b">
        <el-menu-item index="home">
          <i class="el-icon-s-home"></i>
          <span slot="title">首页</span>
        </el-menu-item>

        <el-submenu index="1">
          <template slot="title">
            <i class="el-icon-shopping-bag-1"></i>
            <span slot="title">商品</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="/category">
              <template slot="title">
                <i class="el-icon-s-grid"></i>
                <span slot="title">类目管理</span>
              </template>
            </el-menu-item>
            <el-menu-item index="/brand">
              <template slot="title">
                <i class="el-icon-collection-tag"></i>
                <span slot="title">品牌管理</span>
              </template>
            </el-menu-item>
            <el-menu-item index="/specification">
              <template slot="title">
                <i class="el-icon-c-scale-to-original"></i>
                <span slot="title">规格管理</span>
              </template>
            </el-menu-item>
            <el-menu-item index="/goods">
              <template slot="title">
                <i class="el-icon-goods"></i>
                <span slot="title">商品管理</span>
              </template>
            </el-menu-item>
            <!--<el-menu-item index="/goodsedit">-->
              <!--<template slot="title">-->
                <!--<i class="el-icon-edit-outline"></i>-->
                <!--<span slot="title">商品编辑</span>-->
              <!--</template>-->
            <!--</el-menu-item>-->
          </el-menu-item-group>
        </el-submenu>

        <el-submenu index="2">
          <template slot="title">
            <i class="el-icon-document"></i>
            <span slot="title">订单</span>
          </template>
          <el-menu-item-group>
            <el-menu-item index="/order">
              <template slot="title">
                <i class="el-icon-s-grid"></i>
                <span slot="title">订单列表</span>
              </template>
            </el-menu-item>
            <!--<el-menu-item index="/orderdetail">-->
              <!--<template slot="title">-->
                <!--<i class="el-icon-s-grid"></i>-->
                <!--<span slot="title">订单详情</span>-->
              <!--</template>-->
            <!--</el-menu-item>-->
          </el-menu-item-group>
        </el-submenu>
      </el-menu>
    </div>
</template>

<script>
export default {
  name: 'Sidebar',
  data () {
    return {
      collapse:false
    }
  }
}
</script>

<style scoped>
.sidebar{
    top: 7%;
    left: 0;
    bottom: 0;

}
.sidebar-el-menu{
    width: 100%;
}
.sidebar>ul{
    height: 100%;
}
.el-submenu .el-menu-item {
  height: 40px;
  line-height: 20px;
  padding: 0 45px;
  text-align: center;
  min-width: 100px !important;
}
</style>
