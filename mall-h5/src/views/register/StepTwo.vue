<template>
  <div class="form">
    <Form ref="formValidate" :model="formValidate" :rules="ruleValidate" :label-width="80">
      <FormItem label="用户名" prop="name">
        <i-input v-model="formValidate.name" clearable size="large" placeholder="请输入你的姓名"></i-input>
      </FormItem>
      <FormItem label="邮箱" prop="mail">
        <i-input v-model="formValidate.mail" clearable size="large" placeholder="请输入你的邮箱"></i-input>
      </FormItem>
      <FormItem label="密码" prop="password">
        <i-input type="password" v-model="formValidate.password" clearable size="large" placeholder="请输入你的密码"></i-input>
      </FormItem>
      <FormItem label="确认密码" prop="repassword">
        <i-input type="password" v-model="formValidate.repassword" clearable size="large"
                 placeholder="请再次输入你的密码"></i-input>
      </FormItem>
      <Button type="error" size="large" long @click="handleSubmit('formValidate')">注册</Button>
    </Form>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapMutations, mapActions} from 'vuex';
  import {registerUser as registerUserAPI} from '../../api/user'

  export default {
    name: 'StepTwo',
    data() {
      const validateCheckPasswd = (rule, value, callback) => {
        if (value === '') {
          callback(new Error('请再次输入密码'));
        } else if (value !== this.formValidate.password) {
          callback(new Error('两次输入的密码不一样'));
        } else {
          callback();
        }
      };
      return {
        formValidate: {
          name: '',
          mail: '',
          password: '',
          repassword: ''
        },
        ruleValidate: {
          name: [
            {required: true, message: '用户名不能为空', trigger: 'blur'}
          ],
          mail: [
            {required: true, message: '邮箱不能为空', trigger: 'blur'},
            {type: 'email', message: '邮箱格式错误', trigger: 'blur'}
          ],
          password: [
            {required: true, message: '密码不能为空', trigger: 'blur'},
            {type: 'string', min: 6, message: '密码长度不能小于6', trigger: 'blur'}
          ],
          repassword: [
            {validator: validateCheckPasswd, trigger: 'blur'}
          ]
        }
      };
    },
    methods: {
      ...mapMutations(['SET_REGISTER_SETP']),
      ...mapActions(['registerUser']),
      handleSubmit(name) {
        const current = this;
        this.$refs[name].validate((valid) => {
          if (valid) {
            const userinfo = {
              username: this.formValidate.name,
              password: this.formValidate.password,
              mail: this.formValidate.mail,
              phone: this.$route.query.phone,
              checkNum: this.$route.query.checkNum
            };
            registerUserAPI(userinfo).then(result => {
              if (result) {
                this.registerUser(userinfo);
                this.$router.push({path: '/Register/stepThree'});
              } else {
                this.$Message.error({
                  content: '请稍后重试',
                  duration: 3,
                  closable: true
                });
              }
            }).catch(result => {
              this.$Message.error({
                content: result,
                duration: 3 * 1000,
                closable: true
              });
              current.$router.push({path: '/Register/stepOne'});
              current.SET_REGISTER_SETP(0);
            });
          }
        });
      }
    },
    store
  };
</script>

<style scoped>
  .form {
    width: 90% !important;
  }
</style>
