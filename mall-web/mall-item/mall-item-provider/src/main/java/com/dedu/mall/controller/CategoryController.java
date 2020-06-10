package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.mysql.CategoryVo;
import com.dedu.mall.service.CategoryService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

@RestController()
@RequestMapping("/api/category")
@CrossOrigin
public class CategoryController {

    @Autowired
    private CategoryService categoryService;

//**********************************分割线，以下为H5前台接口*******************************************
    /**
     * 获取所有导航类目列表
     * @return
     */
    @GetMapping("/h5/list")
    @ApiOperation(value = "查询所有H5导航类目列表-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "parentId", value = "父级类目Id", required = true)
    })
    public Result getCategoryNavTreeByParentCategoryId(@RequestParam Integer parentId) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.getCategoryNavTreeByParentCategoryId(parentId));
    }
    /**
     * 获取所有导航类目顶级列表
     * @return
     */
    @GetMapping("/h5/parent/list")
    @ApiOperation(value = "获取所有导航类目顶级列表-dedu", notes = "类目")
    @ApiImplicitParams({})
    public Result getAllParentCategoryNav() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.getAllParentCategoryNav());
    }

    /**
     * 获取轮播(营销)图片
     * @return
     */
    @GetMapping("/h5/picture/list")
    @ApiOperation(value = "查询所有导航营销图片-dedu", notes = "图片")
    @ApiImplicitParams({})
    public Result getAllNavigationPictureList() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.getAllNavPictureList());
    }







//**********************************分割线，以下为运营后台接口*******************************************

    /**
     * 获取所有类目树形结构
     * @param parentId
     * @return
     */
    @GetMapping("/tree")
    @ApiOperation(value = "根据父级类目Id查询类目树-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "parentId", value = "父级类目Id", required = true)
    })
    public Result getAllCategoryTreeByParentId(@RequestParam Integer parentId) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.getAllCategoryTreeByParentId(parentId));
    }

    /**
     * 获取所有类目列表
     * @return
     */
    @GetMapping("/list")
    @ApiOperation(value = "查询所有类目列表-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "parentId", value = "父级类目Id", required = true)
    })
    public Result getAllCategoryList() {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.getAllCategoryList());
    }

    @PutMapping("")
    @ApiOperation(value = "根据Id修改类目信息-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "CategoryVo", name = "request", value = "类目Model")
    })
    public Result modifyCategoryById(@NotNull @RequestBody CategoryVo request) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.modifyInfoById(request));
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "根据Id逻辑删除类目信息-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result removeCategoryById(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.removeCategoryById(id));
    }

    @PostMapping("/")
    @ApiOperation(value = "添加类目-dedu", notes = "类目")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "CategoryVo", name = "request", value = "类目实体", required = true)
    })
    public Result addCategory(@RequestBody CategoryVo request) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryService.addCategory(request));
    }
}
