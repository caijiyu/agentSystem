/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import java.util.List;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFileClassify;

/**
 * 文件分类DAO接口
 * @author: WB
 * @date: 2017-09-27
 * @version 1.0
 */
@MyBatisDao
public interface WasFileClassifyDao extends CrudDao<WasFileClassify> {
	/**
	 * 根据分类名获取分类个数
	 * @param fileClassifyName
	 * @return
	 */
	public Integer getFileClassifyByName(String fileClassifyName);
	
	/**
	 * -获取所有的文件分类
	 * @return
	 */
	public List<WasFileClassify> findAllList();
}