package com.jeeplus.modules.agentsystem.agency.dao;

import java.math.BigDecimal;
import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
/**
 * 
 * @author admin
 *
 */

@MyBatisDao
public interface WasSysUserDao extends CrudDao<WasSysUser>{
	/**
	 * 查询是不是微炫客的代理商
	 * @param sysUser
	 * @return
	 */
	List<WasSysUser> angentLookUp(WasSysUser sysUser);
	/**
	 * 更新代理商时间
	 * @param sysUser
	 * @return
	 */
	public Integer updateTime(WasSysUser sysUser);

	/**
	 * 更新代理商账户余额
	 * @param sysUser
	 * @return
	 */
	public Integer updateAccount(WasSysUser sysUser);
	/**
	 * 更新代理商删除状态
	 * @param sysUser
	 * @return
	 */
	public Integer updateDelState(WasSysUser sysUser);
	/**
	 * 找到所有的总代
	 * @param sysUser
	 * @return
	 */
	public List<WasSysUser> findAllSuperAgent();
	/**
	 * 找到下级代理商
	 * @param sysUser
	 * @return
	 */
	public List<WasSysUser> findAllLowerAgent(WasSysUser sysUser);
	/**
	 * 找到直属上级代理商
	 * @param id
	 * @return
	 */
	public WasSysUser getDirectAgent(String id);
	/**
	 * 找到当前代理商是否拥有下放代理商的权限
	 * @param id
	 * @return
	 */
	public Integer findDelegateAgent(String id);
	
	/**
	 * 更新公众号账户
	 * @param publicAccount
	 * @param publicExpend
	 * @param id
	 * @return
	 */
	public  Integer updatePublicAccountAndExpend(BigDecimal publicAccount,BigDecimal publicExpend,String id);
	/**
	 * 更新小程序账户
	 * @param minaAccount
	 * @param minaExpend
	 * @param id
	 * @return
	 */
	public  Integer updateMinaAccountAndExpend(BigDecimal minaAccount,BigDecimal minaExpend,String id);
	/**
	 * 更新VIP账户
	 * @param vipAccount
	 * @param vipExpend
	 * @param id
	 * @return
	 */
	public  Integer updateVipAccountAndExpend(BigDecimal vipAccount,BigDecimal vipExpend,String id);
	

}
