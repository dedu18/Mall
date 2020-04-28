package com.dedu.mall.controller;

import com.dedu.mall.model.LoginUserVo;
import com.dedu.mall.model.Result;
import com.dedu.mall.model.ResultCode;
import com.dedu.mall.service.UserService;
import io.swagger.annotations.ApiImplicitParam;
import io.swagger.annotations.ApiImplicitParams;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import javax.validation.Valid;
import javax.validation.constraints.NotBlank;

@CrossOrigin
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    //**********************************分割线，以下为H5前台接口********************************************
    @GetMapping("/")
    @ApiOperation(value = "根据类目Id查询商品列表导航头信息-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "username", value = "账号", required = true),
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "password", value = "密码", required = true)
    })
    public Result queryUserAddressByUsernamAndPassword(@RequestParam @NotBlank String username, @RequestParam @NotBlank String password) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.queryUserAddressByUsernamAndPassword(username, password));
    }

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @PostMapping("/")
    @ApiOperation(value = "根据账号密码进行用户登录-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "LoginUserVo", name = "loginUser", value = "账号", required = true),
    })
    public Result loginUserByUsernameAndPassword(@RequestBody @Valid LoginUserVo loginUser) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.loginUserByUsernameAndPassword(loginUser));
    }

    /**
     * 用户登录
     * @param username
     * @param password
     * @return
     * @throws Exception
     */
    @GetMapping("/manage")
    @ApiOperation(value = "根据账号密码进行用户登录-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "username", value = "账号", required = true),
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "password", value = "账号", required = true),
    })
    public Result loginUserByUsernameAndPassword(@RequestParam @NotBlank String username, @RequestParam @NotBlank String password) throws Exception {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.loginUserByUsernameAndPassword(username, password));
    }
}
