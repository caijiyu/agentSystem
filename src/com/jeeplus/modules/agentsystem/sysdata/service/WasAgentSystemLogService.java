package com.jeeplus.modules.agentsystem.sysdata.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasAgentSystemLogDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;

/**
 * 日志Service
 * @author Wb
 * @date  2017-9-29
 * @version 1.0
 */
@Service
@Transactional(readOnly = true)
public class WasAgentSystemLogService extends CrudService<WasAgentSystemLogDao, WasAgentSystemLog> {
@Autowired
private WasAgentSystemLogDao wasAgentSystemLogDao;
	
	@Transactional(readOnly = false)
	public int insert(WasAgentSystemLog wasAgentSystemLog){
		return wasAgentSystemLogDao.insert(wasAgentSystemLog);
	}
}
