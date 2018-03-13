package com.jeeplus.modules.agentsystem.agency.service;

import java.math.BigDecimal;
import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.agency.dao.WasSysUserDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;

/**
 * 
 * @author admin
 *
 */


@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasSysUserService extends CrudService<WasSysUserDao, WasSysUser>{
	@Autowired
	private WasSysUserDao wasSysUserDao;
	@Override
	public WasSysUser get(String id) {
		return super.get(id);
	}
	@Override
	public List<WasSysUser> findList(WasSysUser sysUser) {
		return super.findList(sysUser);
	}
	@Override
	public Page<WasSysUser> findPage(Page<WasSysUser> page, WasSysUser sysUser) {
		return super.findPage(page, sysUser);
	}
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int update(WasSysUser sysUser) {
		return super.update(sysUser);
	}
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void save(WasSysUser sysUser) {
		super.save(sysUser);
	}
	@Override
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void delete(WasSysUser sysUser) {
		super.delete(sysUser);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public List<WasSysUser> agentLookUp(WasSysUser sysUser) {
		return wasSysUserDao.angentLookUp(sysUser);
	}

	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateTime(WasSysUser sysUser) {
		return wasSysUserDao.updateTime(sysUser);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateAccount(WasSysUser sysUser) {
		return wasSysUserDao.updateAccount(sysUser);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateDel(WasSysUser sysUser) {
		return wasSysUserDao.updateDelState(sysUser);
	}
	//找到当前代理商是否拥有下放代理商的权限
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer findDelegateAgent(String id){
		return wasSysUserDao.findDelegateAgent(id);
	}
	
	//更新对应账户金额
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  Integer updatePublicAccountAndExpend(BigDecimal publicAccount,BigDecimal publicExpend,String id){
		return wasSysUserDao.updatePublicAccountAndExpend(publicAccount, publicExpend, id);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  Integer updateMinaAccountAndExpend(BigDecimal minaAccount,BigDecimal minaExpend,String id){
		return wasSysUserDao.updateMinaAccountAndExpend(minaAccount,minaExpend,id);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  Integer updateVipAccountAndExpend(BigDecimal vipAccount,BigDecimal vipExpend,String id){
		return wasSysUserDao.updateVipAccountAndExpend(vipAccount, vipExpend, id);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  List<WasSysUser> findAllSuperAgent(){
		return wasSysUserDao.findAllSuperAgent();
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  List<WasSysUser> findAllLowerAgent(WasSysUser sysUser){
		return wasSysUserDao.findAllLowerAgent(sysUser);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public  WasSysUser getDirectAgent(String id){
		return wasSysUserDao.getDirectAgent(id);
	}
	

}
