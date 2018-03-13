package com.jeeplus.modules.agentsystem.agency.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasRechargeHistoryDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasRechargeHistory;

/**
 * 代理商充值记录Service
 * @author SZP
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true)
public class WasRechargeHistoryService extends CrudService<WasRechargeHistoryDao, WasRechargeHistory> {
	
	@Autowired
	private WasRechargeHistoryDao rechargeHistoryDao;
	
	public WasRechargeHistory get(String id) {
		return super.get(id);
	}
	
	public List<WasRechargeHistory> findList(WasRechargeHistory rechargeHistory) {
		return super.findList(rechargeHistory);
	}
	
	public Page<WasRechargeHistory> findPage(Page<WasRechargeHistory> page, WasRechargeHistory rechargeHistory) {
		return super.findPage(page, rechargeHistory);
	}
	
	@Transactional(readOnly = false)
	public void save(WasRechargeHistory rechargeHistory) {
		super.save(rechargeHistory);
	}
	
	@Transactional(readOnly = false)
	public void delete(WasRechargeHistory rechargeHistory) {
		super.delete(rechargeHistory);
	}
	
	@Transactional(readOnly = false)
	public Integer deleteByLogic(WasRechargeHistory rechargeHistory) {
		return rechargeHistoryDao.deleteByLogic(rechargeHistory);
	}
	
	@Transactional(readOnly = false)
	public void insert(WasRechargeHistory rechargeHistory) {
		super.save(rechargeHistory);
	}
	
	
	
	
}
