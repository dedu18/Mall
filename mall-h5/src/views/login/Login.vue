<template>
  <div>
    <Row class="container">
      <i-col span="13" offset="2" class="login-img-box">
        <img src="static/img/login/login.jpg" alt="">
      </i-col>
      <i-col span="7" class="login-box">
        <div class="login-container">
          <div class="login-header">
            <p>账户登录</p>
          </div>
          <div class="form-box">
            <Form ref="form" :model="formDate" :rules="ruleInline">
              <FormItem prop="username">
                <i-input type="text" v-model="formDate.username" clearable size="large" placeholder="邮箱/用户名/登录手机">
                  <Icon type="person" slot="prepend"></Icon>
                </i-input>
              </FormItem>
              <FormItem prop="password">
                <i-input type="password" v-model="formDate.password" clearable size="large" placeholder="密码">
                  <Icon type="ios-locked-outline" slot="prepend"></Icon>
                </i-input>
              </FormItem>
              <FormItem>
                <Button type="error" size="large"
                        style="background: #e4393c;font-size: 20px;font-family: 'Microsoft YaHei';"
                        @click="handleSubmit('form')" long>登&nbsp;&nbsp;&nbsp;&nbsp;录
                </Button>
              </FormItem>
            </Form>
          </div>
        </div>
      </i-col>
    </Row>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapActions} from 'vuex';

  export default {
    name: 'Login',
    data() {
      return {
        formDate: {
          username: '',
          password: ''
        },
        ruleInline: {
          username: [
            {required: true, message: '请输入账户名', trigger: 'blur'}
          ],
          password: [
            {required: true, message: '请输入密码', trigger: 'blur'},
            {type: 'string', min: 6, message: '密码不能少于6位', trigger: 'blur'}
          ]
        }
      };
    },
    methods: {
      ...mapActions(['login']),
      handleSubmit(form) {
        const father = this;
        this.$refs[form].validate((valid) => {
          if (valid) {
            this.login(father.formDate).then(result => {
              if (result) {
                this.$Message.success('登录成功');
                father.$router.push('/').catch(error => error);
              } else {
                this.$Message.error('账户名与密码不匹配，请重新输入');
              }
            });
          }
        });
      }
    },
    store
  };
</script>

<style scoped>
  .container {
    margin-top: 30px;
    height: 485px;
    background: #e93854;
  }

  .login-img-box {
    height: 485px;
    overflow: hidden;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .login-img-box > img {
    width: 68%;
  }

  .login-box {
    height: 485px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .login-container {
    width: 80%;
    height: 280px;
    background: #fff;
  }

  .login-header {
    height: 50px;
    font-size: 20px;
    text-align: center;
    line-height: 50px;
    letter-spacing: 15px;
    color: #e4393c;
    font-weight: 700;
  }

  .form-box {
    width: 80%;
    margin: 30px auto;
  }
</style>
