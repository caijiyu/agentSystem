package com.jeeplus.modules.agentsystem.agency.entity;

import java.math.BigDecimal;
import java.util.Date;

import org.springframework.web.util.HtmlUtils;

import com.jeeplus.common.persistence.DataEntity;
/**
 * 代理商充值记录
 * @author SZP
 * @version 2017-09-27
 */

public class WasRechargeHistory extends DataEntity<WasRechargeHistory> {
	private static final long serialVersionUID = 1L;
	/**主键ID*/
	private Integer rechargeId;
	/**充值单号*/
	private String rechargeNo;                  
	/**被充值的代理商*/
	private String receivedUserId;              
	/**公众号账户充值*/
	private BigDecimal publicRecharge;              
	/**小程序充值*/
	private BigDecimal minaRecharge;                
	/**硬件充值*/
	private BigDecimal hardwareRecharge;            
	/**VIP充值*/
	private BigDecimal vipRecharge;                 
	/**押金充值*/
	private BigDecimal cashRecharge;                
	/**充值总金额*/
	private BigDecimal amount;                
	/**充值去向*/
	private String rechargeDirection;           
	/**备注*/
	private String remarks;                     
	/**充消ID*/
	private Integer expendPayId;                
	/**方针（软件）购买ID*/
	private Integer policyPurchaseId;           
	/**充值时间*/
	private Date createDate;                    
	/**操作账户*/
	private String operateBy;                   
	/**登录名*/
	private String loginName;					
	/**状态（0：删除，1：正常）*/
	private Integer state;                      
	/**开始时间*/
	private Date startDate;						
	/**结束时间*/
	private Date endDate;						
	public WasRechargeHistory() {
		super();
	}
	public WasRechargeHistory(String id) {
		super(id);
	}
	
	public WasRechargeHistory(String rechargeNo, String receivedUserId, BigDecimal publicRecharge,
			BigDecimal minaRecharge, BigDecimal hardwareRecharge, BigDecimal vipRecharge, BigDecimal cashRecharge,
			 String remarks, Integer expendPayId, Integer policyPurchaseId,
			Date createDate, String operateBy, Integer state) {
		super();
		this.rechargeNo = rechargeNo;
		this.receivedUserId = receivedUserId;
		this.publicRecharge = publicRecharge;
		this.minaRecharge = minaRecharge;
		this.hardwareRecharge = hardwareRecharge;
		this.vipRecharge = vipRecharge;
		this.cashRecharge = cashRecharge;
		this.remarks = remarks;
		this.expendPayId = expendPayId;
		this.policyPurchaseId = policyPurchaseId;
		this.createDate = createDate;
		this.operateBy = operateBy;
		this.state = state;
	}
	
	public String getRechargeDirection() {
		return HtmlUtils.htmlUnescape(rechargeDirection);
	}
	public void setRechargeDirection(String rechargeDirection) {
		this.rechargeDirection = HtmlUtils.htmlUnescape(rechargeDirection);
	}
	public BigDecimal getAmount() {
		return amount;
	}
	public void setAmount(BigDecimal amount) {
		this.amount = amount;
	}
	public String getLoginName() {
		return HtmlUtils.htmlUnescape(loginName);
	}
	public void setLoginName(String loginName) {
		this.loginName = HtmlUtils.htmlUnescape(loginName);
	}
	public Integer getRechargeId() {
		return rechargeId;
	}
	public void setRechargeId(Integer rechargeId) {
		this.rechargeId = rechargeId;
	}
	
	public String getRechargeNo() {
		return rechargeNo;
	}
	public void setRechargeNo(String rechargeNo) {
		this.rechargeNo = HtmlUtils.htmlUnescape(rechargeNo);
	}
	
	public String getReceivedUserId() {
		return HtmlUtils.htmlUnescape(receivedUserId);
	}
	public void setReceivedUserId(String receivedUserId) {
		this.receivedUserId = HtmlUtils.htmlUnescape(receivedUserId);
	}
	
	public BigDecimal getPublicRecharge() {
		return publicRecharge;
	}
	public void setPublicRecharge(BigDecimal publicRecharge) {
		this.publicRecharge = publicRecharge;
	}
	
	public BigDecimal getMinaRecharge() {
		return minaRecharge;
	}
	public void setMinaRecharge(BigDecimal minaRecharge) {
		this.minaRecharge = minaRecharge;
	}
	
	public BigDecimal getHardwareRecharge() {
		return hardwareRecharge;
	}
	public void setHardwareRecharge(BigDecimal hardwareRecharge) {
		this.hardwareRecharge = hardwareRecharge;
	}
	public BigDecimal getVipRecharge() {
		return vipRecharge;
	}
	public void setVipRecharge(BigDecimal vipRecharge) {
		this.vipRecharge = vipRecharge;
	}
	
	public BigDecimal getCashRecharge() {
		return cashRecharge;
	}
	public void setCashRecharge(BigDecimal cashRecharge) {
		this.cashRecharge = cashRecharge;
	}
	@Override
	public String getRemarks() {
		return HtmlUtils.htmlUnescape(remarks);
	}
	@Override
	public void setRemarks(String remarks) {
		this.remarks = HtmlUtils.htmlUnescape(remarks);
	}
	
	public Integer getExpendPayId() {
		return expendPayId;
	}
	public void setExpendPayId(Integer expendPayId) {
		this.expendPayId = expendPayId;
	}
	
	public Integer getPolicyPurchaseId() {
		return policyPurchaseId;
	}
	public void setPolicyPurchaseId(Integer policyPurchaseId) {
		this.policyPurchaseId = policyPurchaseId;
	}
	@Override
	public Date getCreateDate() {
		return createDate;
	}
	@Override
	public void setCreateDate(Date createDate) {
		this.createDate = createDate;
	}
	
	public String getOperateBy() {
		return HtmlUtils.htmlUnescape(operateBy);
	}
	public void setOperateBy(String operateBy) {
		this.operateBy = HtmlUtils.htmlUnescape(operateBy);
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	@Override
	public String toString() {
		return "WasRechargeHistory [rechargeId=" + rechargeId + ", rechargeNo=" + rechargeNo + ", receivedUserId="
				+ receivedUserId + ", publicRecharge=" + publicRecharge + ", minaRecharge=" + minaRecharge
				+ ", hardwareRecharge=" + hardwareRecharge + ", vipRecharge=" + vipRecharge + ", cashRecharge="
				+ cashRecharge + ", amount=" + amount + ", rechargeDirection=" + rechargeDirection + ", remarks="
				+ remarks + ", expendPayId=" + expendPayId + ", policyPurchaseId=" + policyPurchaseId + ", createDate="
				+ createDate + ", operateBy=" + operateBy + ", loginName=" + loginName + ", state=" + state
				+ ", startDate=" + startDate + ", endDate=" + endDate + "]";
	}
	
	
}
