/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgelimit;

/**
 * 年限DAO接口
 * @author HJT
 * @version 2017-09-29
 */
@MyBatisDao
public interface WasAgelimitDao extends CrudDao<WasAgelimit> {
	/**
	 * 根据年限查找数据
	 * @param year
	 * @return
	 */
	public WasAgelimit findByYear(Integer year);
}