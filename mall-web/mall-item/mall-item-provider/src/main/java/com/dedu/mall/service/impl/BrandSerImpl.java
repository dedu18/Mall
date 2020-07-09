package com.dedu.mall.service.impl;

import com.alibaba.druid.util.StringUtils;
import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dedu.mall.dao.BrandDao;
import com.dedu.mall.model.mysql.BrandPo;
import com.dedu.mall.model.mysql.BrandVo;
import com.dedu.mall.service.BrandService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;

@Service
@Slf4j
public class BrandSerImpl implements BrandService {

    @Autowired
    private BrandDao brandDao;

    @Override
    public IPage<BrandVo> getBrandPage(Integer pageNum, Integer pageSize) {
        IPage<BrandPo> data = brandDao.page(new Page<>(pageNum, pageSize), new QueryWrapper<BrandPo>().eq("is_delete", 0));
        return convertBrandPoToVo(data);
    }

    @Override
    public Object addBrand(BrandVo brand) throws Exception {
        addCheck(brand);
        if (null != brand.getId() && 0L != brand.getId()) {
            modifyInfoById(brand);
        }
        // 必须指定id为null，否则为默认为0
        BrandPo brandPo = BrandPo
                .builder()
                .id(null)
                .name(brand.getName())
                .image(brand.getImage())
                .letter(brand.getLetter())
                .isEnable(Boolean.TRUE)
                .isDelete(Boolean.FALSE)
                .build();
        return brandDao.save(brandPo);
    }

    @Override
    public boolean deleteBrandById(Long id) {
        return brandDao.updateById(BrandPo.builder().id(id).isDelete(true).build());
    }

    @Override
    public boolean modifyInfoById(BrandVo brandVo) throws Exception {
        if (null == brandVo.getId() || 0L == brandVo.getId()) {
            throw new Exception("修改品牌时，Id不能为空");
        }
        BrandPo brandPo = new BrandPo();
        BeanUtils.copyProperties(brandVo, brandPo);
        return brandDao.updateById(brandPo);
    }

    /**
     * 个性化参数校验，防止接口校验相互影响
     * @param brand 添加的品牌
     * @throws Exception 校验异常
     */
    private void addCheck(BrandVo brand) throws Exception {
        if (StringUtils.isEmpty(brand.getName())) {
            throw new Exception("品牌名称不能为空");
        }
    }

    private IPage<BrandVo> convertBrandPoToVo(IPage<BrandPo> data) {
        IPage<BrandVo> result = new Page<>(data.getCurrent(), data.getSize());
        result.setTotal(data.getTotal());
        List<BrandVo> brandVoList = new ArrayList<>();
        data.getRecords().stream().forEach(b->{
            brandVoList.add(BrandVo.builder().id(b.getId()).name(b.getName()).image(b.getImage()).letter(b.getLetter()).build());
        });
        result.setRecords(brandVoList);
        return result;
    }
}
