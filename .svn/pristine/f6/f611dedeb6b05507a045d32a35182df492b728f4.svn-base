package com.jeeplus.modules.agentsystem.agency.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasPolicyPurchase;


/**
 * （软件）方针购买DAO接口
 * @author SZP
 * @version 2017-10-09
 */
@MyBatisDao
public interface WasPolicyPurchaseDao extends CrudDao<WasPolicyPurchase> {
	/**
	 * 方针购买记录逻辑删除
	 * @param policyPurchase
	 * @return
	 */
	public int deleteByLogic(WasPolicyPurchase policyPurchase);
	/**
	 * 根据终端用户id查找其购买过的方针
	 * @param terminalUserId
	 * @return
	 */
	public List<WasPolicyPurchase> findPolicyOfTerminalUser(String terminalUserId);
	/**
	 * 分页查询
	 * @param wasPolicyPurchase
	 * @return
	 */
	public List<WasPolicyPurchase> findRecord(WasPolicyPurchase wasPolicyPurchase);
	/**
	 * 删除
	 * @param policyPurchaseId
	 * @return
	 */
	public Integer deleteByPolicyPurchaseId(Integer policyPurchaseId);
}
