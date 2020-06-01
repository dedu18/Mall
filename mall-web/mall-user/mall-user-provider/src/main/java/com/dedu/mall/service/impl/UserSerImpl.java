package com.dedu.mall.service.impl;

import com.alibaba.fastjson.JSON;
import com.dedu.mall.dao.UserDao;
import com.dedu.mall.enums.UserEnum;
import com.dedu.mall.model.ServiceException;
import com.dedu.mall.model.po.UserEntity;
import com.dedu.mall.model.vo.DeliveryAddress;
import com.dedu.mall.model.vo.LoginUserResultVo;
import com.dedu.mall.model.vo.LoginUserVo;
import com.dedu.mall.model.vo.RegisterUserVo;
import com.dedu.mall.service.UserService;
import com.dedu.mall.util.StringUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;
import java.util.Objects;

@Service
public class UserSerImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public List<DeliveryAddress> queryUserAddressByUsernamAndPassword(String username, String password) {
        List<DeliveryAddress> result = new ArrayList<>();
        result.add(DeliveryAddress.builder()
                .addressId("123456")
                .name("麦特斯破")
                .province("四川省")
                .city("成都市")
                .area("武侯区")
                .address("净化共鸣")
                .phone("112****1234")
                .postalcode("123456")
                .build());
        return result;
    }

    @Override
    public LoginUserResultVo userLoginByUsernameAndPassword(LoginUserVo loginUser) {
        UserEntity userEntityExited = userDao.getUserByUsername(loginUser.getUsername());
        boolean isLegal = checkUserPassword(loginUser, userEntityExited);
        LoginUserResultVo result = getSessionOfCheckResult(isLegal, userEntityExited);
        return result;
    }

    private LoginUserResultVo getSessionOfCheckResult(boolean isLegal, UserEntity userEntityExited) {
        LoginUserResultVo result = LoginUserResultVo.builder().build();
        if (isLegal) {
            cacheUserInfo(userEntityExited);
            result.setLegal(true);
            result.setSessionId(userEntityExited.getId());
            result.setNackname(userEntityExited.getNackname());
        }
        return result;
    }

    private void cacheUserInfo(UserEntity userEntityExited) {
        stringRedisTemplate.opsForValue().set(userEntityExited.getId(), JSON.toJSONString(userEntityExited), Duration.ofMinutes(30));
    }

    private boolean checkUserPassword(LoginUserVo loginUser, UserEntity userEntityExited) {
        return null != userEntityExited && loginUser.getPassword().equals(userEntityExited.getPassword());
    }

    @Override
    public Boolean userLoginByUsernameAndPassword(String username, String password) {
        if (Objects.equals("dedu", username) && Objects.equals("dedu", password)) {
            return Boolean.TRUE;
        } else {
            return Boolean.FALSE;
        }
    }

    @Override
    public Boolean registerUser(RegisterUserVo registerUserVo) {
        UserEntity userEntityExited = userDao.getUserByUsername(registerUserVo.getUsername());
        if (null != userEntityExited) {
            throw new ServiceException(UserEnum.USER_EXITED.getCode(), UserEnum.USER_EXITED.getMsg());
        }
        UserEntity userEntityToBeSaved = buildUserEntity(registerUserVo);
        boolean isUserSaved = userDao.save(userEntityToBeSaved);
        return isUserSaved;
    }

    private UserEntity buildUserEntity(RegisterUserVo registerUserVo) {
        return UserEntity.builder()
                .email(registerUserVo.getMail())
                .username(registerUserVo.getUsername())
                .password(registerUserVo.getPassword())
                .nackname(StringUtil.getRandomString(20))
                .phone(registerUserVo.getPhone())
                .createTime(LocalDateTime.now())
                .updateTime(LocalDateTime.now())
                .build();
    }

    @Override
    public Boolean sendVerificationCode(String phone) {
        System.out.println("已发送验证码1234");
        return Boolean.TRUE;
    }
}
