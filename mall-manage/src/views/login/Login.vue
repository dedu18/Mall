<template>
  <div class="login-wrap">
    <div class="ms-login">
      <el-form :model="ruleForm" :rules="rules" ref="ruleForm" label-width="0px" class="demo-ruleForm">
        <el-form-item prop="username">
          <el-input placeholder="username" v-model="ruleForm.username"></el-input>
        </el-form-item>
        <el-form-item prop="password">
          <el-input placeholder="password" v-model="ruleForm.password"></el-input>
        </el-form-item>
        <div class="login-btn">
          <el-form-item>
            <el-button type="primary" @click="submitForm('ruleForm')">登录</el-button>
            <el-button @click="resetForm('ruleForm')">重置</el-button>
          </el-form-item>
        </div>
      </el-form>
    </div>
  </div>
</template>

<script>
  import {login as login} from '@/api/user';

  export default {
    name: 'Login',
    data() {
      return {
        ruleForm: {
          username: "admin",
          password: "admin"
        },
        rules: {
          username: [
            {required: true, message: "请输入用户名", trigger: 'blur'}
          ],
          password: [
            {required: true, message: "请输入密码", trigger: 'blur'}
          ]
        }
      }
    },
    methods: {
      submitForm(formName) {
        this.$refs[formName].validate((valid) => {
          if (valid) {
            login({
              username: this.ruleForm.username,
              password: this.ruleForm.password
            }).then(response => {
              if (response) {
                localStorage.setItem('ms_username', this.ruleForm.username)
                this.$notify({
                  title: "成功",
                  message: "登录成功",
                  type: 'success',
                  duration: 1000
                })
                this.$router.push('/home')
              } else {
                this.$notify.error({
                  title: "失败",
                  message: "账号或密码错误",
                  duration: 1000
                })
                return false
              }
            });
          } else {
            return false
          }
        })
      },
      resetForm(formName) {
        this.$refs[formName].resetFields();
      }
    }
  }
</script>

<!-- Add "scoped" attribute to limit CSS to this component only -->
<style scoped>
  .login-wrap {
    position: fixed;
    width: 100%;
    height: 100%;
    background: #324157;
    margin: 0px;
  }

  .ms-login {
    position: absolute;
    left: 50%;
    top: 40%;
    width: 300px;
    height: 160px;
    margin: -150px 0 0 -190px;
    padding: 40px;
    border-radius: 5px;
    background: #ffffff;
  }

  .login-btn {
    text-align: center;
  }

  .login-btn button {
    display: inline-block;
    width: 100px;
    height: 36px;
  }
</style>
