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
import com.jeeplus.modules.agentsystem.sysdata.dao.WasSalesPolicyDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSalesPolicy;

/**
 * 销售方针Service
 * @author HJT
 * @version 2017-10-09
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasSalesPolicyService extends CrudService<WasSalesPolicyDao, WasSalesPolicy> {
    @Autowired
	private WasSalesPolicyDao wasSalesPolicyDao;
    @Override
	public WasSalesPolicy get(String id) {
		return super.get(id);
	}
	@Override
	public List<WasSalesPolicy> findList(WasSalesPolicy wasSalesPolicy) {
		return super.findList(wasSalesPolicy);
	}
	//列表
	@Override
	public Page<WasSalesPolicy> findPage(Page<WasSalesPolicy> page, WasSalesPolicy wasSalesPolicy) {
		return super.findPage(page, wasSalesPolicy);
	}
	//保存
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveSalesPolicy(WasSalesPolicy wasSalesPolicy) {
		return dao.insert(wasSalesPolicy);
	}
	//更新
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateSalesPolicy(WasSalesPolicy wasSalesPolicy) {
		return dao.update(wasSalesPolicy);
	}
	//逻辑删除
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteByLogic(WasSalesPolicy wasSalesPolicy){
		return dao.deleteByLogic(wasSalesPolicy);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@Override
	public void delete(WasSalesPolicy wasSalesPolicy) {
		super.delete(wasSalesPolicy);
	}
	public WasSalesPolicy findWasSalesPolicy(Integer salesPolicyId){
		return dao.findBySalesPolicyId(salesPolicyId);
	}
	public WasSalesPolicy findPolicy(WasSalesPolicy wasSalesPolicy){
		return dao.findPolicy(wasSalesPolicy);
	}
	/**
	 * 根据title查找
	 * @param title
	 * @return
	 */
	public Integer findTitleNum(String title) {
		return dao.findByTitle(title);
	}
	/**
	 * ...
	 * @return
	 */
	public List<WasSalesPolicy> findUseablePolicies(WasSalesPolicy wasSalesPolicy){
		return wasSalesPolicyDao.findUseablePolicies(wasSalesPolicy);
	}
	/**
	 * 查找未过期的方针
	 * @param wasSalesPolicy
	 * @return
	 */
	public List<WasSalesPolicy> getUnexpiredPolicy(WasSalesPolicy wasSalesPolicy){
		return dao.findUnexpiredPolicy(wasSalesPolicy);
	}
}