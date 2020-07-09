package com.dedu.mall.service.impl;

import com.dedu.mall.dao.SpuDetailDao;
import com.dedu.mall.model.mysql.SpuDetailPo;
import com.dedu.mall.model.mysql.SpuDetailVo;
import com.dedu.mall.service.SpuDetailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class SpuDetailSerImpl implements SpuDetailService {

    @Autowired
    private SpuDetailDao spuDetailDao;

    @Override
    public Boolean addSpuDetail(SpuDetailVo spuDetailVo) {
        SpuDetailPo spuDetailPo = new SpuDetailPo();
        BeanUtils.copyProperties(spuDetailVo, spuDetailPo);
        spuDetailPo.setCreateTime(LocalDateTime.now());
        spuDetailPo.setUpdateTime(LocalDateTime.now());
        spuDetailPo.setIsEnable(Boolean.TRUE);
        spuDetailPo.setIsDelete(Boolean.FALSE);
        return spuDetailDao.save(spuDetailPo);
    }
}
