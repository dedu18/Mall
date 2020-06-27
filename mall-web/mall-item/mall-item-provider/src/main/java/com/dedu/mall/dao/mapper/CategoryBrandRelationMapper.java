package com.dedu.mall.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.dedu.mall.model.mysql.BrandPo;
import com.dedu.mall.model.mysql.CategoryBrandRelationPo;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface CategoryBrandRelationMapper extends BaseMapper<CategoryBrandRelationPo> {
    @Select("SELECT b.* FROM tb_category_brand a LEFT JOIN tb_brand b ON a.brand_id = b.id WHERE a.category_id = #{categoryId} AND a.is_delete = 0 AND a.is_enable = 1 AND b.is_delete = 0 AND b.is_enable = 1")
    List<BrandPo> selectBrandListByCategoryId(Long categoryId);
}
