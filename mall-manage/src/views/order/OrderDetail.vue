<template>
  <div>
    <m-breadcrumb />
    <div>
      <el-card shadow="never" style="margin-top: 1%">
        <div class="operate-container">
          <i class="el-icon-warning color-danger" style="margin-left: 20px"></i>
          <span class="color-danger">当前订单状态：
            <span v-if="order.status == 0" style="color:#F00">新订单，带支付</span>
            <span v-else-if="order.status == 1" style="color:#F00">新订单，待支付</span>
            <span v-else-if="order.status == 2" style="color:#F00">已支付，待发货</span>
            <span v-else-if="order.status == 3" style="color:#F00">已发货，待收货</span>
            <span v-else-if="order.status == 4" style="color:#F00">已收货，待评价</span>
          </span>
          <div class="operate-button-container">
            <el-button size="mini" >修改收货人信息</el-button>
            <el-button size="mini">修改商品信息</el-button>
            <el-button size="mini" >修改费用信息</el-button>
            <el-button size="mini" >发送站内信</el-button>
            <el-button size="mini" >关闭订单</el-button>
            <el-button size="mini" >备注订单</el-button>
          </div>
        </div>
        <div style="margin-top: 1%">
          <span style="font-size: 150%">基本信息</span>
        </div>
        <div class="table-layout">
          <el-row>
            <el-col :span="4" class="table-cell-title">订单编号</el-col>
            <el-col :span="4" class="table-cell-title">用户账号</el-col>
            <el-col :span="4" class="table-cell-title">商品名称</el-col>
            <el-col :span="4" class="table-cell-title">购买数量</el-col>
            <el-col :span="4" class="table-cell-title">订单来源</el-col>
            <el-col :span="4" class="table-cell-title">订单总金额</el-col>
          </el-row>
          <el-row>
            <el-col :span="4" class="table-cell">{{order.id}}</el-col>
            <el-col :span="4" class="table-cell">{{order.buyerId}}</el-col>
            <el-col :span="4" class="table-cell">{{order.title}}</el-col>
            <el-col :span="4" class="table-cell">{{order.payType}}</el-col>
            <el-col :span="4" class="table-cell">{{order.num}}</el-col>
            <el-col :span="4" class="table-cell">{{order.totalPrice}}</el-col>
          </el-row>
        </div>
        <el-divider></el-divider>
        <div style="margin-top: 1%">
          <span style="font-size: 150%">商品信息</span>
        </div>
        <div class="table-layout">
          <el-row>
            <el-col :span="4" class="table-cell-title">销售名称</el-col>
            <el-col :span="4" class="table-cell-title">商品预览</el-col>
            <el-col :span="4" class="table-cell-title">商品单价</el-col>
          </el-row>
          <el-row>
            <el-col :span="4" class="table-cell">{{order.sku.title}}</el-col>
            <el-col :span="4" class="table-cell">
              <el-image
              style="width: 25%; height: 25%"
              :src="order.sku.images" lazy/>
            </el-col>
            <el-col :span="4" class="table-cell">{{order.sku.price}}</el-col>
          </el-row>
        </div>
        <el-divider></el-divider>
        <div style="margin-top: 1%">
          <span style="font-size: 150%">物流信息</span>
        </div>
        <div class="table-layout">
          <el-row>
            <el-col :span="4" class="table-cell-title">物流名称</el-col>
            <el-col :span="4" class="table-cell-title">物流单号</el-col>
            <el-col :span="4" class="table-cell-title">收获地址</el-col>
            <el-col :span="4" class="table-cell-title">收货人名称</el-col>
            <el-col :span="4" class="table-cell-title">收货人手机</el-col>
            <el-col :span="4" class="table-cell-title">收货人邮编</el-col>
          </el-row>
          <el-row>
            <el-col :span="4" class="table-cell">{{order.logisticsName}}</el-col>
            <el-col :span="4" class="table-cell">{{order.logisticsCode}}</el-col>
            <el-col :span="4" class="table-cell">{{order.receiverAddress}}</el-col>
            <el-col :span="4" class="table-cell">{{order.receiverName}}</el-col>
            <el-col :span="4" class="table-cell">{{order.receiverMobile}}</el-col>
            <el-col :span="4" class="table-cell">{{order.receiverPostcode}}</el-col>
          </el-row>
        </div>
        <el-divider></el-divider>
        <div style="margin-top: 1%">
          <span style="font-size: 150%">支付信息</span>
        </div>
        <div class="table-layout">
          <el-row>
            <el-col :span="4" class="table-cell-title">支付方式</el-col>
            <el-col :span="4" class="table-cell-title">支付金额</el-col>
            <el-col :span="4" class="table-cell-title">支付状态</el-col>
            <el-col :span="4" class="table-cell-title">支付时间</el-col>
            <el-col :span="4" class="table-cell-title">退款时间</el-col>
          </el-row>
          <el-row>
            <el-col :span="4" class="table-cell">{{order.payType}}</el-col>
            <el-col :span="4" class="table-cell">{{order.totalPay}}</el-col>
            <el-col :span="4" class="table-cell">{{order.payStatus}}</el-col>
            <el-col :span="4" class="table-cell">{{order.payTime}}</el-col>
            <el-col :span="4" class="table-cell">{{order.refundTime}}</el-col>
          </el-row>
        </div>
      </el-card>
    </div>
  </div>
</template>

<script>
  import {getOrderDetail} from '@/api/order';

  export default {
    name: "OrderDetail",
    data() {
      return {
        order:{
          id: null,
          buyerId: null,
          num: null,
          totalPrice: null,
          title: null,
          sourceType: null,
          logisticsName: null,
          logisticsCode: null,
          receiverState: null,
          receiverCity: null,
          receiverDistrict: null,
          receiverAddress: null,
          receiverMobile: null,
          receiverPostcode: null,
          receiverName: null,
          createTime: null,
          updateTime: null,
          status: null,
          consignTime: null,
          endTime: null,
          closeTime: null,
          commentTime: null,
          statusCreateTime: null,
          statusUpdateTime: null,
          totalPay: null,
          payStatus: null,
          payType: null,
          payTime: null,
          payClosedTime: null,
          refundTime: null,
          sku:{
            title: null,
            images: null,
            price: null
          }
        },
      };
    },
  methods: {
  },
  created () {
      this.order.Id = this.$route.query.id
      getOrderDetail(this.order.Id).then(response => {
        this.order = response
      });
  }
}
</script>

<style scoped>
  .operate-button-container {
    float: right;
    margin-right: 20px
  }
  .operate-container {
    background: #F2F6FC;
    height: 80px;
    margin: -20px -20px 0;
    line-height: 80px;
  }
</style>
