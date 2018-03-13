package com.jeeplus.modules.agentsystem.agency.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jeeplus.common.persistence.DataEntity;
/**
 * 充消
 * @author SZP
 * @version 2017-09-29
 */
public class WasExpendPay extends DataEntity<WasExpendPay> {
	private static final long serialVersionUID = 1L;
	/**主键ID*/
	private Integer expendPayId;					
	/**充消单号*/
	private String orderNo;							
	/**代理商ID*/
	private String userId;							
	/**充值登录名*/
	private String loginName;		    			
	/**消费行为；总代开户，总代充值，财务转移*/
	private String behavior;						
	/**充消价格*/
	private BigDecimal payMoney;					
	/**公众号消费*/
	private BigDecimal publicExpend;				
	/**小程序消费*/
	private BigDecimal minaExpend;					
	/**硬件消费*/
	private BigDecimal hardwareExpend;				
	/**VIP消费*/
	private BigDecimal vipExpend;					
	/**类型（3：冲消表）*/
	private Integer type;							
	/**被充值的代理商*/
	private String receivedUserId;					
	/**被充值的代理商公司全称*/
	private String receivedCompanyName;		    	
	/**备注*/
	private String remarks;							
	/**消费时间*/
	private Date createDate;						
	/**操作账户ID*/
	private String createId;						
	/**操作账户登录名*/
	private String createLoginName;						
	/**开票单号*/
	private String invoiceNo;						
	/**是否开过票（0：没有开过票， 1：已经开过票）*/
	private Integer invoice;						
	/**状态（0：删除，1：正常）*/
	private Integer state;							
	/**查询开始时间*/
	private Date beginDate;							
	/**查询结束时间*/
	private Date endDate;							
	public WasExpendPay() {
		super();
	}
	
	public WasExpendPay(String orderNo, String userId, String behavior,
			BigDecimal payMoney, BigDecimal publicExpend, BigDecimal minaExpend, BigDecimal hardwareExpend,
			BigDecimal vipExpend, Integer type, String receivedUserId, String remarks, Date createDate, String createId,
			String invoiceNo, Integer invoice, Integer state) {
		super();
		this.orderNo = orderNo;
		this.userId = userId;
		this.behavior = behavior;
		this.payMoney = payMoney;
		this.publicExpend = publicExpend;
		this.minaExpend = minaExpend;
		this.hardwareExpend = hardwareExpend;
		this.vipExpend = vipExpend;
		this.type = type;
		this.receivedUserId = receivedUserId;
		this.remarks = remarks;
		this.createDate = createDate;
		this.createId = createId;
		this.invoiceNo = invoiceNo;
		this.invoice = invoice;
		this.state = state;
	}

	public String getCreateLoginName() {
		return HtmlUtils.htmlUnescape(createLoginName);
	}

	public void setCreateLoginName(String createLoginName) {
		this.createLoginName = HtmlUtils.htmlUnescape(createLoginName);
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getEndDate() {
		return endDate;
	}

	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}

	public Integer getExpendPayId() {
		return expendPayId;
	}
	public void setExpendPayId(Integer expendPayId) {
		this.expendPayId = expendPayId;
	}
	public String getOrderNo() {
		return HtmlUtils.htmlUnescape(orderNo);
	}
	public void setOrderNo(String orderNo) {
		this.orderNo = HtmlUtils.htmlUnescape(orderNo);
	}
	public String getUserId() {
		return HtmlUtils.htmlUnescape(userId);
	}
	public void setUserId(String userId) {
		this.userId = HtmlUtils.htmlUnescape(userId);
	}
	public String getBehavior() {
		return HtmlUtils.htmlUnescape(behavior);
	}
	public void setBehavior(String behavior) {
		this.behavior = HtmlUtils.htmlUnescape(behavior);
	}
	public BigDecimal getPayMoney() {
		return payMoney;
	}
	public void setPayMoney(BigDecimal payMoney) {
		this.payMoney = payMoney;
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
	public Integer getType() {
		return type;
	}
	public void setType(Integer type) {
		this.type = type;
	}
	public String getReceivedUserId() {
		return HtmlUtils.htmlUnescape(receivedUserId);
	}
	public void setReceivedUserId(String receivedUserId) {
		this.receivedUserId = HtmlUtils.htmlUnescape(receivedUserId);
	}
	@Override
	public String getRemarks() {
		return HtmlUtils.htmlUnescape(remarks);
	}
	@Override
	public void setRemarks(String remarks) {
		this.remarks = HtmlUtils.htmlUnescape(remarks);
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	@Override
	public Date getCreateDate() {
		return createDate;
	}
	@Override
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	public String getCreateId() {
		return HtmlUtils.htmlUnescape(createId);
	}
	public void setCreateId(String createId) {
		this.createId = HtmlUtils.htmlUnescape(createId);
	}
	public String getInvoiceNo() {
		return HtmlUtils.htmlUnescape(invoiceNo);
	}
	public void setInvoiceNo(String invoiceNo) {
		this.invoiceNo = HtmlUtils.htmlUnescape(invoiceNo);
	}
	public Integer getInvoice() {
		return invoice;
	}
	public void setInvoice(Integer invoice) {
		this.invoice = invoice;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	
	public String getLoginName() {
		return HtmlUtils.htmlUnescape(loginName);
	}
	public void setLoginName(String loginName) {
		this.loginName = HtmlUtils.htmlUnescape(loginName);
	}
	public String getReceivedCompanyName() {
		return HtmlUtils.htmlUnescape(receivedCompanyName);
	}
	public void setReceivedCompanyName(String receivedCompanyName) {
		this.receivedCompanyName = HtmlUtils.htmlUnescape(receivedCompanyName);
	}
	
	
}
