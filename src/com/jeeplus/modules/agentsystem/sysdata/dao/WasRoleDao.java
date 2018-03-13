package com.jeeplus.modules.agentsystem.sysdata.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.sys.entity.Role;

/**
 * 角色DAO接口
 * @author WB
 * @date: 2017-09-27
 * @version 1.0
 */
@MyBatisDao
public interface WasRoleDao extends CrudDao<Role>{
	/**
	 * 根据角色获取拥有该角色的用户数量
	 * @param role
	 * @return
	 */
	public Integer	getUserIdByRoleId(Role role);
	
	/**
	 * 根据角色获取拥有代理商等级数量
	 * @param role
	 * @return
	 */
	public Integer getWasAgentLevelByRoleId(Role role);
	
	/**
	 * 逻辑删除角色
	 * @param role
	 * @return
	 */
	public int	deleteByLogic(Role role);
	
	/**
	 * 验证名字重复
	 * @param name
	 * @return
	 */
	public Role getByName(String name);
	
	
	/**
	 * 查找所有的未删除角色
	 * @param name
	 * @return
	 */
	public List<Role> findAllList();
	
 
}
