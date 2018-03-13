package com.jeeplus.modules.agentsystem.agency.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasAgentAnsweredDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasFeedBack;

/**
 * 
 * @author WR
 * @version 2017-9-29
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasAgentAnsweredService extends CrudService<WasAgentAnsweredDao, WasFeedBack>{
	
	
	@Autowired
	private WasAgentAnsweredDao wasAgentAnsweredDao;

	
	//未申请的表单的list显示
	
	public Page<WasFeedBack> findList(Page<WasFeedBack> page, WasFeedBack wasFeedBack) {
		// TODO Auto-generated method stub
		return super.findPage(page, wasFeedBack);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteAll(WasFeedBack wasFeedBack) {
		// TODO Auto-generated method stub
		return wasAgentAnsweredDao.deleteAll(wasFeedBack);
	}
	
}
