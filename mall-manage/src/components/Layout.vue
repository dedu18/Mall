<template>
    <div class="wrapper">
        <m-header></m-header>
        <div style="display: flex;">
          <div class="left-container">
            <m-sidebar></m-sidebar>
          </div>
          <div class="main-container">
              <router-view></router-view>
          </div>
        </div>
    </div>
</template>

<script>
import Header from './Header'
import Sidebar from './Sidebar'
export default {
  name: 'Layout',
  data () {
    return {
      collapse:false
    }
  },
  created() {

  },
  components: {
      "m-header":Header,
      "m-sidebar":Sidebar
  }
}
</script>

<style>
.wrapper{
    height: 1000px;
    width: 100%;
    /*overflow-x:hidden;*/
    /*background-color: red;*/
}
.left-container{
  width: 10%;
  /*height: 100%;*/
  background-color: #374255;
  bottom: 0px;
  min-height: 1000px;
}
.main-container {
  width: 90%;
  height: 100%;
  margin-top: 1%;
  margin-left: 1%;
  margin-right: 1%;
}
</style>
