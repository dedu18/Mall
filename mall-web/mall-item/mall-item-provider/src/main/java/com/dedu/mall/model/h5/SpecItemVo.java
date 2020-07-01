package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.util.List;

@Data
@Builder
public class SpecItemVo {
    private String id;
    private String name;
    private List<String> specValues;
}
