<template>
  <el-tree style="background-color: rgb(240,240,240)"
           class="tree"
           :props="props"
           :load="loadNode"
           lazy
           @check-change="handleCheckChange"
           @node-click="handleNodeClick">
  </el-tree>
</template>

<script>
    import {getAllCategoryTree as getCategoryTree} from '@/api/category';
    import {getAllCategoryList as getCategoryList} from '@/api/category';
    import {modifyCategoryById as modifyCategory} from '@/api/category';
    import {deleteCategoryById as deleteCategory} from '@/api/category';
    export default {
      name: "CategoryTree",
      data() {
        return {
          props: {
            label: 'name',
            children: 'children',
            isLeaf: 'leaf'
          },
          count: 1,
          loading: true,
          category: {
            id: '',
            name:'',
            isParent: true,
            parentId: 0,
            sort: 0,
            isEnable: true
          },
          categoryList:[
          ],
          rules: {
            name: [
              { required: true, message: '请输入类目名称', trigger: 'blur' },
            ]
          }
        };
      },
      methods: {
        handleCheckChange(data, checked, indeterminate) {
          console.log(111);
          this.$emit('handleCheckChange', data, checked, indeterminate);
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
            }).then(response=>{
              return resolve(response)
            });
          } else {
            getCategoryTree({
              parentId:node.data.id
            }).then(response=>{
              if (Array.isArray(response)) {
                for(var j = 0; j < response.length; j++) {
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
          console.log(11)
          console.log(event)
        },
        onModify() {
          modifyCategory(
            this.category
          ).then(response=>{
            this.$message({
              message: '修改成功！',
              type: 'success'
            });
          });
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
            ).then(response=>{
              this.$message({
                message: '删除成功！',
                type: 'success'
              });
            });
          }
        },
        onAddSubCat() {
          console.log('submit!');
        }
      },
      mounted () {
        getCategoryList(null).then(response=>{
          this.categoryList = response
          this.loading = false
        });
      }
    }
</script>

<style scoped>

</style>
