/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftwareModifyPrice;

/**
 * 软件修改价DAO接口
 * @author HJT
 * @version 2017-09-29
 */
@MyBatisDao
public interface WasSoftwareModifyPriceDao extends CrudDao<WasSoftwareModifyPrice> {
	/**
	 * 根据Id查找数据
	 * @param wasSoftwareModifyPrice
	 * @return
	 */
	public WasSoftwareModifyPrice findByModifypriceId(WasSoftwareModifyPrice wasSoftwareModifyPrice);
	/**
	 * 。。。
	 * @return
	 */
	public List<WasSoftwareModifyPrice> findChangeMoney();
	/**
	 * 重复验证
	 * @return
	 */
	public Integer findNum(WasSoftwareModifyPrice wasSoftwareModifyPrice);
}