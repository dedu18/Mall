package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class UserAddressVo {
    private String id;
    private String userId;
    private String recipientName;
    private String province;
    private String city;
    private String area;
    private String address;
    private String phone;
    private String postalCode;
    private LocalDateTime createTime;
    private LocalDateTime updateTime;
    private Integer isEnable;
    private Integer isDelete;
}
