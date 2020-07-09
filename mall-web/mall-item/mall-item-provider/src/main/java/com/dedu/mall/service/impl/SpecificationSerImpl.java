package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dedu.mall.dao.SpecificationDao;
import com.dedu.mall.model.mysql.SpecificationPo;
import com.dedu.mall.model.mysql.SpecificationVo;
import com.dedu.mall.service.SpecificationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

@Service
@Slf4j
public class SpecificationSerImpl implements SpecificationService {

    @Autowired
    private SpecificationDao specificationDao;

    @Override
    public List<SpecificationPo> queryByGroupIds(List<Long> groupIdList) throws Exception {
        if (CollectionUtils.isEmpty(groupIdList)) {
            throw new Exception("分组Id不能为空");
        }
        return specificationDao.list(new QueryWrapper<SpecificationPo>().eq("is_delete", Boolean.FALSE).in("group_id", groupIdList));
    }

    @Override
    public void addSpecification(List<SpecificationVo> specVoList) {
        List<SpecificationPo> specPoList = new ArrayList<>();
        specVoList.stream().forEach(s->{
            SpecificationPo specPo = new SpecificationPo();
            BeanUtils.copyProperties(s, specPo);
            specPoList.add(specPo);
        });
        specificationDao.saveBatch(specPoList);
    }

    /**
     * 更新某个分组下的规则参数，先移除后新增
     * @param specVoList
     */
    public void updateSpecificationOfGroup(List<SpecificationVo> specVoList) {
        List<Long> groupIds = specVoList.stream().map(SpecificationVo::getGroupId).distinct().collect(Collectors.toList());
        specificationDao.update(SpecificationPo.builder().isDelete(true).build(), new QueryWrapper<SpecificationPo>().eq("is_delete",0).in("group_id", groupIds));
        List<SpecificationPo> specPoList = new ArrayList<>();
        specVoList.stream().forEach(s->{
            SpecificationPo specPo = new SpecificationPo();
            BeanUtils.copyProperties(s, specPo);
            specPo.setId(null);
            specPoList.add(specPo);
        });
        specificationDao.saveBatch(specPoList);
    }

    @Override
    public void removeAllSpecificationByGroupId(Long id) {
        specificationDao.update(SpecificationPo.builder().isEnable(Boolean.FALSE).isDelete(Boolean.TRUE).build(), new QueryWrapper<SpecificationPo>().eq("group_id", id).eq("is_delete", Boolean.FALSE));
    }

    @Override
    public SpecificationPo getSpecById(Long specId) {
        return specificationDao.getById(specId);
    }
}
