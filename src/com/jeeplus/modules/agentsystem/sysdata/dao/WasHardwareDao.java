/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasHardware;

/**
 * 硬件管理DAO接口
 * @author Ricky
 * @version 2017-09-27
 */
@MyBatisDao
public interface WasHardwareDao extends CrudDao<WasHardware> {
	/**
	 * 逻辑删除
	 * @param wasHardware
	 * @return
	 */
	public int deleteByLogic(WasHardware wasHardware);
	
	/**
	 * 更新硬件卖出数量
	 * @param wasHardware
	 * @return
	 */
	public int updateSellNum(WasHardware wasHardware);
}