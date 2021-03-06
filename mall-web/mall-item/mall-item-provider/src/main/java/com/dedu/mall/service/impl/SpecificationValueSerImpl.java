package com.dedu.mall.service.impl;

import com.dedu.mall.dao.SpecificationValueDao;
import com.dedu.mall.model.mysql.SpecificationValuePo;
import com.dedu.mall.model.mysql.SpecificationValueVo;
import com.dedu.mall.service.SpecificationValueService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class SpecificationValueSerImpl implements SpecificationValueService {

    @Autowired
    private SpecificationValueDao specificationValueDao;

    @Override
    public List<SpecificationValuePo> addSpecificationValueBatch(List<SpecificationValueVo> specValueVoList) {
        List<SpecificationValuePo> specPoList = new ArrayList<>();
        specValueVoList.stream().forEach(vo -> {
            SpecificationValuePo specValuePo = new SpecificationValuePo();
            BeanUtils.copyProperties(vo, specValuePo);
            specValuePo.setIsEnable(Boolean.TRUE);
            specValuePo.setIsDelete(Boolean.FALSE);
            specValuePo.setCreateTime(LocalDateTime.now());
            specValuePo.setUpdateTime(LocalDateTime.now());
            specPoList.add(specValuePo);
        });
        specificationValueDao.saveBatch(specPoList);
        return specPoList;
    }
}
