<template>
  <div class="info-form">
    <Form ref="formValidate" :model="formValidate" :label-width="80" :rules="ruleValidate">
      <FormItem label="手机号" prop="phone">
        <i-input v-model="formValidate.phone" clearable size="large" placeholder="建议使用常用手机号"/>
      </FormItem>
      <FormItem label="验证码" prop="checkNum">
        <i-input v-model="formValidate.checkNum" size="large" placeholder="输入验证码">
          <Button slot="append" :disabled="isDisabledSendCode" style="width: 100px;" @click="sendVerificationCode">{{sendCodeCount === '' ? '发送验证码': sendCodeCount + 's后重新获取'}}
          </Button>
        </i-input>
      </FormItem>
      <Button type="error" size="large" long @click="handleSubmit('formValidate')">验证手机号</Button>
    </Form>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapMutations} from 'vuex';
  import {sendVerificationCode} from '../../api/user';

  export default {
    name: 'StepOne',
    data() {
      return {
        formValidate: {
          phone: '',
          checkNum: ''
        },
        formVerificationCodeMessage: '获取验证码',
        sendCodeTimer: null,
        sendCodeCount: '',
        isDisabledSendCode: false,
        ruleValidate: {
          phone: [
            {required: true, message: '手机号不能为空', trigger: 'blur'},
            {type: 'string', pattern: /^1[3|4|5|7|8][0-9]{9}$/, message: '手机号格式出错', trigger: 'blur'}
          ],
          checkNum: [
            {required: true, message: '必须填写验证码', trigger: 'blur'},
            {type: 'string', min: 4, max: 4, message: '验证码长度错误', trigger: 'blur'}
          ]
        }
      };
    },
    methods: {
      ...mapMutations(['SET_SIGN_UP_SETP']),
      sendVerificationCode() {
        if (this.formValidate.phone.length === 11) {
          sendVerificationCode({
            phone: this.formValidate.phone
          }).then(result => {
            if (result) {
              const TIME_COUNT = 120;
              if (!this.sendCodeTimer) {
                this.sendCodeCount = TIME_COUNT;
                this.isDisabledSendCode = true;
                this.sendCodeTimer = setInterval(() => {
                  if (this.sendCodeCount > 0 && this.sendCodeCount <= TIME_COUNT) {
                    this.sendCodeCount--;
                  } else {
                    this.isDisabledSendCode = false;
                    clearInterval(this.sendCodeTimer);
                    this.sendCodeTimer = null;
                    this.sendCodeCount = '';
                  }
                }, 1000)
              }
            }
          });
        } else {
          this.$Message.error({
            content: '请输入正确的手机号',
            duration: 6,
            closable: true
          });
        }
      },
      handleSubmit(name) { // 提交验证
        this.$refs[name].validate((valid) => {
          if (valid) {
            this.$router.push({path: '/Register/stepTwo', query: {phone: this.formValidate.phone}});
            this.SET_SIGN_UP_SETP(1);
          } else {
            this.$Message.error({
              content: '请填写正确的信息',
              duration: 6,
              closable: true
            });
          }
        });
      }
    },
    store,
    components: {
      sendVerificationCode
    }
  };
</script>

<style scoped>
  .info-form {
    width: 90% !important;
  }
</style>
