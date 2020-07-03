package com.dedu.mall.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.SpuDao;
import com.dedu.mall.dao.mapper.SpuMapper;
import com.dedu.mall.model.mysql.SpuAndDetailVo;
import com.dedu.mall.model.mysql.SpuPo;
import com.dedu.mall.model.mysql.SpuVo;
import com.dedu.mall.service.SpuDetailService;
import com.dedu.mall.service.SpuService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.CollectionUtils;

import java.time.LocalDateTime;
import java.util.List;

@Service
@Slf4j
public class SpuSerImpl implements SpuService {

    @Autowired
    private SpuDetailService spuDetailService;

    @Autowired
    private SpuDao spuDao;

    @Override
    public IPage<SpuVo> getSpuPage(Integer pageNum, Integer pageSize) {
        IPage<SpuVo> result = new Page<>();
        List<SpuVo> data = spuDao.selectSpuPage(new Page<>(pageNum, pageSize));
        Integer count = spuDao.selectSpuCount();
        if (!CollectionUtils.isEmpty(data)) {
            data.stream().forEach(t->{
                //,分隔   获取首长图片
                String images = t.getImages();
                if (!StringUtils.isEmpty(images)) {
                    String[] splitimages = images.split("\\,");
                    t.setImage(splitimages[0] == null?"": splitimages[0]);
                }
            });
        }
        result.setTotal(count);
        result.setRecords(data);
        result.setCurrent(pageNum);
        result.setSize(pageSize);
        return result;
    }

    @Transactional
    public SpuPo addSpuAndSpuDetail(SpuAndDetailVo spuAndDetailVo) {
        SpuPo spuPo = new SpuPo();
        BeanUtils.copyProperties(spuAndDetailVo, spuPo);
        spuPo.setCreateTime(LocalDateTime.now());
        spuPo.setUpdateTime(LocalDateTime.now());
        spuPo.setIsEnable(Boolean.TRUE);
        spuPo.setIsDelete(Boolean.FALSE);
        boolean spuSaveRst = spuDao.save(spuPo);
        if (spuSaveRst) {
            if (null != spuAndDetailVo.getSpuDetailVo()) {
                spuAndDetailVo.getSpuDetailVo().setSpuId(spuPo.getId());
                spuDetailService.addSpuDetail(spuAndDetailVo.getSpuDetailVo());
            }
        }
        return spuPo;
    }

    @Override
    public IPage<SpuPo> getSpuPageByCategoryId(Long categoryId, Integer pageNum, Integer pageSize) {
        return spuDao.getSpuPageByCategoryId(categoryId, new Page<>(pageNum, pageSize));
    }

    @Override
    public SpuVo getSpuBySpuId(Long spuId) {
        SpuPo spuPo = spuDao.getSpuPoBySpuId(spuId);
        return new SpuVo(spuPo);
    }
}
