package com.dedu.mall.dao;

import com.baomidou.mybatisplus.extension.service.impl.ServiceImpl;
import com.dedu.mall.dao.mapper.PayMapper;
import com.dedu.mall.model.mysql.PayPo;
import org.springframework.stereotype.Repository;

@Repository
public class PayDao extends ServiceImpl<PayMapper, PayPo> {

}
