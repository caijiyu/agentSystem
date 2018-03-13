package com.jeeplus.modules.agentsystem.agency.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.DataEntity;
/**
 * （软件）方针购买
 * @author SZP
 * @version 2017-09-29
 */
public class WasPolicyPurchase extends DataEntity<WasPolicyPurchase> {
	private static final long serialVersionUID = 1L;
	/**主键ID*/
	private Integer policyPurchaseId;				
	/**方针购买单号*/
	private String number;							
	/**终端用户ID*/
	private Integer terminalUserId;					
	/**方针ID*/
	private Integer salesPolicyId;					
	/**套餐名*/
	private String comboName;						
	/**购买数量*/
	private Integer policyNumber;					
	/**消费行为*/
	private String behavior;						
	/**总价格*/
	private BigDecimal totalMoney;					
	/**支付价格*/
	private BigDecimal payMoney;					
	/**结束时间*/
	private Date endDate;							
	/**操作账号*/
	private String userId;							
	/**登录账户*/
	private String loginName;						
	/**公众号消费*/
	private BigDecimal publicExpend;				
	/**小程序消费*/
	private BigDecimal minaExpend;					
	/**硬件消费*/
	private BigDecimal hardwareExpend;				
	/**VIP消费*/
	private BigDecimal vipExpend;					
	/**类型（1：方针购买表）*/
	private Integer type;							
	/**备注*/
	private String remarks;							
	/**开票单号*/
	private String invoiceNo;						
	/**是否开过票（0：没有开过票， 1：已经开过票）*/
	private Integer invoice;						
	/**状态（0：删除，1：正常）*/
	private Integer state;							
	/**查询开始时间*/
	private Date beginDate;							
	/**查询结束时间*/
	private Date overDate;
	/**公司名称*/
	private String companyName;
	private String[] info;
	/**分类（0：公众号,1：小程序，2：混合套餐）*/
	private Integer classify;		

	/**
	 * 下级用户列表
	 */
	private List<String> subUserIds = Lists.newArrayList();
	
	
	public List<String> getSubUserIds() {
		return subUserIds;
	}

	public void setSubUserIds(List<String> subUserIds) {
		this.subUserIds = subUserIds;
	}

	public String[] getInfo() {
		return info;
	}

	public void setInfo(String[] info) {
		this.info = info;
	}

	public String getCompanyName() {
		return HtmlUtils.htmlUnescape(companyName);
	}

	public void setCompanyName(String companyName) {
		this.companyName = HtmlUtils.htmlUnescape(companyName);
	}

	public WasPolicyPurchase() {
		super();
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getBeginDate() {
		return beginDate;
	}

	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getOverDate() {
		return overDate;
	}

	public void setOverDate(Date overDate) {
		this.overDate = overDate;
	}

	public String getLoginName() {
		return HtmlUtils.htmlUnescape(loginName);
	}

	public void setLoginName(String loginName) {
		this.loginName = HtmlUtils.htmlUnescape(loginName);
	}

	public Integer getPolicyPurchaseId() {
		return policyPurchaseId;
	}
	public void setPolicyPurchaseId(Integer policyPurchaseId) {
		this.policyPurchaseId = policyPurchaseId;
	}
	public String getNumber() {
		return HtmlUtils.htmlUnescape(number);
	}
	public void setNumber(String number) {
		this.number = HtmlUtils.htmlUnescape(number);
	}
	public Integer getTerminalUserId() {
		return terminalUserId;
	}
	public void setTerminalUserId(Integer terminalUserId) {
		this.terminalUserId = terminalUserId;
	}
	public Integer getSalesPolicyId() {
		return salesPolicyId;
	}
	public void setSalesPolicyId(Integer salesPolicyId) {
		this.salesPolicyId = salesPolicyId;
	}
	public Integer getPolicyNumber() {
		return policyNumber;
	}
	public void setPolicyNumber(Integer policyNumber) {
		this.policyNumber = policyNumber;
	}
	public String getBehavior() {
		return HtmlUtils.htmlUnescape(behavior);
	}
	public void setBehavior(String behavior) {
		this.behavior = HtmlUtils.htmlUnescape(behavior);
	}
	public BigDecimal getTotalMoney() {
		return totalMoney;
	}
	public void setTotalMoney(BigDecimal totalMoney) {
		this.totalMoney = totalMoney;
	}
	public BigDecimal getPayMoney() {
		return payMoney;
	}
	public void setPayMoney(BigDecimal payMoney) {
		this.payMoney = payMoney;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public String getUserId() {
		return HtmlUtils.htmlUnescape(userId);
	}
	public void setUserId(String userId) {
		this.userId = HtmlUtils.htmlUnescape(userId);
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
	@Override
	public String getRemarks() {
		return HtmlUtils.htmlUnescape(remarks);
	}
	@Override
	public void setRemarks(String remarks) {
		this.remarks = HtmlUtils.htmlUnescape(remarks);
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
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public String getComboName() {
		return HtmlUtils.htmlUnescape(comboName);
	}
	public void setComboName(String comboName) {
		this.comboName = HtmlUtils.htmlUnescape(comboName);
	}
	public Integer getClassify() {
		return classify;
	}

	public void setClassify(Integer classify) {
		this.classify = classify;
	}


	
	@Override
	public String toString() {
		return "WasPolicyPurchase [policyPurchaseId=" + policyPurchaseId + ", number=" + number + ", terminalUserId="
				+ terminalUserId + ", salesPolicyId=" + salesPolicyId + ", comboName=" + comboName + ", policyNumber="
				+ policyNumber + ", behavior=" + behavior + ", totalMoney=" + totalMoney + ", payMoney=" + payMoney
				+ ", endDate=" + endDate + ", userId=" + userId + ", loginName=" + loginName + ", publicExpend="
				+ publicExpend + ", minaExpend=" + minaExpend + ", hardwareExpend=" + hardwareExpend + ", vipExpend="
				+ vipExpend + ", type=" + type + ", remarks=" + remarks + ", invoiceNo=" + invoiceNo + ", invoice="
				+ invoice + ", state=" + state + ", beginDate=" + beginDate + ", overDate=" + overDate + "]";
	}

	/**
	 * 构造器
	 */
	public WasPolicyPurchase(String number, Integer terminalUserId, Integer salesPolicyId,
			Integer policyNumber, String behavior, BigDecimal totalMoney, BigDecimal payMoney, Date createDate,Date endDate,
			String userId,  BigDecimal publicExpend, BigDecimal minaExpend, BigDecimal hardwareExpend,
			BigDecimal vipExpend, Integer type, String remarks, Integer state) {
		this.number = number;
		this.terminalUserId = terminalUserId;
		this.salesPolicyId = salesPolicyId;
		this.policyNumber = policyNumber;
		this.behavior = behavior;
		this.totalMoney = totalMoney;
		this.payMoney = payMoney;
		this.createDate = createDate;
		this.endDate = endDate;
		this.userId = userId;
		this.publicExpend = publicExpend;
		this.minaExpend = minaExpend;
		this.hardwareExpend = hardwareExpend;
		this.vipExpend = vipExpend;
		this.type = type;
		this.remarks = remarks;
		this.state = state;
	}



	
	
	
}
