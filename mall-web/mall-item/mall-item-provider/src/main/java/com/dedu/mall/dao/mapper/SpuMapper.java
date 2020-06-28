package com.dedu.mall.dao.mapper;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.dedu.mall.model.mysql.SpuPo;
import com.dedu.mall.model.mysql.SpuVo;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

public interface SpuMapper extends BaseMapper<SpuPo> {

    @Select("SELECT spu.id as spuId, spu.title as spuTitle, spu.sub_title as spuSubtitle, spu.saleable as saleable, spu.create_time as createTime, spu.update_time as updateTime, sku.images as images, sku.price as price, stock.stock as stock  FROM tb_spu spu, tb_sku sku, tb_stock stock WHERE sku.spu_id = spu.id AND stock.sku_id = sku.id")
    List<SpuVo> selectSpuPage(Page<SpuVo> pagination);

    @Select("SELECT COUNT(1) FROM tb_spu spu, tb_sku sku, tb_stock stock WHERE sku.spu_id = spu.id AND stock.sku_id = sku.id")
    Integer selectSpuCount();
}
