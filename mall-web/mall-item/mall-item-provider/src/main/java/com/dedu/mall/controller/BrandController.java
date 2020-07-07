package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.mysql.BrandVo;
import com.dedu.mall.service.BrandService;
import com.dedu.mall.service.CategoryBrandRelationService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.Max;
import javax.validation.constraints.NotNull;

/**
 * 品牌控制器
 */
@RestController()
@RequestMapping("/api/brand")
public class BrandController {

    @Autowired
    private BrandService brandService;

    @Autowired
    private CategoryBrandRelationService categoryBrandRelationService;

    @GetMapping("list")
    @ApiOperation(value = "分页查询品牌-dedu", notes = "品牌")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageNum", value = "页数"),
            @ApiImplicitParam(paramType = "query", dataType = "int", name = "pageSize", value = "每页大小")
    })
    public Result getBrandPage(@RequestParam(value = "pageNum", defaultValue = "1")Integer pageNum,
                                                         @Max(100)@RequestParam(value = "pageSize", defaultValue = "10")Integer pageSize) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), brandService.getBrandPage(pageNum, pageSize));
    }

    @PostMapping("")
    @ApiOperation(value = "新增品牌-dedu", notes = "品牌")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "BrandVo", name = "brand", value = "新增品牌")
    })
    public Result addBrand(@NotNull @RequestBody BrandVo brand) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), brandService.addBrand(brand));
    }

    @PutMapping("")
    @ApiOperation(value = "修改品牌-dedu", notes = "品牌")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "BrandVo", name = "brand", value = "修改品牌")
    })
    public Result editBrand(@NotNull @RequestBody BrandVo brand) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), brandService.modifyInfoById(brand));
    }

    @DeleteMapping("/{id}")
    @ApiOperation(value = "根据Id逻辑删除品牌信息-dedu", notes = "品牌")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result deleteCategoryById(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), brandService.deleteBrandById(id));
    }

    @GetMapping("/category/{id}")
    @ApiOperation(value = "根据类目Id获取品牌信息-dedu", notes = "品牌")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result getBrandByCategoryId(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), categoryBrandRelationService.queryBrandsByCategoryId(id));
    }
}
