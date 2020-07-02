package com.dedu.mall.service;

import com.dedu.mall.model.mysql.SpecificationPo;
import com.dedu.mall.model.mysql.SpecificationVo;

import java.util.List;

public interface SpecificationService {

    List<SpecificationPo> queryByGroupIds(List<Long> groupIdList) throws Exception;

    void addSpecification(List<SpecificationVo> specPo);

    void updateSpecificationOfGroup(List<SpecificationVo> specVoList);

    void removeAllSpecificationByGroupId(Long id);

    SpecificationPo getSpecById(Long specId);
}
