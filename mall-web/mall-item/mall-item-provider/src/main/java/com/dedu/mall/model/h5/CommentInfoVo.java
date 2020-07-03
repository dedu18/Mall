package com.dedu.mall.model.h5;

import lombok.Builder;
import lombok.Data;

import java.util.List;

/**
 * 评价详情
 */
@Data
@Builder
public class CommentInfoVo {

    //评价条数
    private Integer remarksNum;
    // 好评率
    private Integer goodAnalyse;
    // 评价标签
    private List<String> remarksTags;
    // 各评价数量
    private List<Integer> remarksNumDetail;
    // 评价列表
    private List<CommentVo> detail;
}
