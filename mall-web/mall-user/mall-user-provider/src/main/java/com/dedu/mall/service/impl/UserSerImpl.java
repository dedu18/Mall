package com.dedu.mall.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
import com.dedu.mall.dao.UserAddressDao;
import com.dedu.mall.dao.UserDao;
import com.dedu.mall.enums.UserEnum;
import com.dedu.mall.model.ServiceException;
import com.dedu.mall.model.po.UserAddressEntity;
import com.dedu.mall.model.po.UserEntity;
import com.dedu.mall.model.vo.*;
import com.dedu.mall.service.UserService;
import com.dedu.mall.util.StringUtil;
import com.dedu.mall.util.UrlUtil;
import org.apache.commons.lang.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;
import java.util.concurrent.TimeUnit;

@Service
public class UserSerImpl implements UserService {

    @Autowired
    private UserDao userDao;

    @Autowired
    private UserAddressDao userAddressDao;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Autowired
    HttpServletRequest request;

    // 验证单元key
    public final String SecretKey = "55455acd59994e36a410f5b173a89dbb";
    // 验证单元id
    public final String Vid = "5ed75a0b206810709d86c00a";

    public final String Url = "http://0.vaptcha.com/verify";

    @Override
    public List<DeliveryAddress> queryUserAddressBySessionId(String sessionId) {
        UserEntity cacheUserInfo = getCacheUserInfo(sessionId);
        List<UserAddressEntity> addressEntityList = userAddressDao.getAddressByUserId(cacheUserInfo.getId());
        List<DeliveryAddress> result = convertAddressEntityToDeliveryAddress(addressEntityList);
        return result;
    }

    @Override
    public UserAddressVo queryUserAddressByUserIdAndAddressId(String userId, String addressId) {
        UserAddressEntity addressEntity = userAddressDao.getAddressByUserIdAndAddressId(userId, addressId);
        UserAddressVo result = new UserAddressVo();
        BeanUtils.copyProperties(addressEntity, result);
        return result;
    }

    private List<DeliveryAddress> convertAddressEntityToDeliveryAddress(List<UserAddressEntity> addressEntityList) {
        List<DeliveryAddress> result = new ArrayList<>();
        for (UserAddressEntity entity : addressEntityList) {
            result.add(DeliveryAddress.builder()
                    .addressId(entity.getId())
                    .recipientName(entity.getRecipientName())
                    .province(entity.getProvince())
                    .city(entity.getCity())
                    .area(entity.getArea())
                    .address(entity.getAddress())
                    .phone(hidePhone(entity.getPhone()))
                    .postalcode(entity.getPostalCode())
                    .build());
        }
        return result;
    }

    private String hidePhone(String phone) {
        return phone.substring(0, 3) + "****" + phone.substring(7, phone.length());
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
            String sessionId = request.getSession().getId();
            cacheUserInfo(sessionId, userEntityExited);
            result.setLegal(true);
            result.setSessionId(sessionId);
            result.setNackname(userEntityExited.getNackname());
        }
        return result;
    }

    private void cacheUserInfo(String sessionId, UserEntity userEntityExited) {
        stringRedisTemplate.opsForValue().set(sessionId, JSON.toJSONString(userEntityExited), Duration.ofMinutes(30));
    }

    private UserEntity getCacheUserInfo(String sessionId) {
        String userInfoString = stringRedisTemplate.opsForValue().get(sessionId);
        if (StringUtils.isBlank(userInfoString)) {
            throw new ServiceException(UserEnum.USER_LOGIN_EXPIRED_ERROR.getCode(), UserEnum.USER_LOGIN_EXPIRED_ERROR.getMsg());
        }
        return JSONObject.parseObject(userInfoString, UserEntity.class);
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
        String checkNumCached = stringRedisTemplate.opsForValue().get(registerUserVo.getPhone());
        if (!Objects.equals(checkNumCached, registerUserVo.getCheckNum())) {
            throw new ServiceException(UserEnum.USER_CHECKNUM_ERROR.getCode(), UserEnum.USER_CHECKNUM_ERROR.getMsg());
        }
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
    public Boolean sendVerificationCode(String phone, String token) {
        Map<String, String> data = buildVaptchaData(token);
        String postResult = "";
        try {
            postResult = UrlUtil.post(Url, data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> map = JSONObject.parseObject(postResult, Map.class);
        Integer success = (Integer) map.get("success");
        Integer score = (Integer) map.get("score");
        boolean result = success == 1 && score >= 50;
        if (result) {
            stringRedisTemplate.opsForValue().set(phone, "1234", 5, TimeUnit.MINUTES);
        }
        return result;
    }

    private Map<String, String> buildVaptchaData(String token) {
        HashMap<String, String> result = new HashMap<>();
        result.put("id", Vid);
        result.put("secretkey", SecretKey);
        result.put("scene", "0");
        result.put("token", token);
        result.put("ip", "127.0.0.1");
        return result;
    }

    @Override
    public String addUserAddressBySessionId(DeliveryAddress userAddress) {
        UserEntity cacheUserInfo = getCacheUserInfo(userAddress.getSessionId());
        UserAddressEntity userAddressEntity = buildUserEntity(userAddress, cacheUserInfo);
        if (StringUtils.isBlank(userAddressEntity.getId())) {
            userAddressDao.save(userAddressEntity);
        } else {
            userAddressDao.updateById(userAddressEntity);
        }
        return userAddressEntity.getId();
    }

    private UserAddressEntity buildUserEntity(DeliveryAddress userAddress, UserEntity cacheUserInfo) {
        return UserAddressEntity.builder()
                .id(userAddress.getAddressId())
                .userId(cacheUserInfo.getId())
                .recipientName(userAddress.getRecipientName())
                .province(userAddress.getProvince())
                .city(userAddress.getCity())
                .area(userAddress.getArea())
                .address(userAddress.getAddress())
                .phone(userAddress.getPhone())
                .postalCode(userAddress.getPostalcode())
                .isEnable(1)
                .isDelete(0)
                .build();
    }
}
