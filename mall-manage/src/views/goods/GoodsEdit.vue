<template>
  <div>
    <m-breadcrumb/>
    <el-card class="box-card">
      <el-steps :active="step" finish-status="success">
        <el-step title="基本信息"/>
        <el-step title="规格属性SPU"/>
        <el-step title="销售信息SKU"/>
        <el-step title="商品描述图片"/>
      </el-steps>

      <el-form ref="form" :model="form">
        <!-- 基本信息 -->
        <el-form-item v-show="0 === step" label="商品分类："
                      :rules="{ required: true, message: '请选择活动资源', trigger: 'change' }">
          <el-select style="width: 300px;" v-model="form.categoryId" placeholder="所属类目"
                     @change="handleSelectorChange(form.categoryId)">
            <el-option v-for="(item,index) in categoryList" :label="item.name" :value="item.id"
                       :key="index"></el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-show="0 === step" label="商品名称：" :rules="{ required: true, message: '请输入商品名称', trigger: 'blur'}">
          <el-input style="width: 50%" v-model="form.name"></el-input>
        </el-form-item>
        <el-form-item v-show="0 === step" label="副标题：" :rules="{ required: true, message: '请输入商品副标题', trigger: 'blur'}">
          <el-input style="width: 50%" v-model="form.subtitle"></el-input>
        </el-form-item>
        <el-form-item v-show="0 === step" label="商品品牌：" :rules="{ required: true, message: '请选择商品品牌', trigger: 'blur'}">
          <el-select v-model="form.brand" placeholder="请选择">
            <el-option
              v-for="item in brands"
              :key="item.id"
              :label="item.name"
              :value="item.id">
            </el-option>
          </el-select>
        </el-form-item>
        <el-form-item v-show="0 === step" label="商品介绍：">
          <el-input style="width: 50%" type="textarea" v-model="form.desc"></el-input>
        </el-form-item>
        <el-form-item v-show="0 === step" label="包装清单：">
          <el-input style="width: 50%" type="textarea" v-model="form.packlist"></el-input>
        </el-form-item>
        <el-form-item v-show="0 === step" label="售后服务：">
          <el-input style="width: 50%" type="textarea" v-model="form.service"></el-input>
        </el-form-item>

        <!-- SPU信息 -->
        <el-form-item v-show="1 === step">
          <div v-for="item in specGroup">
            <el-card class="box-card">
              <div slot="header" class="clearfix">
                <h3>{{item.name}}</h3>
              </div>
              <div v-for="itdl in item.specs" style="font-size: 5px">
                <!-- 这里只展示SPU属性 -->
                <div v-if="itdl.global">
                  <el-form-item :label="itdl.name">
                    <el-input style="max-width: 100px" v-model="itdl.value"></el-input>
                  </el-form-item>
                </div>
              </div>
            </el-card>
          </div>
        </el-form-item>

        <!-- SKU信息-->
        <el-form-item v-show="2 === step" :rules="{ required: true, message: '请输入商品名称', trigger: 'blur'}">
          <el-card style="margin-left: auto">
            <div slot="header">
              <div v-for="group in specGroup">
                <div v-for="spec in group.specs" style="font-size: 5px">
                  <!-- 这里只展示SKU属性 -->
                  <div v-if="!spec.global">
                    <!-- 属性名 -->
                    <el-form-item :label="spec.name">
                      <el-input style="max-width: 100px" v-model="spec.value"/>
                      <el-button type="primary" icon="el-icon-circle-plus-outline" size="mini"
                                 @click="addSpec(spec.id, spec.name, spec.value)">增加
                      </el-button>
                      <!--<el-tag-->
                      <!--v-for="tag in specTags[spec.id]"-->
                      <!--:key="tag.name"-->
                      <!--closable-->
                      <!--type="success">-->
                      <!--{{tag.name}}-->
                      <!--</el-tag>-->
                    </el-form-item>
                  </div>
                </div>
              </div>
              <el-button type="primary" icon="el-icon-circle-plus-outline" size="mini" @click="createSpecTable">生成价格表格
              </el-button>
            </div>
            <!-- 属性值预览 -->
            <!-- SKU表格 -->
            <div>
              <el-table
                :data="form.prices"
                style="width: 100%"
                max-height="250">
                <el-table-column
                  prop="specNames"
                  label="规则参数组合名称"
                  width="180">
                </el-table-column>

                <el-table-column
                  v-show="false"
                  prop="specs"
                  label="规则参数"
                  width="180">
                </el-table-column>

                <el-table-column align="center" label="价格" width="100">
                  <template slot-scope="scope">
                    <el-input size="small" v-model="scope.row.price"></el-input>
                  </template>
                </el-table-column>

                <el-table-column align="center" label="库存" width="100">
                  <template slot-scope="scope">
                    <el-input size="small" v-model="scope.row.stock"></el-input>
                  </template>
                </el-table-column>

                <el-table-column
                  fixed="right"
                  label="操作"
                  width="120">
                  <template slot-scope="scope">
                    <el-button
                      @click.native.prevent="deleteRow(scope.$index, form.prices)"
                      type="text"
                      size="small">
                      移除
                    </el-button>
                  </template>
                </el-table-column>
              </el-table>
            </div>
            <el-button type="primary" icon="el-icon-circle-plus-outline" size="mini" @click="testTable">显示</el-button>
          </el-card>
        </el-form-item>

        <!-- 图片信息-->
        <el-form-item v-show="3 === step" label="规格图片：">
          <el-card style="height: 500px;">
            <el-upload
              action="http://localhost:8080/api/upload/image"
              list-type="picture-card"
              :on-remove="handlePictureRemove"
              :onSuccess="handlePictureSuccess"
              :file-list="form.pictures">
              <i class="el-icon-plus"></i>
            </el-upload>
          </el-card>
        </el-form-item>
        <el-form-item v-show="3 === step" label="详情大图：">
          <div>
            <editor-bar v-model="form.detailPicture" :isClear="isClear"></editor-bar>
          </div>
        </el-form-item>
      </el-form>

      <div style="display: flex; justify-content: center;">
        <div v-if="0 !== step">
          <el-button @click="pre" style="margin-top: 12px;">上步</el-button>
        </div>
        <div v-if="3 !== step">
          <el-button type="primary" style="margin-top: 12px;margin-left: 10px" @click="next">下步</el-button>
        </div>
        <div v-if="3 === step">
          <el-button type="primary" style="margin-top: 12px;margin-left: 10px" @click="submit">提交</el-button>
        </div>
      </div>
    </el-card>
  </div>
</template>

<script>
  import EditorBar from '@/components/WangEditor/index'
  import {getAllCategoryList as getCategoryList} from '@/api/category';
  import {getSpecGroupByCatId} from '@/api/specification';
  import {getBrandByCategoryId} from '@/api/brand';
  import {addGoods} from '@/api/goods';

  export default {
    name: "goodsedit",
    data() {
      return {
        specTags: {
          // 0:[{ name: '标签一', type: '' }],
          // 1:[{name: '标签er', type: '' }]
        },
        ptype: null,
        // 首页类目
        categoryList: [],
        //品牌
        brands: [],
        spuId: '',
        step: 0,
        // 提交的表单
        form: {
          categoryId: '',
          brand: '',
          packlist: '',
          service: '',
          specs: [],
          // SKU表格
          prices: [],
          pictures: [],
          detailPicture: ''
        },
        // 类目下的规则参数
        specGroup: [],
        // 规格标签

        isClear: false,
      };
    },
    components: {
      EditorBar
    },
    methods: {
      testTable() {
        console.log(this.specTags)
        // console.log(JSON.stringify(this.form))
      },
      createSpecTable() {
        var tableDataList = this.calcDescartes(this.form.specs)
        console.log(tableDataList)
        this.form.prices = []
        tableDataList.forEach((val) => {
          console.log(val)
          var specIds = val.map(a => a.specId).join(",")
          var specValues = val.map(a => a.specValue).join(",")
          this.form.prices.push({
            specNames: specValues,
            specs: specIds,
            price: 0,
            stock: 0
          })
        })
      },
      calcDescartes(arr) {
        //编辑原数组格式
        if (arr[0].checkList) {
          arr = arr.map((item) => {
            return item = item.checkList
          })
        }
        if (arr.length == 1) {
          return arr[0];
        } else {
          let arrySon = [];
          //将组合放到新数组中
          arr[0].forEach((item, index) => {
            arr[1].forEach((item1, index1) => {
              arrySon.push([].concat(arr[0][index], arr[1][index1]));
            })
          })
          // 新数组并入原数组,去除合并的前两个数组
          arr[0] = arrySon;
          arr.splice(1, 1);
          // 递归
          return this.calcDescartes(arr);
        }
      },
      addSpec(specId, specName, specValue) {
        if (null == specValue || specValue.trim().length == 0) {
          return;
        }
        var targetSpec = this.form.specs.filter(function (t) {
          return specId == t.specId
        })[0]
        if (null == targetSpec) {
          this.form.specs.push({
            specId: specId,
            specName: specName,
            checkList: [{
              specId: specId,
              specValue: specValue
            }]
          })
        } else {
          targetSpec["checkList"].push({
            specId: specId,
            specValue: specValue
          })
        }
      },
      onRemoveSpec(specId, value) {
        // this.specTags[specId].splice(this.specTags[specId].indexOf({ name: specValue, id: specId }), 1);
      },
      handleChange() {

      },
      handleSelectorChange(categoryId) {
        getBrandByCategoryId(categoryId).then(response => {
          this.brands = response
        });
        //
        getSpecGroupByCatId(categoryId).then(response => {
          this.specGroup = response
        });
      },
      pre() {
        if (this.step-- < 1) this.step = 0;
      },
      next() {
        if (this.step++ > 2) this.step = 3;
      },
      submit() {
        console.log(JSON.stringify(this.form))
        addGoods(this.form).then(response => {
          this.$message({
            message: '添加成功！',
            type: 'success'
          });
        });
      },
      deleteRow(index, rows) {
        rows.splice(index, 1);
      },
      handlePictureRemove(file, fileList) {
        this.form.pictures.splice(this.form.pictures.indexOf(file), 1);
      },
      handlePictureSuccess(res, file) {
        this.form.pictures.push({url: res.data})
      },
    },
    created() {
      this.ptype = this.$route.query.ptype
      this.spuId = this.$route.query.spuId
      // 0 为修改、1为新增
      if (1 === this.ptype) {
      }
    },
    mounted() {
      getCategoryList(null).then(response => {
        this.categoryList = response
      });
    }
  }
</script>

<style scoped>
  body > .el-container {
    margin-bottom: 40px;
  }

  .box-card {
    margin-top: 1%;
    min-height: 300px;
  }

  .box-card {
  }

  .box-card-main {
  }
</style>
