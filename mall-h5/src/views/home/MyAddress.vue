<template>
  <div style="background-color: #fff;padding: 20px 20px 20px;">
    <div style="display: flex; flex-direction: row; align-items: center;">
      <div class="addAddress" @click="add">新增收货地址</div>
      <div style="margin-left:10px; color: #999;">您已创建2 个收货地址，最多可创建25 个</div>
    </div>

    <div class="address-box" v-for="(item, index) in address" :key="index">
      <div class="address-header">
        <span>{{item.name}}</span>
        <div class="address-action">
          <span @click="edit(index)"><Icon type="edit"></Icon> 修改</span>
          <span @click="del(index)"><Icon type="trash-a"></Icon> 删除</span>
        </div>
      </div>
      <div class="address-content">
        <p><span class="address-content-title"> 收 货 人 :</span> {{item.name}}</p>
        <p><span class="address-content-title">收货地区:</span> {{item.province}} {{item.city}} {{item.area}}</p>
        <p><span class="address-content-title">收货地址:</span> {{item.address}}</p>
        <p><span class="address-content-title">邮政编码:</span> {{item.postalcode}}</p>
      </div>
    </div>
    <Modal v-model="modal" width="600">
      <p slot="header">
        <Icon type="edit"></Icon>
        <span>{{modaltitle}}</span>
      </p>
      <div>
        <Form :model="formData" label-position="left" :label-width="100" :rules="ruleInline">
          <FormItem label="收件人" prop="name">
            <i-input v-model="formData.name" size="large"></i-input>
          </FormItem>
          <FormItem label="收件地区" prop="address" style="width: 100%;">
            <v-distpicker :province="formData.province" :city="formData.city" :area="formData.area"
                          @province="getProvince" @city="getCity" @area="getArea"/>
          </FormItem>
          <FormItem label="收件地址" prop="address">
            <i-input v-model="formData.address" size="large"></i-input>
          </FormItem>
          <FormItem label="手机号码" prop="phone">
            <i-input v-model="formData.phone" size="large"></i-input>
          </FormItem>
          <FormItem label="邮政编码" prop="postalcode">
            <i-input v-model="formData.postalcode" size="large"></i-input>
          </FormItem>
        </Form>
      </div>
      <div slot="footer">
        <Button type="primary" size="large" long @click="editAction">保存收货地址</Button>
      </div>
    </Modal>
  </div>
</template>

<script>
  import store from '@/vuex/store';
  import {mapState, mapActions} from 'vuex';
  import VDistpicker from 'v-distpicker';

  export default {
    name: 'MyAddress',
    data() {
      return {
        modal: false,
        modaltitle: '',
        formData: {
          name: '',
          address: '',
          phone: '',
          postalcode: '',
          province: '四川省',
          city: '成都市',
          area: '武侯区'
        },
        ruleInline: {
          name: [
            {required: true, message: '请输入姓名', trigger: 'blur'}
          ],
          address: [
            {required: true, message: '请输入地址', trigger: 'blur'}
          ],
          postalcode: [
            {required: true, message: '请输入邮政编码', trigger: 'blur'}
          ],
          phone: [
            {required: true, message: '手机号不能为空', trigger: 'blur'},
            {type: 'string', pattern: /^1[3|4|5|7|8][0-9]{9}$/, message: '手机号格式出错', trigger: 'blur'}
          ]
        }
      };
    },
    created() {
      this.loadAddress();
    },
    computed: {
      ...mapState(['address'])
    },
    methods: {
      ...mapActions(['loadAddress']),
      add() {
        this.modal = true;
        this.modaltitle = '添加地址';
        this.formData.province = '';
        this.formData.city = '';
        this.formData.area = '';
        this.formData.address = '';
        this.formData.name = '';
        this.formData.phone = '';
        this.formData.postalcode = '';
      },
      edit(index) {
        this.modal = true;
        this.modaltitle = '修改地址';
        this.formData.province = this.address[index].province;
        this.formData.city = this.address[index].city;
        this.formData.area = this.address[index].area;
        this.formData.address = this.address[index].address;
        this.formData.name = this.address[index].name;
        this.formData.phone = this.address[index].phone;
        this.formData.postalcode = this.address[index].postalcode;
      },
      editAction() {
        this.modal = false;
        this.$Message.success('修改成功');
      },
      del(index) {
        this.$Modal.confirm({
          title: '信息提醒',
          content: '你确定删除这个收货地址',
          onOk: () => {
            this.$Message.success('删除成功');
          },
          onCancel: () => {
            this.$Message.info('取消删除');
          }
        });
      },
      getProvince(data) {
        this.formData.province = data.value;
      },
      getCity(data) {
        this.formData.city = data.value;
      },
      getArea(data) {
        this.formData.area = data.value;
      }
    },
    components: {
      VDistpicker
    },
    store
  };
</script>

<style scoped>
  .addAddress {
    border: 1px solid #bfd6af;
    border-radius: 2px;
    font-weight: 700;
    padding: 0 14px;
    line-height: 28px;
    font-size: 14px;
    background-image: linear-gradient(to bottom, #f5fbef 0, #eaf6e2 100%);
    width: 8%;
  }

  .address-box {
    padding: 15px;
    border-radius: 5px;
    border: 2px solid #e6e6e6;
    margin-top: 15px;
  }

  .address-header {
    height: 35px;
    display: flex;
    justify-content: space-between;
    color: #232323;
    font-size: 18px;
  }

  .address-content {
    font-size: 14px;
  }

  .address-content-title {
    color: #999;
  }

  .address-action span {
    margin-left: 15px;
    font-size: 14px;
    color: #2d8cf0;
    cursor: pointer;
  }
</style>
