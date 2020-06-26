package com.dedu.mall.model.mysql;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.util.List;

@Data
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class CategoryNavItem {
    //列表元素标题
    private String title;
    //列表元素子列表
    private List<CategoryNavSubItem> tags;
}
