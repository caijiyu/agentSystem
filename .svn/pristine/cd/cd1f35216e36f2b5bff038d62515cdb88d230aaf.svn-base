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
import com.jeeplus.modules.agentsystem.sysdata.dao.WasAgelimitDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgelimit;

/**
 * 年限Service
 * @author HJT
 * @version 2017-09-29
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasAgelimitService extends CrudService<WasAgelimitDao, WasAgelimit> {
    
	@Autowired
	private WasAgelimitDao wasAgelimitDao;
	@Override
	public WasAgelimit get(String id) {
		return super.get(id);
	}
	//列表展示
	@Override
	public List<WasAgelimit> findList(WasAgelimit wasAgelimit) {
		return super.findList(wasAgelimit);
	}
	/**
	 * 根据年限查找数据
	 * @param year
	 * @return
	 */
		public WasAgelimit findYear(Integer year) {
			return wasAgelimitDao.findByYear(year);
		}
		//列表
		@Override
	public Page<WasAgelimit> findPage(Page<WasAgelimit> page, WasAgelimit wasAgelimit) {
		return super.findPage(page, wasAgelimit);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveAgelimit(WasAgelimit wasAgelimit) {
	   return dao.insert(wasAgelimit);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteAge(WasAgelimit wasAgelimit) {
		return dao.delete(wasAgelimit);
	}
	
}