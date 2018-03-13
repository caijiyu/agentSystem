package com.jeeplus.modules.agentsystem.terminal.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.terminal.dao.WasTerminalProductDao;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalProduct;
import com.jeeplus.modules.sys.dao.MenuDao;
import com.jeeplus.modules.sys.entity.Menu;
/**
 * 
 * @author Hua
 *
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasTerminalProductService extends CrudService<WasTerminalProductDao, WasTerminalProduct>{
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private WasTerminalProductDao wasTerminalProductDao;
	/**
	 * 查找menuId
	 * @param permission
	 * @return
	 */
	public String getMenuIdByPermission(String permission){
		Menu menu = menuDao.findUniqueByProperty("permission", "\"" + permission + "\"");
		return menu.getId();
	}
	/**
	 * 查找终端用户拥有的产品
	 * @param terminalUserId
	 * @return
	 */
	public List<WasTerminalProduct> findProductsByTerminalUserId(Integer terminalUserId){
		return wasTerminalProductDao.findByTerminalUserId(terminalUserId);
	}
	/**
	 * 个数
	 * @param salesPolicyId
	 * @return
	 */
	/*public WasTerminalProduct findCountById(Integer salesPolicyId){
		 return wasTerminalProductDao.findCountById(salesPolicyId);
	}*/
	/**
	 * 插入
	 * @param wasTerminalProduct
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer insertProduct(WasTerminalProduct wasTerminalProduct){
		return wasTerminalProductDao.insertProduct(wasTerminalProduct);
	}
	/**
	 * 更新
	 * @param wasTerminalProduct
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer updateProduct(WasTerminalProduct wasTerminalProduct){
		return wasTerminalProductDao.updateProduct(wasTerminalProduct);
	}
	/**
	 * 查找指定终端产品
	 * @param terminalUserId
	 * @param softWareId
	 * @return
	 */
	public WasTerminalProduct findByTerminalUserIdAndSoftWareId(Integer terminalUserId,Integer softWareId){
		return wasTerminalProductDao.findByTerminalUserIdAndSoftWareId(terminalUserId, softWareId);
	}
}
