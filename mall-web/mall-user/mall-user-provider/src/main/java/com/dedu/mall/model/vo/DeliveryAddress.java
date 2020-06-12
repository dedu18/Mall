package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.validation.constraints.NotBlank;

/**
 * 收货地址
 */
@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class DeliveryAddress {
    @NotBlank
    private String sessionId;
    private String addressId;
    private String recipientName;
    private String province;
    private String city;
    private String area;
    private String address;
    private String phone;
    private String postalcode;
}
