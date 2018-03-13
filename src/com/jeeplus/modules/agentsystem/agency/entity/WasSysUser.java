package com.jeeplus.modules.agentsystem.agency.entity;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;

import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.google.common.collect.Lists;
import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.modules.sys.entity.Role;


/**
 * @author admin
 *
 */
public class WasSysUser extends DataEntity<WasSysUser>{
	private static final long serialVersionUID = 1L;
	/**
	 * 归属公司
	 */
	private String company_id;			
	/**
	 * 归属部门
	 */
	private String office_id;			
	/**
	 * 工号
	 */
	private String no;			        
	/**
	 * 登录名
	 */
	private String login_name;			
	/**
	 * 密码
	 */
	private String password;		    
	/**
	 * 公司全称
	 */
	private String companyName;		    
	/**
	 * 直属上级公司ID（默认0：微炫客）
	 */
	private String companyParentId;		
	/**
	 * 隶属上级公司ID（0,1,asdwasd,3）
	 */
	private String companyParentIds;	
	/**
	 * 姓名
	 */
	private String name;			   
	/**
	 * 电话
	 */
	private String phone;			   
	/**
	 * 省
	 */
	private String province;		   
	/**
	 * 市
	 */
	private String city;			
	/**
	 * 县
	 */
	private String county;				
	/**
	 * 地址
	 */
	private String address;				
	/**
	 * 邮箱
	 */
	private String email;				
	/**
	 * QQ号
	 */
	private String qq;					
	/**
	 * 微信号
	 */
	private String wechat;				
	/**
	 * 战区
	 */
	private String theater;				
	/**
	 * 战区负责人
	 */
	private String principal;			
	/**
	 * 套餐折扣（最大1.0)
	 */
	private BigDecimal packageDiscount; 
	/**
	 * 公众号折扣（最大1.0）
	 */
	private BigDecimal publicDiscount;  
	/**
	 * 小程序折扣（最大1.0）
	 */
	private BigDecimal minaDiscount;	
	/**
	 * 代理商等级ID
	 */
	private Integer agentLevelId;		
	/**
	 * 代理商等级名称
	 */
	private String roleName;			
	/**
	 * 客户等级（0：普通客户  1：VIP客户）
	 */
	private Integer customerLevel;		
	/**
	 * 证书
	 */
	private String certificate;			
	/**
	 * 押金
	 */
	private BigDecimal cashPledge;		
	/**
	 * 公众号账户
	 */
	private BigDecimal publicAccount;	
	/**
	 * 小程序账户
	 */
	private BigDecimal minaAccount;		
	/**
	 * 硬件账户
	 */
	private BigDecimal hardwareAccount;	
	/**
	 * vip账户
	 */
	private BigDecimal vipAccount;		
	/**
	 * 公众号账户消耗
	 */
	private BigDecimal publicExpend;	
	/**
	 * 小程序消耗
	 */
	private BigDecimal minaExpend;		
	/**
	 * 硬件消耗
	 */
	private BigDecimal hardwareExpend;	
	/**
	 * VIP消耗
	 */
	private BigDecimal vipExpend;		
	/**
	 * 手机
	 */
	private String mobile;				
	/**
	 * 用户类型
	 */
	private char user_type;				
	/**
	 * 用户头像
	 */
	private String photo;				
	/**
	 * 最后登陆IP
	 */
	private String login_ip;			
	/**
	 * 最后登陆时间
	 */
	private Date login_date;			
	/**
	 * 是否可登录
	 */
	private String login_flag;		
	/**
	 * 创建者
	 */
	private String create_by;			
	/**
	 * 添加时间
	 */
	private Date create_date;			
	/**
	 * 更新者
	 */
	private String update_by;		
	/**
	 * 更新时间
	 */
	private Date update_date;			
	/**
	 * 开始时间
	 */
	private Date startDate;				
	/**
	 * 结束时间
	 */
	private Date endDate;				
	/**
	 * 状态（0：冻结，1：正常，2申请中，3：驳回）
	 */
	private Integer state;				
	/**
	 * 备注
	 */
	private String remarks;				
	/**
	 * 删除标记
	 */
	private char del_flag;				
	/**
	 * 二维码
	 */
	private String qrcode;				
	/**
	 * 拥有角色列表
	 */
	private List<Role> roleList = Lists.newArrayList(); 
	/**
	 * 代理商所属上级名称
	 */
	private String agentLevel;  
	/**
	 * 直属上级
	 */
	private WasSysUser  companyParent;
	
	public WasSysUser() {
		super();
	}


	public WasSysUser(String id,BigDecimal publicAccount, BigDecimal minaAccount, BigDecimal hardwareAccount,
			BigDecimal vipAccount) {
		super();
		this.id=id;
		this.publicAccount = publicAccount;
		this.minaAccount = minaAccount;
		this.hardwareAccount = hardwareAccount;
		this.vipAccount = vipAccount;
	}


	public String getRoleName() {
		return roleName;
	}


	public void setRoleName(String roleName) {
		this.roleName = HtmlUtils.htmlUnescape(roleName);
	}


	

	public WasSysUser(String id) {
		super();
		this.id = id;
	}


	public String getCompany_id() {
		return company_id;
	}


	public void setCompany_id(String company_id) {
		this.company_id = company_id;
	}


	public String getOffice_id() {
		return office_id;
	}


	public void setOffice_id(String office_id) {
		this.office_id = office_id;
	}


	public String getNo() {
		return no;
	}


	public void setNo(String no) {
		this.no = no;
	}


	public String getLogin_name() {
		return login_name;
	}


	public void setLogin_name(String login_name) {
		this.login_name = login_name;
	}


	public String getPassword() {
		return password;
	}


	public void setPassword(String password) {
		this.password = password;
	}


	public String getCompanyName() {
		return HtmlUtils.htmlUnescape(companyName);
	}


	public void setCompanyName(String companyName) {
		this.companyName = HtmlUtils.htmlUnescape(companyName);
	}


	public String getCompanyParentId() {
		return companyParentId;
	}


	public void setCompanyParentId(String companyParentId) {
		this.companyParentId = companyParentId;
	}


	public String getCompanyParentIds() {
		return companyParentIds;
	}


	public void setCompanyParentIds(String companyParentIds) {
		this.companyParentIds = companyParentIds;
	}


	public String getName() {
		return name;
	}


	public void setName(String name) {
		this.name = HtmlUtils.htmlUnescape(name);
	}


	public String getPhone() {
		return phone;
	}


	public void setPhone(String phone) {
		this.phone = phone;
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
		return address;
	}


	public void setAddress(String address) {
		this.address = HtmlUtils.htmlUnescape(address);
	}


	public String getEmail() {
		return email;
	}


	public void setEmail(String email) {
		this.email = email;
	}


	public String getQq() {
		return qq;
	}


	public void setQq(String qq) {
		this.qq = qq;
	}


	public String getWechat() {
		return wechat;
	}


	public void setWechat(String wechat) {
		this.wechat = wechat;
	}


	public String getTheater() {
		return theater;
	}


	public void setTheater(String theater) {
		this.theater = theater;
	}


	public String getPrincipal() {
		return principal;
	}


	public void setPrincipal(String principal) {
		this.principal = principal;
	}


	public BigDecimal getPackageDiscount() {
		return packageDiscount;
	}


	public void setPackageDiscount(BigDecimal packageDiscount) {
		this.packageDiscount = packageDiscount;
	}


	public BigDecimal getPublicDiscount() {
		return publicDiscount;
	}


	public void setPublicDiscount(BigDecimal publicDiscount) {
		this.publicDiscount = publicDiscount;
	}


	public BigDecimal getMinaDiscount() {
		return minaDiscount;
	}


	public void setMinaDiscount(BigDecimal minaDiscount) {
		this.minaDiscount = minaDiscount;
	}


	public Integer getAgentLevelId() {
		return agentLevelId;
	}


	public void setAgentLevelId(Integer agentLevelId) {
		this.agentLevelId = agentLevelId;
	}


	public Integer getCustomerLevel() {
		return customerLevel;
	}


	public void setCustomerLevel(Integer customerLevel) {
		this.customerLevel = customerLevel;
	}


	public String getCertificate() {
		return certificate;
	}


	public void setCertificate(String certificate) {
		this.certificate = certificate;
	}


	public BigDecimal getCashPledge() {
		return cashPledge;
	}


	public void setCashPledge(BigDecimal cashPledge) {
		this.cashPledge = cashPledge;
	}


	public BigDecimal getPublicAccount() {
		return publicAccount;
	}


	public void setPublicAccount(BigDecimal publicAccount) {
		this.publicAccount = publicAccount;
	}


	public BigDecimal getMinaAccount() {
		return minaAccount;
	}


	public void setMinaAccount(BigDecimal minaAccount) {
		this.minaAccount = minaAccount;
	}


	public BigDecimal getHardwareAccount() {
		return hardwareAccount;
	}


	public void setHardwareAccount(BigDecimal hardwareAccount) {
		this.hardwareAccount = hardwareAccount;
	}


	public BigDecimal getVipAccount() {
		return vipAccount;
	}


	public void setVipAccount(BigDecimal vipAccount) {
		this.vipAccount = vipAccount;
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


	public String getMobile() {
		return mobile;
	}


	public void setMobile(String mobile) {
		this.mobile = mobile;
	}


	public char getUser_type() {
		return user_type;
	}


	public void setUser_type(char user_type) {
		this.user_type = user_type;
	}


	public String getPhoto() {
		return photo;
	}


	public void setPhoto(String photo) {
		this.photo = photo;
	}


	public String getLogin_ip() {
		return login_ip;
	}


	public void setLogin_ip(String login_ip) {
		this.login_ip = login_ip;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getLogin_date() {
		return login_date;
	}


	public void setLogin_date(Date login_date) {
		this.login_date = login_date;
	}


	public String getLogin_flag() {
		return login_flag;
	}


	public void setLogin_flag(String login_flag) {
		this.login_flag = login_flag;
	}


	public String getCreate_by() {
		return create_by;
	}


	public void setCreate_by(String create_by) {
		this.create_by = create_by;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getCreate_date() {
		return create_date;
	}


	public void setCreate_date(Date create_date) {
		this.create_date = create_date;
	}


	public String getUpdate_by() {
		return update_by;
	}


	public void setUpdate_by(String update_by) {
		this.update_by = update_by;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getUpdate_date() {
		return update_date;
	}


	public void setUpdate_date(Date update_date) {
		this.update_date = update_date;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getStartDate() {
		return startDate;
	}


	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}

	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getEndDate() {
		return endDate;
	}


	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}


	public Integer getState() {
		return state;
	}


	public void setState(Integer state) {
		this.state = state;
	}

	@Override
	public String getRemarks() {
		return remarks;
	}

	@Override
	public void setRemarks(String remarks) {
		this.remarks = HtmlUtils.htmlUnescape(remarks);
	}


	public char getDel_flag() {
		return del_flag;
	}


	public void setDel_flag(char del_flag) {
		this.del_flag = del_flag;
	}


	public String getQrcode() {
		return qrcode;
	}


	public void setQrcode(String qrcode) {
		this.qrcode = qrcode;
	}


	public List<Role> getRoleList() {
		return roleList;
	}


	public void setRoleList(List<Role> roleList) {
		this.roleList = roleList;
	}


	public String getAgentLevel() {
		return agentLevel;
	}


	public void setAgentLevel(String agentLevel) {
		this.agentLevel = HtmlUtils.htmlUnescape(agentLevel);
	}


	public WasSysUser getCompanyParent() {
		return companyParent;
	}


	public void setCompanyParent(WasSysUser companyParent) {
		this.companyParent = companyParent;
	}

	
}
