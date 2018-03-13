package com.jeeplus.modules.agentsystem.agency.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasFeedBack;

/**
 * @author WR
 *
 */
@MyBatisDao
public interface WasAgentAnsweredDao extends CrudDao<WasFeedBack>{
	    
	/**
	 * 删除
	 * @param wasFeedBack
	 * @return
	 */
	public Integer deleteAll(WasFeedBack wasFeedBack);
}
