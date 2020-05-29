package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

/**
 * 评价
 */
@Data
@Builder
public class CommentVo {
    // 用户名
    private String username;
    // 评价星级
    private Double values;
    // 评价内容
    private String content;
    // 购买商品名
    private String goods;
    // 评价时间
    private LocalDateTime time;

}
