package com.dedu.mall.controller;

import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.model.mysql.SpecificationGroupVo;
import com.dedu.mall.service.SpecificationGroupService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.constraints.NotNull;

/**
 * 规格设置控制器
 */
@RestController()
@RequestMapping("/api/spec")
public class SpecificationController {

    @Autowired
    private SpecificationGroupService specGroupService;

    @GetMapping("/group/category/{id}")
    @ApiOperation(value = "根据类目Id查询规则分组信息-dedu", notes = "规格")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "类目主键id", required = true)
    })
    public Result querySpecGroupByCategoryId(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specGroupService.queryByCategoryId(id));
    }

    @PostMapping("/group/category/")
    @ApiOperation(value = "新增规则分组信息-dedu", notes = "规格")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "SpecificationGroupVo", name = "specGroupVo", value = "规则分组", required = true)
    })
    public Result addSpecGroup(@NotNull @RequestBody SpecificationGroupVo specGroupVo) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specGroupService.addSepcificationGroup(specGroupVo));
    }

    @PutMapping("/group/category/")
    @ApiOperation(value = "修改规则分组信息-dedu", notes = "规格")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "SpecificationGroupVo", name = "specGroupVo", value = "规则分组", required = true)
    })
    public Result modifySpecGroup(@NotNull @RequestBody SpecificationGroupVo specGroupVo) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specGroupService.modifySepcificationGroup(specGroupVo));
    }

    @DeleteMapping("/group/{id}")
    @ApiOperation(value = "根据Id逻辑删除规则组及规格信息-dedu", notes = "规格")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "path", dataType = "long", name = "id", value = "规则组主键id", required = true)
    })
    public Result removeSpecGroupById(@PathVariable Long id) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), specGroupService.removeSpecGroupById(id));
    }
}
