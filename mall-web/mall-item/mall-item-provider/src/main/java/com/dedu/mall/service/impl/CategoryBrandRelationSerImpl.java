package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.CategoryBrandRelationMapper;
import com.dedu.mall.model.mysql.BrandPo;
import com.dedu.mall.model.mysql.BrandVo;
import com.dedu.mall.model.mysql.CategoryBrandRelationPo;
import com.dedu.mall.service.CategoryBrandRelationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class CategoryBrandRelationSerImpl extends ServiceImpl<CategoryBrandRelationMapper, CategoryBrandRelationPo> implements CategoryBrandRelationService {

    @Override
    public List<BrandVo> queryBrandsByCategoryId(Long categoryId) {
        List<BrandVo> result = new ArrayList<>();
        List<BrandPo> brandPos = this.getBaseMapper().selectBrandListByCategoryId(categoryId);
        brandPos.stream().forEach(b->result.add(BrandVo.builder().id(b.getId()).name(b.getName()).build()));
        return result;
    }
}
