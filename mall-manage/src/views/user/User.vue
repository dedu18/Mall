<template>
  <div class="header-user-icon">
    <div class="user-avator">
      <img src="@/assets/img.png" alt="">
    </div>
    <el-dropdown trigger="click" @command="handleCommand">
                    <span class="el-dropdown-link">
                        {{username}}
                      <i class="el-icon-arrow-down el-icon--right"/>
                    </span>
      <el-dropdown-menu slot="dropdown">
        <el-dropdown-item>
          <a>个人信息</a>
        </el-dropdown-item>
        <el-dropdown-item>
          <a href="https://github.com/dedu18" target="_blank">github</a>
        </el-dropdown-item>
        <el-dropdown-item command="loginout">退出登录</el-dropdown-item>
      </el-dropdown-menu>
    </el-dropdown>
  </div>
</template>

<script>
    export default {
      name: "User",
      data () {
        return {
          username: "默认用户"
        }
      },
      methods:{
        handleCommand(command) {
          if(command == 'loginout') {
            this.$router.push('/')
          }
        }
      },
    }
</script>

<style scoped>
  .header-user-icon{
    display: flex;
    height: 70px;
    align-items: center;
  }
  .user-avator{
    margin-left: 10px;
  }
  .el-dropdown-link{
    color: white;
    cursor: pointer;
  }
  .user-avator img{
    display: block;
    width: 40px;
    height: 40px;
    border-radius: 50%;
    z-index: 999;
    padding-right: 10px;
  }
</style>
