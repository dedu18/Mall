<template>
  <div>
    <m-breadcrumb />
    <el-card style="margin-top: 1%">
      <el-form style="display: flex; " ref="searchdata" :model="searchdata" label-width="100px">
        <el-form-item label="订单编号：">
          <el-input v-model="searchdata.name" style="width: 100%"></el-input>
        </el-form-item>
        <el-form-item label="订单状态：">
          <el-select v-model="searchdata.region" placeholder="请选择商品状态">
            <el-option label="新订单，待确认" value="shanghai"></el-option>
            <el-option label="已确认，待支付" value="beijing"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item>
          <el-button type="primary" icon="el-icon-search" @click="">立即查询</el-button>
          <el-button icon="el-icon-magic-stick">重置</el-button>
        </el-form-item>
      </el-form>
    </el-card>
    <el-card style="margin-top: 1%">
      <el-table
        :data="tableData"
        border
        style="width: 100%">
        <el-table-column
          prop="id"
          label="订单编号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="buyerId"
          label="用户账号"
          width="180">
        </el-table-column>
        <el-table-column
          prop="totalPrice"
          label="价格/元">
        </el-table-column>
        <el-table-column
          label="支付类型">
          <template slot-scope="scope">
            <div v-if="1 === scope.row.payType">支付宝</div>
            <div v-else-if="0 === scope.row.payType">微信</div>
            <div v-else-if="2 === scope.row.payType">银联</div>
          </template>
        </el-table-column>
        <el-table-column
          label="商品状态">
          <template slot-scope="scope">
            <div v-if="1 === scope.row.status"><el-button type="success">新订单，待支付</el-button></div>
            <div v-else-if="2 === scope.row.status"> <el-button type="info">已付款，待发货</el-button></div>
            <div v-else-if="3 === scope.row.status"> <el-button type="warning">已发货，待确认</el-button></div>
            <div v-else-if="4 === scope.row.status"> <el-button type="warning">已确认，交易成功</el-button></div>
            <div v-else-if="5 === scope.row.status"> <el-button type="warning">交易关闭</el-button></div>
          </template>
        </el-table-column>
        <el-table-column
          prop="createTime"
          label="添加时间">
        </el-table-column>
        <el-table-column
          prop="updateTime"
          label="修改时间">
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button size="mini" icon="el-icon-edit-outline" @click="handleOrderDetail(scope.$index, scope.row.id)">查看详情</el-button>
            <div v-if="0 === scope.row.saleable"><el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.row.id)">立即确认</el-button></div>
            <div v-if="1 === scope.row.saleable"><el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.row.id)">立即支付</el-button></div>
            <div v-if="2 === scope.row.saleable"><el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.row.id)">立即发货</el-button></div>
            <div v-if="3 === scope.row.saleable"><el-button size="mini" type="danger" icon="el-icon-delete" @click="handleLogisticsTracking(scope.row.id)">物流跟踪</el-button></div>
          </template>
        </el-table-column>
      </el-table>
      <div class="block">
        <el-pagination
          @size-change="handleSizeChange"
          @current-change="handleCurrentChange"
          :page-sizes="[10, 20, 50]"
          :page-size="pageSize"
          layout="total, sizes, prev, pager, next, jumper"
          :total="total">
        </el-pagination>
      </div>
    </el-card>
    <el-dialog title="订单跟踪"
               :visible.sync="logisticsVisible"
               width="40%">
      <el-steps direction="vertical"
                :active="6"
                finish-status="success"
                space="50px">
        <el-step  v-for="item in logisticsList"
                  :key="item.name"
                  :title="item.name"
                  :description="item.time"></el-step>
      </el-steps>
    </el-dialog>
  </div>
</template>

<script>
  import {getAllOrderByPage} from '@/api/order';

  export default {
    name: "Order",
    data() {
      return {
        searchdata: {},
        total: 0,
        currentPage: 1,
        pageNum: 0,
        pageSize: 10,
        tableData:[{
          id:1,
          createTime:"2019-09-20 11:40:00",
          buyerId:"陈达棍",
          totalPrice:"￥2699",
          status:3,
          payType:1,
          updateTime:'2019-09-20 11:40:00'
        }],
        logisticsVisible: false,
        logisticsList :[

        ]
      };
    },
  methods: {
    handleOrderDetail(idx ,id) {
      this.$router.push({
        path: '/orderDetail',
        query: {
          id: id
        }
      });
    },
    handleSizeChange(size) {
      this.pageSize = size
      this.handlePageChange()
    },
    handleCurrentChange(currentPage) {
      this.pageNum = currentPage
      this.handlePageChange()
    },
    handlePageChange: function () {
      // 分页查询品牌
      getAllOrderByPage({
        pageSize: this.pageSize,
        pageNum: this.pageNum
      }).then(response => {
        this.total = response.total
        this.tableData = response.records
      });
    },
    handleLogisticsTracking(id) {
      this.logisticsVisible = true;
      this.logisticsList = [{name: '订单已提交，等待付款',time:'2017-04-01 12:00:00 '},
        {name: '订单付款成功',time:'2017-04-01 12:00:00 '},
        {name: '在北京市进行下级地点扫描，等待付款',time:'2017-04-01 12:00:00 '},
        {name: '在分拨中心广东深圳公司进行卸车扫描，等待付款',time:'2017-04-01 12:00:00 '},
        {name: '在广东深圳公司进行发出扫描',time:'2017-04-01 12:00:00 '},
        {name: '到达目的地网点广东深圳公司，快件将很快进行派送',time:'2017-04-01 12:00:00 '},
        {name: '订单已签收，期待再次为您服务',time:'2017-04-01 12:00:00 '}];
    }
  },
  mounted () {
    this.handlePageChange()
  }
}
</script>

<style scoped>

</style>
