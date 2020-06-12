package com.dedu.mall.model.po;

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
@TableName("tb_user_address")
public class UserAddressEntity {
    @TableId(value = "id", type = IdType.AUTO)
    private String id;
    @TableField(value = "user_id")
    private String userId;
    @TableField(value = "recipient_name")
    private String recipientName;
    @TableField(value = "province")
    private String province;
    @TableField(value = "city")
    private String city;
    @TableField(value = "area")
    private String area;
    @TableField(value = "address")
    private String address;
    @TableField(value = "phone")
    private String phone;
    @TableField(value = "postal_code")
    private String postalCode;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @TableField(value = "create_time")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value = "update_time")
    private LocalDateTime updateTime;
    @TableField(value = "is_enable")
    private Integer isEnable;
    @TableField(value = "is_delete")
    private Integer isDelete;
}
