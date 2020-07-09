package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.dedu.mall.dao.SpecificationGroupDao;
import com.dedu.mall.model.mysql.SpecificationGroupPo;
import com.dedu.mall.model.mysql.SpecificationGroupVo;
import com.dedu.mall.model.mysql.SpecificationPo;
import com.dedu.mall.model.mysql.SpecificationVo;
import com.dedu.mall.service.SpecificationGroupService;
import com.dedu.mall.service.SpecificationService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;
import java.util.stream.Collectors;

@Service
@Slf4j
public class SpecificationGroupSerImpl implements SpecificationGroupService {

    @Autowired
    private SpecificationGroupDao specificationGroupDao;

    @Autowired
    private SpecificationService specService;

    @Override
    public List<SpecificationGroupVo> queryByCategoryId(Long id) throws Exception {
        // 根据类目Id获取分组信息
        List<SpecificationGroupPo> specGroupList = specificationGroupDao.list(new QueryWrapper<SpecificationGroupPo>().eq("category_id", id).eq("is_enable", Boolean.TRUE).eq("is_delete", Boolean.FALSE));
        // 根据分组Id获取规格属性
        Map<Long, List<SpecificationPo>> specCacheMap = new ConcurrentHashMap<>();
        if (!CollectionUtils.isEmpty(specGroupList)) {
            // 获取所有的分组Id
            List<Long> groupIdList = specGroupList.stream().map(SpecificationGroupPo::getId).distinct().collect(Collectors.toList());
            if (!CollectionUtils.isEmpty(groupIdList)) {
                List<SpecificationPo> specList = specService.queryByGroupIds(groupIdList);
                // 考虑到数据不多，可进行规格数据缓存
                specList.stream().forEach(t-> {
                    if (specCacheMap.containsKey(t.getGroupId())) {
                        specCacheMap.get(t.getGroupId()).add(t);
                    } else {
                        List<SpecificationPo> specCacheList = new ArrayList<>();
                        specCacheList.add(t);
                        specCacheMap.put(t.getGroupId(), specCacheList);
                    }
                });
            }
        }
        // 进行结果组装
        List<SpecificationGroupVo> result = new ArrayList<>();
        specGroupList.forEach(s->{
            SpecificationGroupVo specGroupVo = new SpecificationGroupVo();
            BeanUtils.copyProperties(s, specGroupVo);
            List<SpecificationVo> specVoList = new ArrayList<>();
            if (specCacheMap.containsKey(specGroupVo.getId())) {
                List<SpecificationPo> specPoList = specCacheMap.get(specGroupVo.getId());
                specPoList.stream().forEach(t->{
                    SpecificationVo specVo = new SpecificationVo();
                    BeanUtils.copyProperties(t, specVo);
                    specVoList.add(specVo);
                });
            } else {

            }
            specGroupVo.setSpecs(specVoList);
            result.add(specGroupVo);
        });
        return result;
    }

    @Override
    @Transactional
    public Boolean addSepcificationGroup(SpecificationGroupVo specGroupVo) {
        SpecificationGroupPo sepcGroupPo = new SpecificationGroupPo();
        BeanUtils.copyProperties(specGroupVo, sepcGroupPo);
        specificationGroupDao.saveOrUpdate(sepcGroupPo);
        if (!CollectionUtils.isEmpty(specGroupVo.getSpecs())) {
            specGroupVo.getSpecs().stream().forEach(t->{
                t.setGroupId(sepcGroupPo.getId());
                t.setGroupName(sepcGroupPo.getName());
            });
            specService.addSpecification(specGroupVo.getSpecs());
        }
        return Boolean.TRUE;
    }

    @Override
    @Transactional
    public Boolean modifySepcificationGroup(SpecificationGroupVo specGroupVo) throws Exception {
        if (null == specGroupVo.getId()) {
            throw new Exception("主键不能为空！");
        }
        SpecificationGroupPo sepcGroupPo = new SpecificationGroupPo();
        BeanUtils.copyProperties(specGroupVo, sepcGroupPo);
        specificationGroupDao.updateById(sepcGroupPo);
        if (!CollectionUtils.isEmpty(specGroupVo.getSpecs())) {
            specGroupVo.getSpecs().stream().forEach(t->{
                t.setGroupId(sepcGroupPo.getId());
                t.setGroupName(sepcGroupPo.getName());
            });
            specService.updateSpecificationOfGroup(specGroupVo.getSpecs());
        } else {
            specService.removeAllSpecificationByGroupId(sepcGroupPo.getId());
        }
        return Boolean.TRUE;
    }

    @Override
    @Transactional
    public Boolean removeSpecGroupById(Long id) {
        specificationGroupDao.updateById(SpecificationGroupPo.builder().id(id).isDelete(true).build());
        specService.removeAllSpecificationByGroupId(id);
        return Boolean.TRUE;
    }

}
