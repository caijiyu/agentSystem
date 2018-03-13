/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.sys.entity.Role;

/**
 * 代理商等级DAO接口
 * @author HJT
 * @version 2017-10-09
 */
@MyBatisDao
public interface WasAgentLevelDao extends CrudDao<WasAgentLevel> {
	/**
	 * 根据角色类型查找数据
	 * @param roleType
	 * @return
	 */
	public List<Role> findByRoletype(String roleType);
	/**
	 * 判断是否可以下方代理商
	 * @param permissionA
	 * @param permissionB
	 * @param id
	 * @return
	 */
	public Integer getRoleNum(String permissionA,String permissionB,String id);
	/**
	 * 根据ID查找数据
	 * @param agentLevelId
	 * @return
	 */
	public Integer findByAgentLevelId(Integer agentLevelId);
	/**
	 * 查找实体
	 * @param agentLevelId
	 * @return
	 */
	public WasAgentLevel findEnity(Integer agentLevelId);
	/**
	 * 。。。
	 * @param name
	 * @return
	 */
	public Integer getNameNum(String name);
	/**
	 * 查找角色
	 * @param id
	 * @return
	 */
	public Role findRoleById(String id);
}