/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.entity;

import java.util.Date;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import org.springframework.web.util.HtmlUtils;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 发票内容Entity
 * @author HJT
 * @version 2017-10-08
 */
public class WasInvoiceContent extends DataEntity<WasInvoiceContent> {
	
	private static final long serialVersionUID = 1L;
	/**
	 * 主键ID
	 */
	private Integer contentId;		
	/**
	 * 内容 
	 */
	private String details;	
	/**
	 * 开始时间
	 */
	private Date startCreateDate;		
	/**
	 * 结束时间
	 */
	private Date endCreateDate;		

	public WasInvoiceContent() {
		super();
	}

	public WasInvoiceContent(String id){
		super(id);
	}

	
	
	
	public Date getStartCreateDate() {
		return startCreateDate;
	}

	public void setStartCreateDate(Date startCreateDate) {
		this.startCreateDate = startCreateDate;
	}

	public Date getEndCreateDate() {
		return endCreateDate;
	}

	public void setEndCreateDate(Date endCreateDate) {
		this.endCreateDate = endCreateDate;
	}

	@NotNull(message="主键ID不能为空")
	@ExcelField(title="主键ID", align=2, sort=0)
	public Integer getContentId() {
		return contentId;
	}

	public void setContentId(Integer contentId) {
		this.contentId = contentId;
	}
	
	@Length(min=1, max=100, message="内容长度必须介于 1 和 100 之间")
	@ExcelField(title="内容", align=2, sort=1)
	public String getDetails() {
		return HtmlUtils.htmlUnescape(details);
	}

	public void setDetails(String details) {
		this.details = HtmlUtils.htmlUnescape(details);
	}
	
}