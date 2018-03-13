/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFile;

/**
 * 文件列表DAO接口
 * @author WB
 * @date: 2017-09-27
 * @version 1.0
 */
@MyBatisDao
public interface WasFileDao extends CrudDao<WasFile> {
	/**
	 * 根据文件分类外键id获取文件信息个数
	 * @param classifyId
	 * @return
	 */
	public Integer getFileByClassifyId(Integer classifyId);
}