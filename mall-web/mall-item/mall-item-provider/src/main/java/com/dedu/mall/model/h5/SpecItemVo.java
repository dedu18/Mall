package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.util.List;
import java.util.Map;
import java.util.Set;

@Data
@Builder
public class SpecItemVo {
    private String id;
    private String name;
    private Set<SpecValueItem> specValues;
}
