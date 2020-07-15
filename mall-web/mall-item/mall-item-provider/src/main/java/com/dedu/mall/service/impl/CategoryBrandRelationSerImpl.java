package com.dedu.mall.service.impl;

import com.dedu.mall.dao.CategoryBrandRelationDao;
import com.dedu.mall.model.mysql.BrandPo;
import com.dedu.mall.model.mysql.BrandVo;
import com.dedu.mall.service.CategoryBrandRelationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class CategoryBrandRelationSerImpl implements CategoryBrandRelationService {

    @Autowired
    private CategoryBrandRelationDao categoryBrandRelationDao;

    @Override
    public List<BrandVo> queryBrandsByCategoryId(Long categoryId) {
        List<BrandVo> result = new ArrayList<>();
        List<BrandPo> brandPos = categoryBrandRelationDao.selectBrandListByCategoryId(categoryId);
        brandPos.stream().forEach(b->result.add(BrandVo.builder().id(b.getId()).name(b.getName()).build()));
        return result;
    }
}
