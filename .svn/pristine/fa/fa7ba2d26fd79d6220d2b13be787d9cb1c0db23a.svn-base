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
import com.jeeplus.modules.agentsystem.sysdata.dao.WasFileClassifyDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFileClassify;

/**
 * 文件分类Service
 * @author WB
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true)
public class WasFileClassifyService extends CrudService<WasFileClassifyDao, WasFileClassify> {
	@Autowired
	private  WasFileClassifyDao wasFileClassifyDao;

	@Override
	public WasFileClassify get(String id) {
		return super.get(id);
	}
	
	@Override
	public List<WasFileClassify> findList(WasFileClassify wasFileClassify) {
		return super.findList(wasFileClassify);
	}
	
	@Override
	public Page<WasFileClassify> findPage(Page<WasFileClassify> page, WasFileClassify wasFileClassify) {
		return super.findPage(page, wasFileClassify);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void save(WasFileClassify wasFileClassify) {
		super.save(wasFileClassify);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(WasFileClassify wasFileClassify) {
		super.delete(wasFileClassify);
	}
	
	public Integer getFileClassifyByName(String fileClassifyName){
		return wasFileClassifyDao.getFileClassifyByName(fileClassifyName);
	}
	
	public List<WasFileClassify> findAllList(){
		return wasFileClassifyDao.findAllList();
	}
}