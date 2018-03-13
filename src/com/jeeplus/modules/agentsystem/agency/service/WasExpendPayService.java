package com.jeeplus.modules.agentsystem.agency.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasExpendPayDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasExpendPay;

/**
 * 充消Service
 * @author SZP
 * @version 2017-10-09
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasExpendPayService extends CrudService<WasExpendPayDao, WasExpendPay> {

	@Autowired
	private WasExpendPayDao expendPayDao;
	
	@Override
	public WasExpendPay get(String id) {
		return super.get(id);
	}
	
	@Override
	public List<WasExpendPay> findList(WasExpendPay expendPay) {
		return super.findList(expendPay);
	}
	
	@Override
	public Page<WasExpendPay> findPage(Page<WasExpendPay> page, WasExpendPay expendPay) {
		return super.findPage(page, expendPay);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void save(WasExpendPay expendPay) {
		super.save(expendPay);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void delete(WasExpendPay expendPay) {
		super.delete(expendPay);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteByLogic(WasExpendPay expendPay) {
		return expendPayDao.deleteByLogic(expendPay);
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void insert(WasExpendPay expendPay) {
		super.save(expendPay);
	}
}
