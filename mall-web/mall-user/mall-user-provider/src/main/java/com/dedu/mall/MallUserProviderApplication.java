package com.dedu.mall;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.jdbc.DataSourceAutoConfiguration;
import org.springframework.cloud.client.discovery.EnableDiscoveryClient;
import springfox.documentation.swagger2.annotations.EnableSwagger2;

@EnableSwagger2
@EnableDiscoveryClient
@MapperScan("com.dedu.mall.dao.mapper")
@SpringBootApplication(exclude = {DataSourceAutoConfiguration.class})
public class MallUserProviderApplication {

    public static void main(String[] args) {
        SpringApplication.run(MallUserProviderApplication.class, args);
    }

}
