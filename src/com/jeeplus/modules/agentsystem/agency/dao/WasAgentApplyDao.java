package com.jeeplus.modules.agentsystem.agency.dao;

/**
 * 代理商申请Dao
 * @author: Bin
 * @date: 2017年10月9日 下午2:51:32
 * @version 1.0
 */
import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
@MyBatisDao
public interface WasAgentApplyDao extends CrudDao<WasSysUser>{
	/**
	 * 申请通过
	 * @param wasSysUser
	 * @return 
	 */
	public Integer pass(WasSysUser wasSysUser);
	
	/**
	 * 申请拒绝
	 * @param wasSysUser
	 * @return 
	 */
	public Integer overRule(WasSysUser wasSysUser);
	
	/**
	 * 查询所有是总代的用户的名称 
	 * @param permissionA
	 * @param permissionB
	 * @return 
	 */
	public List<WasSysUser> selectAllSuperAgent();
	
	/**
	 * 查询所有代理商等级
	 * @return 
	 */
	public List<WasAgentLevel>	getAllAgentLevel();
	
	/**
	 * 根据公司名获取用户数量
	 * @param companyName
	 * @return 
	 */
	public Integer	getCountByCopanyName(String companyName);
	
	/**
	 * 根据代理商等级id获取角色id
	 * @param id
	 * @return 
	 */
    public WasAgentLevel getAgentLevelById(Integer id);
    
    /**
	 * 根据用户id获取下放所需押金
	 * @param id
	 * @return 
	 */
    public String getCashPledgeByUid(String id);
}
