/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasAgentLevelDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.sys.entity.Role;

/**
 * 代理商等级Service
 * @author HJT
 * @version 2017-10-09
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasAgentLevelService extends CrudService<WasAgentLevelDao, WasAgentLevel> {
    @Override
	public WasAgentLevel get(String id) {
		return super.get(id);
	}
    @Override
	public List<WasAgentLevel> findList(WasAgentLevel wasAgentLevel) {
		return super.findList(wasAgentLevel);
	}
    @Override
	public Page<WasAgentLevel> findPage(Page<WasAgentLevel> page, WasAgentLevel wasAgentLevel) {
		return super.findPage(page, wasAgentLevel);
	}
	//添加保存
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveAgentLevel(WasAgentLevel wasAgentLevel) {
		return dao.insert(wasAgentLevel);
	}
	//更新销售方针
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateAgentLevel(WasAgentLevel wasAgentLevel) {
		return dao.update(wasAgentLevel);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@Override
	public void delete(WasAgentLevel wasAgentLevel) {
		super.delete(wasAgentLevel);
	}
	/**
	 * 根据roleId查看是否有下放代理商的权限
	 * @param permissionA
	 * @param permissionB
	 * @param id
	 * @return
	 */
	public Integer whetherPermission(String permissionA,String permissionB,String id) {
		return dao.getRoleNum(permissionA, permissionB, id);
	}
	/**
	 * 获得角色名称
	 * @param roleType
	 * @return
	 */
	public List<Role> getroleType(String roleType){
		return dao.findByRoletype(roleType);
	}
	/**
	 * 逻辑删除
	 * @param wasAgentLevel
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteAgentLevel(WasAgentLevel wasAgentLevel) {
		return dao.deleteByLogic(wasAgentLevel);
	}
	/**
	 * 从sys_user
	 * @param agentLevelId
	 * @return
	 */
	public Integer wasAgentLevelSum(Integer agentLevelId) {
		return dao.findByAgentLevelId(agentLevelId);
	}
	/**
	 * 查找代理等级entiy
	 * @param agentLevelId
	 * @return
	 */
	public WasAgentLevel getEnity(Integer agentLevelId) {
		return dao.findEnity(agentLevelId);
	}
	/**
	 * 根据name查找数据个数
	 * @param name
	 * @return
	 */
	public Integer getNum(String name) {
		return dao.getNameNum(name);
	}
	/**
	 * 查找角色entiy
	 * @param id
	 * @return
	 */
	public Role findRoleEnity(String id) {
		return dao.findRoleById(id);
	}
}