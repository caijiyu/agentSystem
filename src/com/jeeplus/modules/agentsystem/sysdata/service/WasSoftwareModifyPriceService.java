/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasSoftwareModifyPriceDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftwareModifyPrice;

/**
 * 软件修改价Service
 * @author HJT
 * @version 2017-09-29
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasSoftwareModifyPriceService extends CrudService<WasSoftwareModifyPriceDao, WasSoftwareModifyPrice> {
     @Autowired
	private WasSoftwareModifyPriceDao wasSoftwareModifyPriceDao;
	@Override
     public WasSoftwareModifyPrice get(String id) {
		return super.get(id);
	}
	//列表展示
	@Override
	public List<WasSoftwareModifyPrice> findList(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		return super.findList(wasSoftwareModifyPrice);
	}
	@Override
	public Page<WasSoftwareModifyPrice> findPage(Page<WasSoftwareModifyPrice> page, WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		return super.findPage(page, wasSoftwareModifyPrice);
	}
	//保存
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveModifyPrice(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		return dao.insert(wasSoftwareModifyPrice);
	}
	//编辑
		@Transactional(readOnly = false,rollbackFor=Exception.class)
		public Integer updateModifyPrice(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
			return dao.update(wasSoftwareModifyPrice);
		}
		//逻辑删除
		@Transactional(readOnly = false,rollbackFor=Exception.class)
		public Integer deleteByLogicModifyPrice(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
			return dao.deleteByLogic(wasSoftwareModifyPrice);
		}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@Override
	public void delete(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		super.delete(wasSoftwareModifyPrice);
	}
	public WasSoftwareModifyPrice findModifyPrice(WasSoftwareModifyPrice wasSoftwareModifyPrice){
		return wasSoftwareModifyPriceDao.findByModifypriceId(wasSoftwareModifyPrice);
	}
	public List<WasSoftwareModifyPrice> findChangeMoney(){
		return wasSoftwareModifyPriceDao.findChangeMoney();
	}
	public Integer getNum(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		return dao.findNum(wasSoftwareModifyPrice);
	}
}