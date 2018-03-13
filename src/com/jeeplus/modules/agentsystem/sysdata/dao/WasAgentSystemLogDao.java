package com.jeeplus.modules.agentsystem.sysdata.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;

/**
 * 日志记录DAO接口
 * @author WB
 * @date: 2017-09-27
 * @version 1.0
 */
@MyBatisDao
public interface WasAgentSystemLogDao extends CrudDao<WasAgentSystemLog>{
	
}
