<template>
  <div>
    <m-breadcrumb/>
    <!-- 查询面板 -->
    <el-row>
      <el-card class="box-card">
        <el-form style="display: flex; flex-direction: row; justify-content: space-around;" size="mini" ref="searchdata" :model="searchdata" label-width="90px">
          <el-form-item label="商品货号：">
            <el-input v-model="searchdata.name"></el-input>
          </el-form-item>
          <el-form-item label="商品状态：">
            <el-select v-model="searchdata.region" placeholder="请选择商品状态">
              <el-option label="已上架" value="shanghai"></el-option>
              <el-option label="已下架" value="beijing"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="商品分类：">
            <el-select v-model="searchdata.region" placeholder="请选择商品分类">
              <el-option label="手机" value="shanghai"></el-option>
              <el-option label="服饰" value="beijing"></el-option>
            </el-select>
          </el-form-item>
          <el-form-item label="商品品牌：">
            <el-select v-model="searchdata.region" placeholder="请选择商品品牌">
              <el-option label="小米" value="shanghai"></el-option>
              <el-option label="华为" value="beijing"></el-option>
            </el-select>
          </el-form-item>

          <el-form-item>
            <div style="display: flex; flex-direction: row;">
              <el-button type="primary" icon="el-icon-search" @click="">立即查询</el-button>
              <el-button icon="el-icon-magic-stick" @click="resetFilterData">重置</el-button>
              <el-button type="success" icon="el-icon-plus" @click="handleAdd">添加新商品</el-button>
            </div>
          </el-form-item>
        </el-form>
      </el-card>
    </el-row>
    <br/>
    <el-row>
      <!-- 商品列表面板 -->
      <el-card class="box-card-main">
        <el-table
          :data="tableDataList"
          border
          :header-cell-style="thStyle"
          :cell-style="cellStyle">
          <el-table-column
            prop="spuId"
            label="编号"
            width="180">
          </el-table-column>
          <el-table-column
            prop="spuTitle"
            label="商品标题"
            width="180">
          </el-table-column>
          <el-table-column
            prop="categotyNames"
            label="所属类目">
          </el-table-column>
          <el-table-column
            prop="saleable"
            label="商品状态">
            <template slot-scope="scope">
              <div v-if="scope.row.saleable">
                <el-button type="success">已上架</el-button>
              </div>
              <div v-else>
                <el-button type="info">未上架</el-button>
              </div>
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
              <el-button size="mini" icon="el-icon-edit-outline" @click="handleEdit(scope.$index, scope.row.spuId)">编辑
              </el-button>
              <el-button size="mini" type="danger" icon="el-icon-delete" @click="handleDelete(scope.row.id)">删除
              </el-button>
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
    </el-row>

  </div>
</template>

<script>
  import {getAllGoods as getAllSpus} from '@/api/spu';

  export default {
    name: "goods",
    data() {
      return {
        total: 0,
        currentPage: 1,
        pageNum: 1,
        pageSize: 10,
        tableDataList: [],
        searchdata: {},
      };
    },
    methods: {
      thStyle() {
        return 'text-align:center'
      },
      cellStyle() {
        return 'text-align:center'
      },
      submit() {

      },
      resetFilterData() {
        this.searchdata = {}
      },
      handleAdd() {
        this.$router.push({
          path: '/goodsedit',
          query: {
            ptype: 1
          }
        })
      },
      handleEdit(index, spuId) {
        // this.$router.push({path:'/pms/updateProduct',query:{id:row.id}});
        this.$router.push({
          path: '/goodsedit',
          query: {
            ptype: 0,
            spuId: spuId
          }
        });
      },
      deleteRow(index, rows) {
        rows.splice(index, 1);
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
        // 分页查询SPU
        getAllSpus({
          pageSize: this.pageSize,
          pageNum: this.pageNum
        }).then(response => {
          this.total = response.total
          this.tableDataList = response.records
        });
      }
    },
    mounted() {
      this.handlePageChange()
    }
  }
</script>

<style scoped>
  body > {
    margin-bottom: 1%;
  }

  .box-card {
    margin-top: 1%;
  }

  .box-card-main {
  }
</style>
