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
import com.jeeplus.modules.agentsystem.sysdata.dao.WasFileDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFile;

/**
 * 文件列表Service
 * @author WB
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true)
public class WasFileService extends CrudService<WasFileDao, WasFile> {
	@Autowired
	private WasFileDao wasFileDao;
	
	@Override
	public WasFile get(String id) {
		return super.get(id);
	}
	
	@Override
	public List<WasFile> findList(WasFile wasFile) {
		return super.findList(wasFile);
	}
	
	@Override
	public Page<WasFile> findPage(Page<WasFile> page, WasFile wasFile) {
		return super.findPage(page, wasFile);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void save(WasFile wasFile) {
		super.save(wasFile);
	}
	
	@Override
	@Transactional(readOnly = false)
	public void delete(WasFile wasFile) {
		super.delete(wasFile);
	}
	
	public Integer getFileByClassifyId(Integer classifyId){
		return wasFileDao.getFileByClassifyId(classifyId);
	}
}