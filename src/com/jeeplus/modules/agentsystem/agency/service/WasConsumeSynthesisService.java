package com.jeeplus.modules.agentsystem.agency.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasConsumeSynthesisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasConsumeSynthesis;

/**
 * 代理商消费综合实体Service
 * @author SZP
 * @version 2017-09-29
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasConsumeSynthesisService extends CrudService<WasConsumeSynthesisDao, WasConsumeSynthesis> {
	
	@Autowired
	private WasConsumeSynthesisDao consumeSynthesisDao;
	
	@Override
	public WasConsumeSynthesis get(String id) {
		return super.get(id);
	}
	
	@Override
	public List<WasConsumeSynthesis> findList(WasConsumeSynthesis consumeSynthesis) {
		return super.findList(consumeSynthesis);
	}
	
	@Override
	public Page<WasConsumeSynthesis> findPage(Page<WasConsumeSynthesis> page, WasConsumeSynthesis consumeSynthesis) {
		return super.findPage(page, consumeSynthesis);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void save(WasConsumeSynthesis consumeSynthesis) {
		super.save(consumeSynthesis);
	}
	
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void delete(WasConsumeSynthesis consumeSynthesis) {
		super.delete(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateInvoiceY(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateInvoiceY(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateInvoiceR(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateInvoiceR(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateInvoiceC(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateInvoiceC(consumeSynthesis);
	}

	public List<WasConsumeSynthesis> findForList(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.findForList(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateOrderC(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateOrderC(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateOrderY(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateOrderY(consumeSynthesis);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateOrderR(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.updateOrderR(consumeSynthesis);
	}
	
	public List<WasConsumeSynthesis> findInvoiceList(WasConsumeSynthesis consumeSynthesis){
		return consumeSynthesisDao.findInvoiceList(consumeSynthesis);
	}

	public List<WasConsumeSynthesis> findForListForm(WasConsumeSynthesis consumeSynthesis) {
		// TODO Auto-generated method stub
		return consumeSynthesisDao.findForListForm(consumeSynthesis);
	}
}
