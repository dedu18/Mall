package com.dedu.mall.model.po;

import com.baomidou.mybatisplus.annotation.IdType;
import com.baomidou.mybatisplus.annotation.TableField;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import com.fasterxml.jackson.annotation.JsonFormat;
import com.fasterxml.jackson.annotation.JsonIgnore;
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
@TableName("tb_user")
public class UserEntity {
    @TableId(value = "id", type = IdType.AUTO)
    private String id;
    @TableField(value="username")
    private String username;
    @JsonIgnore
    @TableField(value="password")
    private String password;
    @TableField(value="nackname")
    private String nackname;
    @TableField(value="phone")
    private String phone;
    @TableField(value="email")
    private String email;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @JsonSerialize(using = LocalDateTimeSerializer.class)
    @TableField(value="create_time")
    private LocalDateTime createTime;
    @JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
    @TableField(value="update_time")
    private LocalDateTime updateTime;
    @TableField(value="is_enable")
    private Integer isEnable;
    @TableField(value="is_delete")
    private Integer isDelete;
}
