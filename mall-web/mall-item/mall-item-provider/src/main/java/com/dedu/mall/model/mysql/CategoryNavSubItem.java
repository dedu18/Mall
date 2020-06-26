package com.dedu.mall.model.mysql;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryNavSubItem {
    //三级列表元素主键
    private Long id;
    //三级列表元素名称
    private String name;
}
