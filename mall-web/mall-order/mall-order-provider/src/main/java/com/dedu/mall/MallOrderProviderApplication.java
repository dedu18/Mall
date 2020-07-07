package com.dedu.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import org.springframework.cloud.openfeign.EnableFeignClients;
import org.springframework.session.data.redis.config.annotation.web.http.EnableRedisHttpSession;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@MapperScan("com.dedu.mall.dao")
@EnableFeignClients(basePackages = {"com.dedu.mall.*"})
@SpringBootApplication
@EnableSwagger2
@EnableDiscoveryClient
@EnableRedisHttpSession
public class MallOrderProviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallOrderProviderApplication.class, args);
    }

}
