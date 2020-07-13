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

    @Select("SELECT spu.id AS spuId, spu.title AS spuTitle, spu.sub_title AS spuSubtitle, spu.saleable AS saleable, spu.categoty_names AS categotyNames, spu.create_time AS createTime, spu.update_time AS updateTime FROM tb_spu spu WHERE spu.is_enable = 1 AND spu.is_delete = 0")
    List<SpuVo> selectSpuPage(Page<SpuVo> pagination);

    @Select("SELECT COUNT(1) FROM tb_spu spu WHERE spu.is_enable = 1")
    Integer selectSpuCount();
}
