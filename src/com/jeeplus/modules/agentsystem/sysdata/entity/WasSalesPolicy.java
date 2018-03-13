/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.entity;

import javax.validation.constraints.NotNull;
import org.hibernate.validator.constraints.Length;
import org.springframework.web.util.HtmlUtils;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.common.utils.excel.annotation.ExcelField;

/**
 * 销售方针Entity
 * @author HJT
 * @version 2017-10-09
 */
public class WasSalesPolicy extends DataEntity<WasSalesPolicy> implements Comparable<WasSalesPolicy>{
	
	private static final long serialVersionUID = 1L;
	/**
	 * 主键ID
	 */
	private Integer salesPolicyId;		
	/**
	 * 软件ID（1,2,3）
	 */
	private String softwareIds;		
	/**
	 * 套餐名
	 */
	private String title;		
	/**
	 * 开通年限
	 */
	private Integer dredgeYear;		
	/**
	 * 赠送年限
	 */
	private Integer giveYear;		
	/**
	 * 价格
	 */
	private BigDecimal price;		
	/**
	 * 续费折扣
	 */
	private BigDecimal renewDiscount;		
	/**
	 * 分类（0：公众号,1：小程序，2：混合套餐）
	 */
	private Integer classify;		
	/**
	 * 开始时间
	 */
	private Date startDate;		
	/**
	 * 结束时间
	 */
	private Date endDate;		
	/**
	 * 排序
	 */
	private Integer sort;		
	/**
	 * 状态（0：删除，1：正常）
	 */
	private Boolean state;	
	
	/**
	 * 备注
	 */
	private String remarks;
	
	private List<WasSoftware> softs = Lists.newArrayList();
	
	
	public List<WasSoftware> getSofts() {
		return softs;
	}

	public void setSofts(List<WasSoftware> softs) {
		this.softs = softs;
	}

	public String getRemarks() {
		return HtmlUtils.htmlUnescape(remarks);
	}

	public void setRemarks(String remarks) {
		this.remarks = HtmlUtils.htmlUnescape(remarks);
	}

	public WasSalesPolicy() {
		super();
	}

	public WasSalesPolicy(String id){
		super(id);
	}

	@NotNull(message="主键ID不能为空")
	@ExcelField(title="主键ID", align=2, sort=0)
	public Integer getSalesPolicyId() {
		return salesPolicyId;
	}

	public void setSalesPolicyId(Integer salesPolicyId) {
		this.salesPolicyId = salesPolicyId;
	}
	
	@Length(min=1, max=50, message="软件ID（1,2,3）长度必须介于 1 和 50 之间")
	@ExcelField(title="软件ID（1,2,3）", align=2, sort=2)
	public String getSoftwareIds() {
		return softwareIds;
	}

	public void setSoftwareIds(String softwareIds) {
		this.softwareIds = softwareIds;
	}
	
	@Length(min=1, max=100, message="套餐名长度必须介于 1 和 100 之间")
	@ExcelField(title="套餐名", align=2, sort=3)
	public String getTitle() {
		return HtmlUtils.htmlUnescape(title);
	}

	public void setTitle(String title) {
		this.title = HtmlUtils.htmlUnescape(title);
	}
	
	@NotNull(message="开通年限不能为空")
	@ExcelField(title="开通年限", dictType="", align=2, sort=4)
	public Integer getDredgeYear() {
		return dredgeYear;
	}

	public void setDredgeYear(Integer dredgeYear) {
		this.dredgeYear = dredgeYear;
	}
	
	@ExcelField(title="赠送年限", align=2, sort=5)
	public Integer getGiveYear() {
		return giveYear;
	}

	public void setGiveYear(Integer giveYear) {
		this.giveYear = giveYear;
	}
	
	@NotNull(message="价格不能为空")
	@ExcelField(title="价格", align=2, sort=6)
	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}
	
	@NotNull(message="续费折扣不能为空")
	@ExcelField(title="续费折扣", align=2, sort=7)
	public BigDecimal getRenewDiscount() {
		return renewDiscount;
	}

	public void setRenewDiscount(BigDecimal renewDiscount) {
		this.renewDiscount = renewDiscount;
	}
	
	@Length(min=1, max=4, message="分类（0：公众号,1：小程序，2：混合套餐）长度必须介于 1 和 4 之间")
	@ExcelField(title="分类（0：公众号,1：小程序，2：混合套餐）", align=2, sort=8)
	public Integer getClassify() {
		return classify;
	}

	public void setClassify(Integer classify) {
		this.classify = classify;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="开始时间", align=2, sort=9)
	public Date getStartDate() {
		return startDate;
	}

	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	@ExcelField(title="结束时间", align=2, sort=10)
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	@Length(min=1, max=11, message="排序长度必须介于 1 和 11 之间")
	@ExcelField(title="排序", align=2, sort=11)
	public Integer getSort() {
		return sort;
	}

	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@Length(min=1, max=4, message="状态（0：删除，1：正常）长度必须介于 1 和 4 之间")
	@ExcelField(title="状态（0：删除，1：正常）", align=2, sort=16)
	public Boolean getState() {
		return state;
	}

	public void setState(Boolean state) {
		this.state = state;
	}

	@Override
	public int compareTo(WasSalesPolicy o) {
        int i = this.getSort() - o.getSort(); 
		return i;
	}
	 

}