package com.jeeplus.modules.agentsystem.agency.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasFeedBackDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasFeedBack;

/**
 * 反馈Service
 * @author SZP
 * @version 2017-10-20
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasFeedBackService extends CrudService<WasFeedBackDao, WasFeedBack> {

	@Autowired
	private WasFeedBackDao wasFeedBackDao;
	
	@Override
	public WasFeedBack get(String id) {
		return super.get(id);
	}
	
	@Override
	public List<WasFeedBack> findList(WasFeedBack wasFeedBack) {
		return super.findList(wasFeedBack);
	}
	
	@Override
	public Page<WasFeedBack> findPage(Page<WasFeedBack> page, WasFeedBack wasFeedBack) {
		return super.findPage(page, wasFeedBack);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void save(WasFeedBack wasFeedBack) {
		super.save(wasFeedBack);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void delete(WasFeedBack wasFeedBack) {
		super.delete(wasFeedBack);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteByLogic(WasFeedBack wasFeedBack) {
		return wasFeedBackDao.deleteByLogic(wasFeedBack);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void insert(WasFeedBack wasFeedBack) {
		super.save(wasFeedBack);
	}
	
	//反馈问题提交保存
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer insertFeedBack(WasFeedBack wasFeedBack) {
		return wasFeedBackDao.insertFeedBack(wasFeedBack);
	}
}
