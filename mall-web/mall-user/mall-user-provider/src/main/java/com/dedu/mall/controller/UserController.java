package com.dedu.mall.controller;

import com.dedu.mall.model.vo.DeliveryAddress;
import com.dedu.mall.model.vo.LoginUserVo;
import com.dedu.mall.model.vo.RegisterUserVo;
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
import javax.validation.constraints.NotEmpty;

@CrossOrigin
@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    private UserService userService;

    /**
     * 用户注册
     * @param registerUserVo
     * @return
     * @throws Exception
     */
    @PostMapping("/")
    @ApiOperation(value = "用户注册-dedu", notes = "用户注册")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "LoginUserVo", name = "loginUser", value = "账号", required = true),
    })
    public Result registerUser(@RequestBody @Valid RegisterUserVo registerUserVo) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.registerUser(registerUserVo));
    }

    /**
     * 用户登录
     * @param loginUser
     * @return
     * @throws Exception
     */
    @PostMapping("/session")
    @ApiOperation(value = "根据账号密码进行用户登录-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "LoginUserVo", name = "loginUser", value = "账号", required = true),
    })
    public Result userLoginByUsernameAndPassword(@RequestBody @Valid LoginUserVo loginUser) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.userLoginByUsernameAndPassword(loginUser));
    }

    /**
     * 获取验证码
     * @param phone
     * @return
     */
    @GetMapping("/code")
    @ApiOperation(value = "根据手机号获取验证码-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "phone", value = "手机号", required = true),
    })
    public Result sendVerificationCode(@RequestParam @NotEmpty String phone, @RequestParam @NotEmpty String token) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.sendVerificationCode(phone, token));
    }

    /**
     * 获取用户地址信息
     * @param sessionId
     * @return
     */
    @GetMapping("/addresses")
    @ApiOperation(value = "根据会话Id查询用户地址信息-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "query", dataType = "string", name = "sessionId", value = "用户会话id", required = true)
    })
    public Result queryUserAddressBySessionId(@RequestParam String sessionId) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.queryUserAddressBySessionId(sessionId));
    }

    /**
     * 用户添加或修改收货地址
     * @param userAddress
     * @return
     * @throws Exception
     */
    @PostMapping("/addresses")
    @ApiOperation(value = "用户添加或修改收货地址-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "LoginUserVo", name = "loginUser", value = "账号", required = true),
    })
    public Result addUserAddressBySessionId(@RequestBody @Valid DeliveryAddress userAddress) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.addUserAddressBySessionId(userAddress));
    }

    /**
     * 后台用户登录
     * @param loginUser
     * @return
     * @throws Exception
     */
    @PostMapping("/manage/session")
    @ApiOperation(value = "根据账号密码进行用户登录-dedu", notes = "用户")
    @ApiImplicitParams({
            @ApiImplicitParam(paramType = "body", dataType = "LoginUserVo", name = "loginUser", value = "账号", required = true),
    })
    public Result loginUserByUsernameAndPassword(@RequestBody @Valid LoginUserVo loginUser) {
        return Result.build(ResultCode.SUCCESS.getCode(), ResultCode.SUCCESS.getDesc(), userService.userLoginByUsernameAndPassword(loginUser.getUsername(), loginUser.getPassword()));
    }
}
