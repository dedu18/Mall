<template>
  <div>
    <div class="container-right-title">
      <h3 style="font-size: 16px;color: #333;">我的订单</h3>
    </div>
    <Table border :columns="columns" :data="orders.records" size="large" no-data-text="你还没有订单，快点去购物吧"/>
    <div class="page-size">
      <Page :total="orders.total" :page-size="this.pageSize" @on-change="handleCurrentChange"/>
    </div>
  </div>
</template>

<script>
  import {mapState} from 'vuex';
  import {getAllOrderByPage} from '@/api/order';

  export default {
    name: 'MyOrder',
    data() {
      return {
        orders: {
          total: 0,
          records: []
        },
        pageSize: 50,
        pageNum: 1,
        columns: [
          {
            title: '订单号',
            key: 'id',
            width: 180,
            align: 'center'
          },
          {
            title: '图片',
            key: 'img',
            width: 86,
            render: (h, params) => {
              return h('div', [
                h('img', {
                  attrs: {
                    src: params.row.img
                  }
                })
              ]);
            },
            align: 'center'
          },
          {
            title: '标题',
            key: 'title',
            align: 'center'
          },
          {
            title: '订单状态',
            width: 198,
            key: 'status',
            align: 'center'
          },
          {
            title: '支付类型',
            key: 'payType',
            width: 68,
            align: 'center'
          },
          {
            title: '支付金额（元）',
            key: 'totalPay',
            align: 'center'
          },
          {
            title: '购买时间',
            width: 120,
            key: 'createTime',
            align: 'center'
          }
        ]
      };
    },
    computed: {
      ...mapState(['userInfo'])
    },
    methods: {
      handleCurrentChange(currentPage) {
        this.pageNum = currentPage
        this.handlePageChange()
      },
      handlePageChange: function () {
        // 分页查询品牌
        getAllOrderByPage({
          pageSize: this.pageSize,
          pageNum: this.pageNum,
          sessionId: this.userInfo.sessionId
        }).then(response => {
          this.orders.total = response.total
          this.orders.records = response.records
        });
      },
    },
    mounted() {
      this.handlePageChange()
    }
  };
</script>

<style scoped>

  .container-right-title {
    background: #fff;
    border-bottom: 1px solid #f0f3ef;
    padding: 20px 20px 20px;
    display: flex;
    flex-direction: row;
    margin-bottom: 15px;
  }

  .page-size {
    margin: 15px 0px;
    display: flex;
    justify-content: flex-end;
  }
</style>
