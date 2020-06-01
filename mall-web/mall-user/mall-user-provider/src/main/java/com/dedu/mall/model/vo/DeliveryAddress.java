package com.dedu.mall.model.vo;

import lombok.Builder;
import lombok.Data;

/**
 * 收货地址
 */
@Data
@Builder
public class DeliveryAddress {
    private String addressId;
    private String name;
    private String province;
    private String city;
    private String area;
    private String address;
    private String phone;
    private String postalcode;
}
