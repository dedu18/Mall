<template>
  <div>
    <m-breadcrumb/>
    <div style=" margin-top: 1%; height: 100%; border: 1px">
      <el-row>
        <el-card class="box-card">
          <el-row :gutter="20">
            <el-col :span="6">关键字搜索：</el-col>
            <el-col :span="6">
              <el-input
                placeholder="请输入关键字"
                prefix-icon="el-icon-search"
              >
              </el-input>
            </el-col>
            <el-col :span="6">
              <el-button type="primary">搜索</el-button>
            </el-col>
            <el-col :span="6">
              <el-button type="primary" @click="brandDetailDialog = true">新增品牌</el-button>
            </el-col>
          </el-row>
        </el-card>
      </el-row>
      <el-row>
        <el-card class="box-card-main">
          <el-table
            :data="tableData"
            border>
            <el-table-column
              prop="id"
              label="编号"
              width="180">
            </el-table-column>
            <el-table-column
              prop="name"
              label="品牌名称"
              width="180">
            </el-table-column>
            <el-table-column
              label="品牌图片">
              <template slot-scope="scope">
                <img :src="scope.row.image" alt="" style="width: 100px;height:36px">
              </template>
            </el-table-column>
            <el-table-column
              prop="letter"
              label="品牌首字母">
            </el-table-column>
            <el-table-column label="操作">
              <template slot-scope="scope">
                <el-button size="mini" @click="handleEdit(scope.$index, scope.row)">编辑</el-button>
                <el-button size="mini" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
              </template>
            </el-table-column>
          </el-table>
          <div>
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
    <el-dialog
      title="提示"
      :visible.sync="brandDetailDialog"
      width="30%"
    >
      <el-form :model="brand" label-width="100px" class="demo-ruleForm">
        <el-form-item label="品牌名称">
          <el-input v-model="brand.name"></el-input>
        </el-form-item>
        <el-form-item label="所属类目">
          <el-cascader
            v-model="brand.category"
            :options="options"
            :props="{ value: 'id', label: 'name', children: 'children'}"
            clearable
            @change="handleCategoryChange">
          </el-cascader>
        </el-form-item>
        <el-form-item label="品牌图片">
          <el-upload
            class="upload-demo"
            action="http://localhost:8080/api/upload/image"
            :on-remove="handleRemove"
            :onSuccess="handleSuccess"
            :file-list="fileList"
            :limit="1"
            list-type="picture">
            <el-button size="small" type="primary">点击上传</el-button>
            <div slot="tip" class="el-upload__tip">只能上传jpg/png文件，且不超过10MB</div>
          </el-upload>
        </el-form-item>
        <el-form-item label="品牌首字母">
          <el-input v-model="brand.letter"></el-input>
        </el-form-item>
      </el-form>
      <span slot="footer" class="dialog-footer">
        <el-button @click="cancelBrandDetail">取 消</el-button>
        <el-button type="primary" @click="addBrand">确 定</el-button>
      </span>
    </el-dialog>
  </div>
</template>

<script>
  import {getAllCategoryTree as getCategoryTree} from '@/api/category';
  import {getAllBrand as getAllBrand} from '@/api/brand';
  import {addBrand as addBrand} from '@/api/brand';
  import {deleteBrand} from '@/api/brand';

  export default {
    name: "brand",
    data() {
      return {
        tableData: [],
        fileList: [],
        options: [],
        total: 0,
        currentPage: 1,
        pageNum: 1,
        pageSize: 10,
        formprices: [],
        brandDetailDialog: false,
        brandDetailAdd: false,
        brand: {
          id: '',
          name: '',
          image: '',
          letter: '',
          category: []
        },
        pictures: []
      };
    },
    methods: {
      handleEdit: function (index, row) {
        this.brand.id = row.id
        this.brand.name = row.name
        this.brand.image = row.image
        this.brand.category = ['1']
        this.brand.letter = row.letter
        this.brandDetailDialog = true
      },
      handleDelete: function (id) {
        deleteBrand(id).then(response => {
          this.$message({
            message: '删除成功！',
            type: 'success'
          })
          this.refreshData()
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
        getAllBrand({
          pageSize: this.pageSize,
          pageNum: this.pageNum
        }).then(response => {
          this.total = response.total
          this.tableData = response.records
        });
      },
      addBrand() {
        addBrand(
          this.brand
        ).then(response => {
          this.$message({
            message: '处理成功！',
            type: 'success'
          })
          this.brandDetailDialog = false
          this.clearBrandDetail()
          this.refreshData()
        });

      },
      handleRemove(file, fileList) {
        this.brand.image = ''
      },
      handleSuccess(res, file) {
        this.brand.image = res.data
      },
      handleCategoryChange() {
      },
      cancelBrandDetail() {
        this.brandDetailDialog = false
        this.clearBrandDetail()
      },
      clearBrandDetail() {
        this.brand.name = ''
        this.brand.image = ''
        this.brand.category = []
        this.brand.letter = ''
      },
      refreshData() {
        this.handlePageChange()
      }
    },
    mounted() {
      this.handlePageChange()
      getCategoryTree({
        parentId: 0
      }).then(response => {
        this.options = response
      })
    }
  }
</script>

<style scoped>
  .main-container {
    margin-top: 10%;
  }

  .el-header {
    background-color: #B3C0D1;
    color: #333;
    text-align: center;
    line-height: 60px;
  }

  .el-main {
    background-color: #E9EEF3;
    color: #333;
    text-align: center;
    line-height: 160px;
  }

  .el-row {
    margin-bottom: 20px;
  }

  body > .el-container {
    margin-bottom: 40px;
  }

  .el-container:nth-child(5) .el-aside,
  .el-container:nth-child(6) .el-aside {
    line-height: 300px;
  }

  .el-container:nth-child(7) .el-aside {
    line-height: 320px;
  }

  .text {
    font-size: 14px;
  }

  .item {
    padding: 18px 0;
  }

  .box-card {
    margin-top: 5px;
  }

  .box-card-main {
  }
</style>
