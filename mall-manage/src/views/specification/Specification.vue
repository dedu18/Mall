<template>
  <div>
    <m-breadcrumb/>
    <div>
      <div class="left">
        <el-card class="left-box-card">
          <!--<el-tree style="background-color: rgb(240,240,240)"-->
          <!--class="tree"-->
          <!--:props="props"-->
          <!--:load="loadNode"-->
          <!--lazy-->
          <!--@check-change="handleCheckChange"-->
          <!--@node-click="handleNodeClick">-->
          <!--</el-tree>-->
          <m-categorytree v-on:handleCheckChange="handleCheckChange" v-on:node-click="handleNodeClick"/>
        </el-card>
      </div>

      <div class="right">
        <el-card class="right-box-card">
          <!--<div v-if="this.selectedcategory.id != '' || !this.selectedcategory.isParent">-->
          <div v-if="this.selectedcategory.id != ''">
            <h3>规格设置-{{this.selectedcategory.name}}</h3>
            <el-button type="primary" icon="el-icon-circle-plus-outline" @click="onAddSpecGroup">添加规则参数</el-button>
            <div v-for="item in items" :key="item.id">
              <el-card class="box-card">
                <div slot="header" class="clearfix">
                  <span>{{item.name}}</span>
                  <el-button style="float: right; padding: 3px 0;color: red" type="text"
                             @click="onRemoveSpecGroup(item.id)">删除操作
                  </el-button>
                  <el-button style="float: right; padding: 3px 0" type="text" @click="onEditSpecGroup(item)">编辑操作
                  </el-button>
                </div>
                <div v-for="itdl in item.specs" :key="itdl" style="font-size: 5px">
                  <!--<el-row><el-col :span="12">{{ itdl.name  }}</el-col><el-col :span="12">{{itdl.value}}</el-col></el-row>-->
                  <el-collapse accordion>
                    <el-collapse-item>
                      <template slot="title">
                        {{ itdl.name }}<i class="header-icon el-icon-info"></i>
                      </template>
                      <div>
                        <div v-if="'' != itdl.value">
                          <el-tag type="success">{{itdl.value}}</el-tag>
                        </div>
                      </div>
                    </el-collapse-item>
                  </el-collapse>
                </div>
              </el-card>
            </div>
          </div>
          <h3 v-else>请选择一个具体分类</h3>

        </el-card>
      </div>
      <!-- 规则参数窗口 -->
      <el-dialog
        :title="specDetailTitle"
        :visible.sync="specDetailDialog"
        width="30%">
        <el-form :model="specDetail" label-width="100px" class="demo-ruleForm">
          <el-form-item label="分组名称" prop="name">
            <el-input v-model="specDetail.name"></el-input>
          </el-form-item>
          <el-divider/>
          <el-form-item label="参数名" prop="name">
            <el-input v-model="spec.name"></el-input>
          </el-form-item>
          <el-form-item label="参数单位" prop="name">
            <el-input v-model="spec.unit"></el-input>
          </el-form-item>
          <el-form-item prop="name">
            <el-tooltip effect="dark" content="销售属性即SKU属性" placement="right">
              <el-switch
                style="display: block; width: 200px"
                v-model="spec.global"
                active-color="#ff4949"
                inactive-color="#13ce66"
                active-text="非销售属性"
                inactive-text="是销售属性">
              </el-switch>
            </el-tooltip>
          </el-form-item>
          <el-button type="primary" @click="onAddSpec" size="mini">添加</el-button>
          <el-divider/>
          添加预览：
          <el-tag
            v-for="tag in specDetail.specs"
            :key="tag.name"
            closable
            type="success"
            @close="onRemoveSpec(tag)">
            {{tag.name}}-{{tag.global ? "非销售属性":"销售属性"}}
          </el-tag>
        </el-form>
        <span slot="footer" class="dialog-footer">
          <el-button @click="cancelDetail">取 消</el-button>
          <el-button type="primary" @click="onAddOrUpdateSpecGroupSubmit">确 定</el-button>
        </span>
      </el-dialog>
    </div>
  </div>
</template>

<script>
  import CategoryTree from '../../components/CategoryTree'
  import {getAllCategoryTree as getCategoryTree} from '@/api/category';
  import {
    getSpecGroupByCatId as getSpecGroup,
    addSpecGroup,
    modifySpecGroup,
    deleteSpecGroupById as deleteSpecGroup
  } from '@/api/specification.js';

  export default {
    name: "Specification",
    data() {
      return {
        specDetailDialog: false,
        specDetailTitle: '',
        sepcGroupOptType: '0',
        specDetail: {
          id: '',
          name: '',
          categoryId: '',
          specs: []
        },
        spec: {
          name: '',
          unit: '',
          global: true
        },
        specGroup: [],
        props: {
          label: 'name',
          children: 'children',
          isLeaf: 'leaf'
        },
        loading: true,
        categoryList: [],
        selectedcategory: {
          id: '',
          name: '',
          isParent: false
        },
      };
    },
    methods: {
      onAddSpec() {
        this.specDetail.specs.push({
          name: this.spec.name,
          unit: this.spec.unit,
          global: this.spec.global
        })
      },
      onRemoveSpec(tag) {
        this.specDetail.specs.splice(this.specDetail.specs.indexOf(tag), 1);
      },
      onAddSpecGroup() {
        this.sepcGroupOptType = '1'
        this.specDetailDialog = true
        this.specDetailTitle = '添加规格参数'
        this.specDetail.categoryId = this.selectedcategory.id
      },
      onRemoveSpecGroup(groupId) {
        deleteSpecGroup(
          groupId
        ).then(response => {
          this.$message({
            message: '删除成功！',
            type: 'success'
          });
        })
      },
      onEditSpecGroup(item) {
        this.sepcGroupOptType = '2'
        this.specDetailDialog = true
        this.specDetailTitle = '修改规格参数'
        this.specDetail.name = item.name
        this.specDetail.id = item.id
        this.specDetail.specs = item.specs
        // this.specDetail.categoryId = item.categoryId
      },
      cancelDetail() {
        this.specDetailDialog = false
        this.specDetailTitle = ''
        this.specDetail.categoryId = ''
      },
      onAddOrUpdateSpecGroupSubmit() {
        if (this.sepcGroupOptType == '1') {
          // 新增
          addSpecGroup(
            this.specDetail
          ).then(response => {
            this.$message({
              message: '处理成功！',
              type: 'success'
            });
            this.cancelDetail()
          })
        } else if (this.sepcGroupOptType == '2') {
          // 修改
          modifySpecGroup(
            this.specDetail
          ).then(response => {
            this.$message({
              message: '处理成功！',
              type: 'success'
            });
            this.cancelDetail()
          })
        }
      },
      handleCheckChange(data, checked, indeterminate) {
        console.log(222)
      },
      handleNodeClick(data) {
        this.selectedcategory.name = data.name
        this.selectedcategory.id = data.id
        this.selectedcategory.isParent = data.isParent
        // if (!this.selectedcategory.isParent) {
        getSpecGroup(
          this.selectedcategory.id
        ).then(response => {
          this.items = response
        })
        // }
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
      }
    },
    components: {
      "m-categorytree": CategoryTree
    },
  }
</script>

<style scoped>
  .left {
    margin-top: 1%;
    width: 20%;
    float: left;
    font-size: 40px;
    color: #fff;
  }

  .right {
    margin-top: 1%;
    margin-bottom: 1%;
    width: 80%;
    font-size: 40px;
    float: left;
    color: #fff;
  }

  .left-box-card {
    width: 90%;
  }

  .right-box-card {
    width: 100%;
  }

</style>
