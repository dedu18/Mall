package com.dedu.mall.service.impl;

import com.dedu.mall.model.ServiceException;
import com.dedu.mall.model.vo.CityVo;
import com.dedu.mall.service.CityService;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.redis.core.StringRedisTemplate;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.text.MessageFormat;

@Service
@Slf4j
public class CitySerImpl implements CityService {

    @Autowired
    private HttpServletRequest request;

    @Autowired
    private RestTemplate restTemplate;

    @Autowired
    private StringRedisTemplate stringRedisTemplate;

    @Override
    public Object queryCityInfoByIP() {
        //获取远程IP地址
        String ipAddress = getIPAddress();
        //调用API查询IP对应信息
        String city = getCityInfo(ipAddress);
        //这里可对城市调用信息进行统计等埋点处理
        //用户访问统计
        increVisitedUser(ipAddress);
        return city;
    }

    private void increVisitedUser(String ipAddress) {
        stringRedisTemplate.opsForValue().increment("VISITED_USER");
    }

    private String getCityInfo(String ipAddress) {
        if (isSpecialIPAddress(ipAddress)) {
            return "北京";
        }
        String url = MessageFormat.format("http://ip-api.com/json/{0}?lang=zh-CN", ipAddress);
        ResponseEntity<String> response = restTemplate.getForEntity(url, String.class);
        if (response.getStatusCodeValue() != 200) {
            throw new ServiceException("数据请求失败");
        }
        CityVo cityVo = null;
        try {
            ObjectMapper mapper = new ObjectMapper();
            cityVo = mapper.readValue(response.getBody(), CityVo.class);
        } catch (IOException e) {
            e.printStackTrace();
            throw new ServiceException("json数据转换失败");
        }
        if (cityVo == null || cityVo.getStatus().equals("fail")) {
            return "北京";
        }
        // 返回 return data;
        return cityVo.getCity();
    }

    private boolean isSpecialIPAddress(String ipAddress) {
        return ipAddress.equals("127.0.0.1");
    }

    private String getIPAddress() {
        String ip = null;

        //X-Forwarded-For：Squid 服务代理
        String ipAddresses = request.getHeader("X-Forwarded-For");

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            //Proxy-Client-IP：apache 服务代理
            ipAddresses = request.getHeader("Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            //WL-Proxy-Client-IP：weblogic 服务代理
            ipAddresses = request.getHeader("WL-Proxy-Client-IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            //HTTP_CLIENT_IP：有些代理服务器
            ipAddresses = request.getHeader("HTTP_CLIENT_IP");
        }

        if (ipAddresses == null || ipAddresses.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            //X-Real-IP：nginx服务代理
            ipAddresses = request.getHeader("X-Real-IP");
        }

        //有些网络通过多层代理，那么获取到的ip就会有多个，一般都是通过逗号（,）分割开来，并且第一个ip为客户端的真实IP
        if (ipAddresses != null && ipAddresses.length() != 0) {
            ip = ipAddresses.split(",")[0];
        }

        //还是不能获取到，最后再通过request.getRemoteAddr();获取
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ipAddresses)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }
}
