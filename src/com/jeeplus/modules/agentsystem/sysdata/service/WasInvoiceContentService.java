/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.service;

import java.util.List;

import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.sysdata.dao.WasInvoiceContentDao;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasInvoiceContent;

/**
 * 发票内容Service
 * @author HJT
 * @version 2017-10-08
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasInvoiceContentService extends CrudService<WasInvoiceContentDao, WasInvoiceContent> {
    @Override
	public WasInvoiceContent get(String id) {
		return super.get(id);
	}
    @Override
	public List<WasInvoiceContent> findList(WasInvoiceContent wasInvoiceContent) {
		return super.findList(wasInvoiceContent);
	}
	//列表展示
    @Override
	public Page<WasInvoiceContent> findPage(Page<WasInvoiceContent> page, WasInvoiceContent wasInvoiceContent) {
		return super.findPage(page, wasInvoiceContent);
	}
	//保存
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveContent(WasInvoiceContent wasInvoiceContent) {
		return dao.insert(wasInvoiceContent);
	}
	//删除
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteContent(WasInvoiceContent wasInvoiceContent) {
		return dao.delete(wasInvoiceContent);
	}
	
}