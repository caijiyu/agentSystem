package com.jeeplus.modules.agentsystem.agency.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jeeplus.common.persistence.DataEntity;
/**
 * 代理商消费综合实体
 * @author SZP
 * @version 2017-09-29
 */
public class WasConsumeSynthesis extends DataEntity<WasConsumeSynthesis> {
	private static final long serialVersionUID = 1L;
	/**
	 * 订单编号
	 */
	private String orderNo;			
	/**
	 * 消费行为
	 */
	private String behavior;		
	/**
	 * 消费金额
	 */
	private BigDecimal payMoney;	
	/**
	 * 类型
	 */
	private Integer type;			
	/**
	 * 消费时间
	 */
	private Date createDate;		
	/**
	 * 操作人
	 */
	private String userId;			
	/**
	 * 登录账户
	 */
	private String loginName;		
	/**
	 * 开始时间
	 */
	private Date startDate;			
	/**
	 * 结束时间
	 */
	private Date endDate;			
	/**
	 * 开票单号
	 */
	private String invoiceNo;		
	/**
	 * 是否开过票
	 */
	private Integer invoice;        
	/**
	 * 公众号消费
	 */
	private BigDecimal publicExpend;
	/**
	 * 小程序消费
	 */
	private BigDecimal minaExpend;  
	/**
	 * 硬件消费
	 */
	private BigDecimal hardwareExpend; 
	/**
	 * vip消费
	 */
	private BigDecimal vipExpend;   
	/**
	 * 备注
	 */
	private String remark;   
	/**
	 * 消费账户
	 */
	private String expendSum;
	
	public String getExpendSum() {
		return expendSum;
	}
	public void setExpendSum(String expendSum) {
		this.expendSum = HtmlUtils.htmlUnescape(expendSum);
	}
	public Integer getInvoice() {
		return invoice;
	}
	public void setInvoice(Integer invoice) {
		this.invoice = invoice;
	}
	public String getInvoiceNo() {
		return invoiceNo;
	}
	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = invoiceNo;
	}
	public WasConsumeSynthesis() {
		super();
	}
	public String getOrderNo() {
		return orderNo;
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = orderNo;
	}
	public String getBehavior() {
		return behavior;
	}
	public void setBehavior(String behavior) {
		this.behavior = HtmlUtils.htmlUnescape(behavior);
	}
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	@Override
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getCreateDate() {
		return createDate;
	}
	@Override
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getUserId() {
		return userId;
	}
	public void setUserId(String userId) {
		this.userId = userId;
	}
	public BigDecimal getPayMoney() {
		return payMoney;
	}
	public void setPayMoney(BigDecimal payMoney) {
		this.payMoney = payMoney;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss")
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = HtmlUtils.htmlUnescape(loginName);
	}
	public BigDecimal getPublicExpend() {
		return publicExpend;
	}
	public void setPublicExpend(BigDecimal publicExpend) {
		this.publicExpend = publicExpend;
	}
	public BigDecimal getMinaExpend() {
		return minaExpend;
	}
	public void setMinaExpend(BigDecimal minaExpend) {
		this.minaExpend = minaExpend;
	}
	public BigDecimal getHardwareExpend() {
		return hardwareExpend;
	}
	public void setHardwareExpend(BigDecimal hardwareExpend) {
		this.hardwareExpend = hardwareExpend;
	}
	public BigDecimal getVipExpend() {
		return vipExpend;
	}
	public void setVipExpend(BigDecimal vipExpend) {
		this.vipExpend = vipExpend;
	}
	public String getRemark() {
		return remark;
	}
	public void setRemark(String remark) {
		this.remark = HtmlUtils.htmlUnescape(remark);
	}
	@Override
	public String toString() {
		return "WasConsumeSynthesis [orderNo=" + orderNo + ", behavior=" + behavior + ", payMoney=" + payMoney
				+ ", type=" + type + ", createDate=" + createDate + ", userId=" + userId + ", loginName=" + loginName
				+ ", startDate=" + startDate + ", endDate=" + endDate + ", invoiceNo=" + invoiceNo + ", invoice="
				+ invoice + ", publicExpend=" + publicExpend + ", minaExpend=" + minaExpend + ", hardwareExpend="
				+ hardwareExpend + ", vipExpend=" + vipExpend + ", remark=" + remark + ", expendSum=" + expendSum + "]";
	}
	
}
