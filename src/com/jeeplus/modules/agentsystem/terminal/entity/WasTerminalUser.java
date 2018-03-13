package com.jeeplus.modules.agentsystem.terminal.entity;

import java.util.Date;
import java.util.List;

import org.springframework.web.util.HtmlUtils;

import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.DataEntity;
/**
 * 
 * @author Hua
 *
 */
public class WasTerminalUser extends DataEntity<WasTerminalUser>{
	private static final long serialVersionUID = 1L;
	private Integer terminalUserId;
	private String parentId;
	private String companyName;
	private String name;
	private String phone;
	private String province;
	private String city;
	private String county;
	private String address;
	private String loginName;
	private String password;
	private String state;
	private String reason;
	private Date beginDate;
	private Date endDate;
	private Boolean agentState;
	private Boolean agentValid;
	
	/**
	 * 上级代理商的登录名
	 */
	private String parentLoginName;
	
	/**
	 * 下级用户列表
	 */
	private List<String> subUserIds = Lists.newArrayList();
	
	/** 终端产品 */
	private List<WasTerminalProduct> terminalProducts = Lists.newArrayList();
	
	public Boolean getAgentValid() {
		return agentValid;
	}
	public void setAgentValid(Boolean agentValid) {
		this.agentValid = agentValid;
	}
	public Boolean getAgentState() {
		return agentState;
	}
	public void setAgentState(Boolean agentState) {
		this.agentState = agentState;
	}
	public Integer getTerminalUserId() {
		return terminalUserId;
	}
	public void setTerminalUserId(Integer terminalUserId) {
		this.terminalUserId = terminalUserId;
	}
	public String getParentId() {		
		return parentId;
	}
	public void setParentId(String parentId) {
		this.parentId = parentId;
	}
	public String getCompanyName() {
		return HtmlUtils.htmlUnescape(companyName);
	}
	public void setCompanyName(String companyName) {
		this.companyName = HtmlUtils.htmlUnescape(companyName);
	}
	public String getName() {
		return HtmlUtils.htmlUnescape(name);
	}
	public void setName(String name) {
		this.name = HtmlUtils.htmlUnescape(name);
	}
	public String getPhone() {
		return HtmlUtils.htmlUnescape(phone);
	}
	public void setPhone(String phone) {
		this.phone = HtmlUtils.htmlUnescape(phone);
	}
	public String getProvince() {
		return province;
	}
	public void setProvince(String province) {
		this.province = province;
	}
	public String getCity() {
		return city;
	}
	public void setCity(String city) {
		this.city = city;
	}
	public String getCounty() {
		return county;
	}
	public void setCounty(String county) {
		this.county = county;
	}
	public String getAddress() {
		return HtmlUtils.htmlUnescape(address);
	}
	public void setAddress(String address) {
		this.address = HtmlUtils.htmlUnescape(address);
	}
	public String getLoginName() {
		return loginName;
	}
	public void setLoginName(String loginName) {
		this.loginName = loginName;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
	public String getReason() {
		return HtmlUtils.htmlUnescape(reason);
	}
	public void setReason(String reason) {
		this.reason = HtmlUtils.htmlUnescape(reason);
	}
	public static long getSerialversionuid() {
		return serialVersionUID;
	}
	
	public WasTerminalUser() {
		super();
		this.state = NORMAL;
	}
	
	public Date getBeginDate() {
		return beginDate;
	}
	public void setBeginDate(Date beginDate) {
		this.beginDate = beginDate;
	}
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	
	public List<WasTerminalProduct> getTerminalProducts() {
		return terminalProducts;
	}
	
	public void setTerminalProducts(List<WasTerminalProduct> terminalProducts) {
		this.terminalProducts = terminalProducts;
	}
	
	public List<String> getSubUserIds() {
		return subUserIds;
	}
	public void setSubUserIds(List<String> subUserIds) {
		this.subUserIds = subUserIds;
	}
	
	public String getParentLoginName() {
		return parentLoginName;
	}
	
	public void setParentLoginName(String parentLoginName) {
		this.parentLoginName = parentLoginName;
	}
	@Override
	public String toString() {
		return "WasTerminalUser [terminalUserId=" + terminalUserId + ", parentId=" + parentId + ", companyName="
				+ companyName + ", name=" + name + ", phone=" + phone + ", province=" + province + ", city=" + city
				+ ", county=" + county + ", address=" + address + ", loginName=" + loginName + ", password=" + password
				+ ", state=" + state + ", reason=" + reason + ", createBy=" + createBy + ", createDate=" + createDate
				+ ", updateBy=" + updateBy + ", updateDate=" + updateDate + "]";
	}    
	/**
	 * 删除标记（0：正常；1：冻结；2：删除；）
	 */
	public static final String NORMAL = "0";
	public static final String FREEZE= "1";
	public static final String DELETE = "2";

}
