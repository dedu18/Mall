package com.dedu.mall.model.vo;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.databind.annotation.JsonSerialize;
import com.fasterxml.jackson.datatype.jsr310.ser.LocalDateTimeSerializer;
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
