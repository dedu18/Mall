<template>
  <div>
    <m-breadcrumb/>
    <el-container style=" margin-top: 1%; height: 100%; border: 1px">
      <el-aside style="background-color: rgb(240,240,240)">
        <el-tree style="background-color: rgb(240,240,240)"
                 class="tree"
                 v-loading="loading"
                 :props="props"
                 :load="loadNode"
                 lazy
                 @check-change="handleCheckChange"
                 @node-click="handleNodeClick">
        </el-tree>
      </el-aside>
      <el-container style="text-align: left;">
        <el-header style="font-size: 12px">
          <el-button type="primary" icon="el-icon-circle-plus-outline" @click="onAddTopCate">添加顶级类目</el-button>
        </el-header>
        <el-main>
          <el-form :model="category" :rules="rules" ref="category" label-width="100px" class="demo-ruleForm">
            <el-form-item label="类目名称" prop="name">
              <el-input v-model="category.name"></el-input>
            </el-form-item>
            <el-form-item label="是否父节点" prop="delivery">
              <el-switch v-model="category.isParent"></el-switch>
            </el-form-item>
            <el-form-item label="父级类目" prop="region">
              <el-select v-model="category.parentId" placeholder="父级类目" :loading="loading"
                         :change="handleSelectorChange">
                <el-option v-for="item in categoryList" :key="item.id" :label="item.name" :value="item.id"></el-option>
              </el-select>
            </el-form-item>
            <el-form-item label="排序" prop="name">
              <el-input v-model="category.sort"></el-input>
            </el-form-item>
            <el-form-item label="是否启用" prop="delivery">
              <el-switch v-model="category.isEnable"></el-switch>
            </el-form-item>
            <el-form-item>
              <el-button type="primary" icon="el-icon-edit" @click="onModify">修改本级</el-button>
              <el-button type="danger" icon="el-icon-delete" @click="onDelete">删除本级</el-button>
              <el-button type="success" icon="el-icon-circle-plus" @click="onAddSubCat">添加子级</el-button>
            </el-form-item>
          </el-form>
        </el-main>
      </el-container>
      <!-- 添加顶级类目窗口 -->
      <el-dialog
        :title="cateDetailTitle"
        :visible.sync="cateDetailDialog"
        width="30%">
        <el-form :model="cateDetail" :rules="rules" label-width="100px" class="demo-ruleForm">
          <el-form-item label="类目名称" prop="name">
            <el-input v-model="cateDetail.name"></el-input>
          </el-form-item>
          <el-form-item label="是否父节点" prop="delivery">
            <el-switch v-model="cateDetail.isParent"></el-switch>
          </el-form-item>
          <el-form-item label="排序" prop="name">
            <el-input v-model="cateDetail.sort"></el-input>
          </el-form-item>
          <el-form-item label="是否启用" prop="delivery">
            <el-switch v-model="cateDetail.isEnable"></el-switch>
          </el-form-item>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="cancelDetail">取 消</el-button>
          <el-button type="primary" @click="add">确 定</el-button>
        </span>
      </el-dialog>

    </el-container>
  </div>
</template>

<script>
  import {getAllCategoryTree as getCategoryTree} from '@/api/category';
  import {getAllCategoryList as getCategoryList} from '@/api/category';
  import {modifyCategoryById as modifyCategory} from '@/api/category';
  import {deleteCategoryById as deleteCategory} from '@/api/category';
  import {addCategory} from '@/api/category';

  export default {
    name: "category",
    data() {
      return {
        cateDetailDialog: false,
        cateDetailTitle: '',
        cateDetail: {
          id: '',
          name: '',
          isParent: true,
          parentId: '',
          sort: 0,
          isEnable: true
        },
        props: {
          label: 'name',
          children: 'children',
          isLeaf: 'leaf'
        },
        count: 1,
        loading: true,
        category: {
          id: '',
          name: '',
          isParent: true,
          parentId: 0,
          sort: 0,
          isEnable: true
        },
        categoryList: [],
        rules: {
          name: [
            {required: true, message: '请输入类目名称', trigger: 'blur'},
          ]
        }
      };
    },
    methods: {
      cancelDetail() {
        this.cateDetailDialog = false
        this.cateDetail = {
          id: '',
          name: '',
          isParent: true,
          parentId: 0,
          sort: 0,
          isEnable: true
        }
      },
      handleCheckChange(data, checked, indeterminate) {
      },
      handleNodeClick(data) {
        this.category.id = data.id
        this.category.name = data.name
        this.category.isParent = data.isParent
        this.category.parentId = data.parentId
        this.category.sort = data.sort
        this.category.isEnable = data.isEnable
      },
      loadNode(node, resolve) {
        // // 每次点击都是一个node
        if (node.level === 0) {
          getCategoryTree({
            parentId: 0
          }).then(response => {
            return resolve(response)
          });
        } else {
          getCategoryTree({
            parentId: node.data.id
          }).then(response => {
            if (Array.isArray(response)) {
              for (var j = 0; j < response.length; j++) {
                if (!response[j]["isParent"]) {
                  response[j]["leaf"] = true
                }
              }
            }
            return resolve(response)
          });
        }
      },
      handleSelectorChange(event) {
        // this.category.parentId = id;
      },
      onAddTopCate() {
        this.cateDetailDialog = true
        this.cateDetailTitle = '添加顶级类目'
      },
      add() {
        addCategory(
          this.cateDetail
        ).then(response => {
          this.$message({
            message: '添加成功！',
            type: 'success'
          });
        })
        this.cateDetailDialog = false
      },
      onModify() {
        if ('' === this.category.id) {
          this.$message({
            message: '请选中一个类目！',
            type: 'warning'
          });
        } else {
          modifyCategory(
            this.category
          ).then(response => {
            this.$message({
              message: '修改成功！',
              type: 'success'
            });
          });
        }
      },
      onDelete() {
        if ('' === this.category.id) {
          this.$message({
            message: '请选中一个类目！',
            type: 'warning'
          });
        } else {
          deleteCategory(
            this.category.id
          ).then(response => {
            this.$message({
              message: '删除成功！',
              type: 'success'
            });
          });
        }
      },
      onAddSubCat() {
        if ('' != this.category.id) {
          this.cateDetail.parentId = this.category.id
          this.cateDetailDialog = true
          this.cateDetailTitle = '添加【' + this.category.name + '】子集类目'
        } else {
          this.$message({
            message: '请选中一个类目！',
            type: 'warning'
          });
        }
      }
    },
    beforeMount() {
      getCategoryList(null).then(response => {
        this.categoryList = response
        this.loading = false
      });
    }
  }
</script>

<style scoped>
  .tree {
    padding: 5px;
  }
</style>
