package com.jeeplus.modules.agentsystem.sysdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasSoftwareDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftware;
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
/**
 * 
 * @author HJT
 *
 */
public class WasSoftwareService extends CrudService<WasSoftwareDao, WasSoftware>{
	@Autowired
	WasSoftwareDao wasSoftwareDao;
	
	@Override
	public Page<WasSoftware> findPage(Page<WasSoftware> page, WasSoftware wasSoftware) {
		return super.findPage(page, wasSoftware);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int updateSoftware(WasSoftware wasSoftware){
		return dao.update(wasSoftware);
	}
	public List<WasSoftware> findSoftwareList(WasSoftware wasSoftware) {
		return super.findList(wasSoftware);
	}

	public WasSoftware findSoftwareById(Integer softwareId){
		return wasSoftwareDao.findById(softwareId);
	}
	public List<WasSoftware> findAllSofts( ){
		return wasSoftwareDao.findAllSofts();
	}
}
