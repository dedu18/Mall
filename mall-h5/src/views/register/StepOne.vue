<template>
  <div class="form">
    <Form id="form" ref="form" :model="form" :label-width="80" :rules="ruleValidate">
      <FormItem label="手机号" prop="phone">
        <i-input v-model="form.phone" clearable size="large" placeholder="建议使用常用手机号"/>
      </FormItem>
      <FormItem>
        <!-- 点击式按钮建议高度介于36px与46px  -->
        <!-- 嵌入式仅需设置宽度，高度根据宽度自适应，最小宽度为200px -->
        <div id="vaptchaContainer" style="height: 36px;">
          <!--vaptcha-container是用来引入VAPTCHA的容器，下面代码为预加载动画，仅供参考-->
          <div class="vaptcha-init-main">
            <div class="vaptcha-init-loading">
              <a href="/" target="_blank">
                <img src="https://r.vaptcha.com/public/img/vaptcha-loading.gif"/>
              </a>
              <span class="vaptcha-text">Vaptcha启动中...</span>
            </div>
          </div>
        </div>
      </FormItem>
      <FormItem label="验证码" prop="checkNum">
        <i-input v-model="form.checkNum" size="large" placeholder="输入验证码">
          <Button slot="append" :disabled="isDisabledSendCode" style="width: 100px;" @click="sendVerificationCode">
            {{sendCodeCount === '' ? '发送验证码': sendCodeCount + 's后重新获取'}}
          </Button>
        </i-input>
      </FormItem>
      <Button type="error" size="large" long @click="handleSubmit('form')">验证手机号</Button>
    </Form>
  </div>
</template>

<script>
  // import { vaptcha } from '@/api/vaptcha'
  import store from '@/vuex/store';
  import {mapMutations} from 'vuex';
  import {sendVerificationCode} from '../../api/user';

  export default {
    name: 'StepOne',
    data() {
      return {
        form: {
          phone: '',
          checkNum: '',
          token: ''
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
      ...mapMutations(['SET_REGISTER_SETP']),
      sendVerificationCode() {
        if (this.form.phone.length === 11) {
          sendVerificationCode({
            phone: this.form.phone
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
            this.$router.push({path: '/Register/stepTwo', query: {phone: this.form.phone}});
            this.SET_REGISTER_SETP(1);
          } else {
            this.$Message.error({
              content: '请填写正确的信息',
              duration: 6,
              closable: true
            });
          }
        });
      },
      aa(token){
        console.log(token)
      }
    },
    store,
    components: {
      sendVerificationCode
    },
    mounted() {
      var that = this;
      window.vaptcha({
        //配置参数
        vid: '5ed75a0b206810709d86c00a', // 验证单元id
        type: 'click', // 展现类型 点击式
        container: '#vaptchaContainer', // 按钮容器，可为Element 或者 selector
        offline_server: 'xxxxx', // 离线模式服务端地址
      }).then(function (vaptchaObj) {
        vaptchaObj.render()// 调用验证实例 vaptchaObj 的 render 方法加载验证按钮
        vaptchaObj.renderTokenInput('#form')//以form的方式提交数据时，使用此函数向表单添加token值
        vaptchaObj.listen("pass", function (that) {
          // 验证成功进行后续操作
          return vaptchaObj.getToken();
        });
        //关闭验证弹窗时触发
        vaptchaObj.listen("close", function () {
          //验证弹窗关闭触发
        });
      })
    }
  };
</script>

<style scoped>
  .form {
    width: 90% !important;
  }

  .vaptcha-init-main {
    display: table;
    width: 100%;
    height: 100%;
    background-color: #eeeeee;
  }

  ​
  .vaptcha-init-loading {
    display: table-cell;
    vertical-align: middle;
    text-align: center;
  }

  ​
  .vaptcha-init-loading > a {
    display: inline-block;
    width: 18px;
    height: 18px;
    border: none;
  }

  ​
  .vaptcha-init-loading > a img {
    vertical-align: middle;
  }

  ​
  .vaptcha-init-loading .vaptcha-text {
    font-family: sans-serif;
    font-size: 12px;
    color: #cccccc;
    vertical-align: middle;
  }
</style>
