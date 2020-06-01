package com.dedu.mall.model.vo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.validator.constraints.Length;

import javax.validation.constraints.NotBlank;

@Data
@AllArgsConstructor
@NoArgsConstructor
public class RegisterUserVo {
    @NotBlank
    @Length(max = 50)
    private String username;
    @NotBlank
    @Length(max = 20)
    private String password;
    @NotBlank
    private String mail;
    @NotBlank
    private String phone;
}
