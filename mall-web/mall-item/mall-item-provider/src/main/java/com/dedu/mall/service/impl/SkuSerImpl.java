package com.dedu.mall.service.impl;

import com.dedu.mall.dao.SkuDao;
import com.dedu.mall.model.mysql.SkuPo;
import com.dedu.mall.model.mysql.SkuVo;
import com.dedu.mall.service.SkuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class SkuSerImpl implements SkuService {

    @Autowired
    private SkuDao skuDao;

    @Override
    public SkuPo addSku(SkuVo skuVo) {
        SkuPo skuPo = new SkuPo();
        BeanUtils.copyProperties(skuVo, skuPo);
        skuPo.setCreateTime(LocalDateTime.now());
        skuPo.setUpdateTime(LocalDateTime.now());
        skuPo.setIsEnable(Boolean.TRUE);
        skuPo.setIsDelete(Boolean.FALSE);
        if (skuDao.save(skuPo)) {
            return skuPo;
        }
        return null;
    }

    @Override
    public SkuVo querySkuById(Long id) {
        SkuPo skuPo = skuDao.getById(id);
        return null == skuPo ? null : new SkuVo(skuPo);
    }

    @Override
    public List<SkuVo> querySkuBySpuId(Long spuId) {
        List<SkuPo> skuPoList = skuDao.querySkuBySpuId(spuId);
        List<SkuVo> result = new ArrayList<>();
        for (SkuPo po : skuPoList) {
            result.add(new SkuVo(po));
        }
        return result;
    }
}
