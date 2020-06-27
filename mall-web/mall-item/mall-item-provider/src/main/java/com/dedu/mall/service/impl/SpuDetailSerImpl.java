package com.dedu.mall.service.impl;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.SpuDetailMapper;
import com.dedu.mall.model.mysql.SpuDetailPo;
import com.dedu.mall.model.mysql.SpuDetailVo;
import com.dedu.mall.service.SpuDetailService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;

@Service
@Slf4j
public class SpuDetailSerImpl extends ServiceImpl<SpuDetailMapper, SpuDetailPo> implements SpuDetailService {

    @Override
    public Boolean addSpuDetail(SpuDetailVo spuDetailVo) {
        SpuDetailPo spuDetailPo = new SpuDetailPo();
        BeanUtils.copyProperties(spuDetailVo, spuDetailPo);
        spuDetailPo.setCreateTime(LocalDateTime.now());
        spuDetailPo.setUpdateTime(LocalDateTime.now());
        spuDetailPo.setIsEnable(Boolean.TRUE);
        spuDetailPo.setIsDelete(Boolean.FALSE);
        return this.save(spuDetailPo);
    }
}
