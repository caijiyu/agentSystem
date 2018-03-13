package com.jeeplus.modules.agentsystem.sysdata.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasMenuDao;
import com.jeeplus.modules.sys.entity.Menu;
/**
 * 菜单管理Service
 * @author Ricky
 * @version 2017-09-27
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasMenuService extends CrudService<WasMenuDao, Menu>{

	@Autowired
	private WasMenuDao wasMenuDao;
	/**删除菜单*/
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public void deleteMenu(Menu menu) {
		wasMenuDao.deleteMenu(menu);
	}
	/**获取所有子菜单*/
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public List<Menu> selectChild(String id) {
		return wasMenuDao.selectChild(id);
	}
}
