/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.entity;

import javax.validation.constraints.NotNull;

import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 年限Entity
 * @author HJT
 * @version 2017-09-29
 */
public class WasAgelimit extends DataEntity<WasAgelimit> {
	
	private static final long serialVersionUID = 1L;
	/**
	 * 年限ID
	 */
	private Integer agelimitId;		
	/**
	 * 年限
	 */
	private Integer year;		
	
	public WasAgelimit() {
		super();
	}

	public WasAgelimit(String id){
		super(id);
	}

	@NotNull(message="主键ID不能为空")
	@ExcelField(title="主键ID", align=2, sort=0)
	public Integer getAgelimitId() {
		return agelimitId;
	}

	public void setAgelimitId(Integer agelimitId) {
		this.agelimitId = agelimitId;
	}
	
	@NotNull(message="年限不能为空")
	@ExcelField(title="年限", align=2, sort=1)
	public Integer getYear() {
		return year;
	}

	public void setYear(Integer year) {
		this.year = year;
	}
	
}