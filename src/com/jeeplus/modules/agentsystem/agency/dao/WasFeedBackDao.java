package com.jeeplus.modules.agentsystem.agency.dao;

import com.jeeplus.common.persistence.CrudDao;
import com.jeeplus.common.persistence.annotation.MyBatisDao;
import com.jeeplus.modules.agentsystem.agency.entity.WasFeedBack;
/**
 * 反馈DAO接口
 * @author SZP
 * @version 2017-10-20
 */
@MyBatisDao
public interface WasFeedBackDao extends CrudDao<WasFeedBack> {
	/**
	 * 问题反馈提交保存插入
	 * @param wasFeedBack
	 * @return
	 */
	public int insertFeedBack(WasFeedBack wasFeedBack);
}
