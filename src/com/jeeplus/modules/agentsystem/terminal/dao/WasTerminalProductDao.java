package com.jeeplus.modules.agentsystem.terminal.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalProduct;
/**
 * 
 * @author Hua
 *
 */
@MyBatisDao
public interface WasTerminalProductDao extends CrudDao<WasTerminalProduct> {
	/**
	 * 根据终端用户id查找其拥有产品
	 * @param terminalUserId 终端用户id
	 * @return
	 */
	public List<WasTerminalProduct> findByTerminalUserId(Integer terminalUserId);
	/**
	 * 根据销售方针id查找终端产品
	 * @param salesPolicyId
	 * @return
	 */
	public WasTerminalProduct findCountById(Integer salesPolicyId);
	/**
	 * 插入数据
	 * @param wasTerminalProduct
	 * @return
	 */
	public Integer insertProduct(WasTerminalProduct wasTerminalProduct);
	/**
	 * 更新数据
	 * @param wasTerminalProduct
	 * @return
	 */
	public Integer updateProduct(WasTerminalProduct wasTerminalProduct);
	/**
	 * 根据终端用户id，销售方针id找终端产品
	 * @param terminalUserId
	 * @param softWareId
	 * @return
	 */
	public WasTerminalProduct findByTerminalUserIdAndSoftWareId(Integer terminalUserId,Integer softWareId);
}
