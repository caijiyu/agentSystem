package com.jeeplus.modules.agentsystem.sysdata.dao;


import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.sys.entity.Menu;
/**
 * 菜单管理Dao接口
 * @author Ricky
 * @version 2017-09-27
 */
@MyBatisDao
public interface WasMenuDao extends CrudDao<Menu>{
	/**
	 * 删除菜单
	 * @param menu
	 */
	public void deleteMenu(Menu menu);
	/**
	 * 获取子菜单
	 * @param id
	 * @return
	 */
	public List<Menu> selectChild(String id);

}
