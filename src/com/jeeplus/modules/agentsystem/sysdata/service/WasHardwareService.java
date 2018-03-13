/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.service;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasHardware;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasHardwareDao;

/**
 * 硬件管理Service
 * @author Ricky
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasHardwareService extends CrudService<WasHardwareDao, WasHardware> {
	
	@Autowired
	private WasHardwareDao wasHardwareDao;
	/**逻辑删除*/
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int deleteByLogic(WasHardware wasHardware) {
		return wasHardwareDao.deleteByLogic(wasHardware);
	}
	/**更新硬件卖出数量*/
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateSellNum(WasHardware wasHardware){
		return wasHardwareDao.updateSellNum(wasHardware);
	}
	
}