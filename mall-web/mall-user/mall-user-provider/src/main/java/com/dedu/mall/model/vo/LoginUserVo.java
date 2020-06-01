package com.dedu.mall.model.vo;

import lombok.Data;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;

@Data
public class LoginUserVo {
    @NotBlank
    @Length(max = 50)
    private String username;
    @NotBlank
    @Length(max = 20)
    private String password;
}
