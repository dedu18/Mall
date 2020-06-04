package com.dedu.mall.service.impl;

import com.alibaba.fastjson.JSON;
import com.alibaba.fastjson.JSONObject;
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
import org.apache.http.NameValuePair;
import org.apache.http.client.entity.UrlEncodedFormEntity;
import org.apache.http.client.methods.CloseableHttpResponse;
import org.apache.http.client.methods.HttpPost;
import org.apache.http.impl.client.CloseableHttpClient;
import org.apache.http.impl.client.HttpClients;
import org.apache.http.message.BasicNameValuePair;
import org.apache.http.util.EntityUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.stereotype.Service;

import java.time.Duration;
import java.time.LocalDateTime;
import java.util.*;

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
        if (registerUserVo.getCheckNum() != "1234") {
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

    // 验证单元key
    public  final String SecretKey = "55455acd59994e36a410f5b173a89dbb";
    // 验证单元id
    public  final String Vid = "5ed75a0b206810709d86c00a";

    public  final String Url = "http://0.vaptcha.com/verify";

    @Override
    public Boolean sendVerificationCode(String phone, String token) {
        Map<String, String> data = buildVaptchaData(token);
        String result = "";
        try {
            result = post(Url, data);
        } catch (Exception e) {
            e.printStackTrace();
        }
        Map<String, Object> map = JSONObject.parseObject(result, Map.class);
        Integer success = (Integer) map.get("success");
        Integer score = (Integer) map.get("score");
        return success == 1 && score >= 50;
    }

    private Map<String,String> buildVaptchaData(String token) {
        HashMap<String, String> result = new HashMap<>();
        result.put("id", Vid);
        result.put("secretkey", SecretKey);
        result.put("scene", "0");
        result.put("token", token);
        result.put("ip", "127.0.0.1");
        return result;
    }

    public String post(String url, Map<String, String> data) throws Exception {
        // 创建Httpclient对象
        CloseableHttpClient httpclient = HttpClients.createDefault();
        // 创建http POST请求，访问开源中国
        HttpPost httpPost = new HttpPost(url);

        // 根据开源中国的请求需要，设置post请求参数
        List<NameValuePair> parameters = new ArrayList<NameValuePair>(0);
        data.entrySet().forEach(s -> {
            parameters.add(new BasicNameValuePair(s.getKey(), s.getValue()));
        });
        // 构造一个form表单式的实体
        UrlEncodedFormEntity formEntity = new UrlEncodedFormEntity(parameters);
        // 将请求实体设置到httpPost对象中
        httpPost.setEntity(formEntity);

        CloseableHttpResponse response = null;
        String content = "";
        try {
            // 执行请求
            response = httpclient.execute(httpPost);
            // 判断返回状态是否为200
            if (response.getStatusLine().getStatusCode() == 200) {
                // 解析响应体
                content = EntityUtils.toString(response.getEntity(), "UTF-8");
            }
        } finally {
            if (response != null) {
                response.close();
            }
            // 关闭浏览器
            httpclient.close();
        }
        return content;
    }
}
