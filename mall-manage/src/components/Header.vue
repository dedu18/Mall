<template>
  <div class="header">
    <div class="logo">运营后台管理系统</div>
    <div class="header-right">
      <m-user/>
    </div>
  </div>
</template>

<script>
  import User from '../views/user/User'

  export default {
    data() {
      return {
        username: "默认用户"
      }
    },
    // computed:{
    //     username() {
    //       let username = localStorage.getItem('ms_username');
    //       return username ? username : this.name;
    //   }
    // },
    methods: {
      handleCommand(command) {
        if (command == 'loginout') {
          this.$router.push('/')
        }
      }
    },
    components: {
      "m-user": User
    },
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .header {
    width: 100%;
    height: 7%;
    font-size: 22px;
    color: #fff;
    background-color: #242f42;
    z-index: 0;
  }

  .logo {
    float: left;
    width: 250px;
    line-height: 70px;
    margin-left: 25px;
  }

  .header-right {
    float: right;
    padding-right: 50px;
    height: 70px;
  }

  a {
    text-decoration: none;
    color: black;
  }
</style>
