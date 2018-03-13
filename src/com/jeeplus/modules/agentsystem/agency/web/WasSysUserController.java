package com.jeeplus.modules.agentsystem.agency.web;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasExpendPay;
import com.jeeplus.modules.agentsystem.agency.entity.WasRechargeHistory;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
import com.jeeplus.modules.agentsystem.agency.service.WasAgentApplyService;
import com.jeeplus.modules.agentsystem.agency.service.WasExpendPayService;
import com.jeeplus.modules.agentsystem.agency.service.WasRechargeHistoryService;
import com.jeeplus.modules.agentsystem.agency.service.WasSysUserService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentLevelService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasUserService;
import com.jeeplus.modules.agentsystem.utils.MoneyOperation;
import com.jeeplus.modules.agentsystem.utils.OrderNumberUtils;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;
/**
 * 
 * @author admin
 *
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/SysUser")
public class WasSysUserController extends BaseController{

	@Autowired
	private WasSysUserService wasSysUserService;
	@Autowired
	private WasRechargeHistoryService rechargeHistoryService;
	@Autowired
	private WasExpendPayService expendPayService;
	@Autowired
	private WasAgentApplyService wasAgentApplyService;
	@Autowired
	private WasAgentLevelService wasAgentLevelService;
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	@Autowired
	private WasUserService wasUserService;
	/**
	 * 代理商列表页面
	 */
	@RequiresPermissions("agency:wasSysUser:list")
	@RequestMapping(value = {"list",""})
	public String findAgentlist( WasSysUser sysUser,HttpServletRequest request, HttpServletResponse response, Model model) {
		model.addAttribute("sysUser",sysUser );
		model.addAttribute("companyName",sysUser.getCompanyName());
		sysUser.setCompanyName(StringChangeUtils.specialStr(sysUser.getCompanyName()));
		Principal principal = UserUtils.getPrincipal();
		String adminId = "1";
		WasSysUser wasSysUser=wasUserService.get(principal.getId());
		String sign = "代理商";
		if(sign.equals(wasSysUser.getRoleList().get(0).getRoleType())){
			// 角色为代理商
			sysUser.setId(principal.toString());
		}else{
			sysUser.setId(adminId);
		}
		Page<WasSysUser> page = wasSysUserService.findPage(new Page<WasSysUser>(request, response), sysUser); 
		Integer pageSize = page.getList().size();
		model.addAttribute("record",pageSize);
		model.addAttribute("page",page );
		return "modules/agentsystem/agency/wasAgentList";
	}
	
	/**
	 * 代理商记录
	 */
	@RequiresPermissions("agentSystem:wasAgentRecord:list")
	@RequestMapping(value = {"recordList", ""})
	public String recordList(WasSysUser sysUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		String adminId = "1";
		WasSysUser wasSysUser=wasUserService.get(principal.getId());
		String sign = "代理商";
		if(sign.equals(wasSysUser.getRoleList().get(0).getRoleType())){
			// 角色为代理商
			sysUser.setId(principal.toString());
		}else{
			sysUser.setId(adminId);
		}
		model.addAttribute("companyName",sysUser.getCompanyName());
		sysUser.setCompanyName(StringChangeUtils.specialStr(sysUser.getCompanyName()));
		Page<WasSysUser> page = wasSysUserService.findPage(new Page<WasSysUser>(request, response), sysUser); 
		model.addAttribute("page",page );
		model.addAttribute("sysUser",sysUser );
		return "modules/agentsystem/agency/wasAgentRecord";
	}
	
	/**
	 * 代理商首页入口
	 */
	@RequiresPermissions("agentSystem:wasAgentHomePage:entrance")
	@RequestMapping(value = "homeEntrance")
	public String homeEntrance(WasSysUser sysUser, HttpServletRequest request, HttpServletResponse response, Model model) {
		Principal principal = UserUtils.getPrincipal();
		String id = principal.toString();
		model.addAttribute("id", id);
		return "modules/agentsystem/agency/wasAgentHomePage";
	}
	
	/**
	 * 代理商首页页面展示
	 */
	@ResponseBody
	@RequestMapping(value = "homePage")
	public WasSysUser homePage(WasSysUser sysUser, HttpServletRequest request, HttpServletResponse response) {
		sysUser = wasSysUserService.get(sysUser);
		return sysUser;
	}
	
	/**
	 * 查询是不是微炫客的代理商
	 */
	@RequestMapping(value ="lookUp")
	@ResponseBody
	public boolean deleteVideoId(WasSysUser sysUser, HttpServletRequest request) {
		boolean result;
		sysUser.setCompanyName(request.getParameter("agentName"));
		List<WasSysUser> isSuccess = wasSysUserService.agentLookUp(sysUser);		
		if(null == isSuccess || isSuccess.size() ==0 ){
			result = false;
		}else{
			result = true;
		}
		return result;
	}
	
	/**
	 * 查询页面 跳转到用户登录
	 */
	@RequestMapping(value ="lookUpLogin")
	public String loginJump(HttpServletRequest request,HttpServletResponse response){
		return "modules/sys/sysLoginS";
	}
	
	/**
	 * 代理商详细信息
	 */
	@RequiresPermissions("agency:wasSysUser:view")
	@RequestMapping(value = {"get"})
	public String get( WasSysUser sysuser, HttpServletRequest request,HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		BigDecimal multiplicand = new BigDecimal(10);
		BigDecimal packageDiscount = agent.getPackageDiscount();
		agent.setPackageDiscount((packageDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal  publicDiscount =  agent.getPublicDiscount();
		agent.setPublicDiscount((publicDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal minaDiscount = agent.getMinaDiscount();
		agent.setMinaDiscount((minaDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		model.addAttribute("agent",agent);
		return "modules/agentsystem/agency/wasAgentDetailInfo";
	}
	
	/*
	 * 编辑代理商
	 */
	@RequiresPermissions("agency:wasSysUser:edit")
	@RequestMapping(value = {"edit"})
	public String edit( WasSysUser sysuser, HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		BigDecimal multiplicand = new BigDecimal(10);
		BigDecimal packageDiscount = agent.getPackageDiscount();
		agent.setPackageDiscount((packageDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal  publicDiscount =  agent.getPublicDiscount();
		agent.setPublicDiscount((publicDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal minaDiscount = agent.getMinaDiscount();
		agent.setMinaDiscount((minaDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		model.addAttribute("agent",agent);
		//拿到当前代理商的直属上级
		WasSysUser directAgent= wasSysUserService.getDirectAgent(agent.getCompanyParentId());
		model.addAttribute("directAgent",directAgent);
		//控制总代的最低折扣
		List<WasSysUser> allLowerAgents = new ArrayList<WasSysUser>();
		WasSysUser newSysUser= new WasSysUser();
		newSysUser.setId(sysuser.getId());
		if(directAgent.getId().equals("1")) {
			allLowerAgents =  wasSysUserService.findList(newSysUser);
		}
		BigDecimal minPackageDiscount = new BigDecimal("1");
		BigDecimal minPublicDiscount = new BigDecimal("1");
		BigDecimal minMinaDiscount = new BigDecimal("1");
		if(allLowerAgents.size()>0) {
			minPackageDiscount = allLowerAgents.get(0).getPackageDiscount();
			minPublicDiscount = allLowerAgents.get(0).getPublicDiscount();
			minMinaDiscount = allLowerAgents.get(0).getMinaDiscount();
			for(int i=1;i<allLowerAgents.size();i++) {
				if(minPackageDiscount.compareTo(allLowerAgents.get(i).getPackageDiscount())==1){
					minPackageDiscount = allLowerAgents.get(i).getPackageDiscount();
				}
				if(minPublicDiscount.compareTo(allLowerAgents.get(i).getPublicDiscount())==1){
					minPublicDiscount = allLowerAgents.get(i).getPublicDiscount();
				}
				if(minMinaDiscount.compareTo(allLowerAgents.get(i).getMinaDiscount())==1){
					minPublicDiscount = allLowerAgents.get(i).getMinaDiscount();
				}
			}
		}
		BigDecimal dec = new BigDecimal("10");
		model.addAttribute("minPackageDiscount",minPackageDiscount.multiply(dec));
		model.addAttribute("minPublicDiscount",minPublicDiscount.multiply(dec));
		model.addAttribute("minMinaDiscount",minMinaDiscount.multiply(dec));
		//当前代理商的销售方针，等级
		WasAgentLevel currentAgentLevel = wasAgentLevelService.getEnity(agent.getAgentLevelId());
		model.addAttribute("currentAgentLevel",currentAgentLevel);
		
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal(); 
		WasSysUser sysUser=wasAgentApplyService.get(principal.getId());
		
		List<WasAgentLevel> allWasAgentLevel=wasAgentApplyService.getAllAgentLevel();
		//查找所有的总代
		//List<WasSysUser> agentUser=wasAgentApplyService.selectAllSuperAgent();
		model.addAttribute("allWasAgentLevel", allWasAgentLevel);
		//model.addAttribute("agentUser", agentUser);
		model.addAttribute("sysUser", sysUser);
		
		WasSysUser wasSysUser=wasUserService.get(principal.getId());
		String sign = "代理商";
		if(sign.equals(wasSysUser.getRoleList().get(0).getRoleType())){
			// 角色为代理商
			return "modules/agentsystem/agency/wasGeneralEditAgent";
		}else{
			List<WasSysUser> agentUser=wasAgentApplyService.selectAllSuperAgent();
			model.addAttribute("agentUser", agentUser);
			return "modules/agentsystem/agency/wasFinanceEditAgent";
		}
	}
	/**
	 * 修改代理商状态
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agency:wasSysUser:updateState")
	@ResponseBody
	@RequestMapping(value = {"updateState"})
	public Integer update( WasSysUser sysuser,String menuId, HttpServletResponse response, Model model) {
		WasSysUser user = wasSysUserService.get(sysuser.getId());
		//state为0时冻结，为1时正常
		Integer freeze = 0;
		Integer unfreeze = 1;
		if(user.getState() == freeze) {
			user.setState(unfreeze);
		}else if(user.getState() == unfreeze){
			user.setState(freeze);
		}
		user.setRemarks(sysuser.getRemarks());
		Date date= new Date();
		Principal principal = UserUtils.getPrincipal();
		user.setUpdate_by(principal.toString());
		user.setUpdate_date(date);
		Integer result= wasSysUserService.update(user);
		wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,date,principal.getId(),"用户"+principal.getLoginName()+"编辑了代理商"+user.getCompanyName()+"状态"));
		return  result;
	}
	/*
	 * 代理商续期
	 */
	@RequiresPermissions("agency:wasSysUser:renew")
	@RequestMapping(value = {"getAgent"})
	public String getAgent( WasSysUser sysuser, HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		BigDecimal multiplicand = new BigDecimal(10);
		BigDecimal packageDiscount = agent.getPackageDiscount();
		agent.setPackageDiscount((packageDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal  publicDiscount =  agent.getPublicDiscount();
		agent.setPublicDiscount((publicDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal minaDiscount = agent.getMinaDiscount();
		agent.setMinaDiscount((minaDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		model.addAttribute("agent",agent);
		return "modules/agentsystem/agency/wasRenewAngent" ;
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateTime"})
	public Integer updateTime( WasSysUser sysuser,String menuId, HttpServletResponse response, Model model) throws ParseException {
		Date date= new Date();
		Principal principal = UserUtils.getPrincipal();
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String strDate = sdf.format(sysuser.getEndDate()).substring(0,11)+ "23:59:59";
		sysuser.setEndDate(sdf.parse(strDate));
		sysuser.setUpdate_by(principal.toString());
		sysuser.setUpdate_date(date);
		Integer result = wasSysUserService.updateTime(sysuser);
		wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,date,principal.getId(),"用户代理商"+principal.getLoginName()+"编辑了"+sysuser.getLogin_name()+"的续签时间"));
		return result ;
	}
	/**
	 * 代理商充值
	 */
	@RequiresPermissions("agency:wasSysUser:recharge")
	@RequestMapping(value = {"getAgentRecharge"})
	public String getAgentRecharge( WasSysUser sysuser, HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		BigDecimal multiplicand = new BigDecimal(10);
		BigDecimal packageDiscount = agent.getPackageDiscount();
		agent.setPackageDiscount((packageDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal  publicDiscount =  agent.getPublicDiscount();
		agent.setPublicDiscount((publicDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal minaDiscount = agent.getMinaDiscount();
		agent.setMinaDiscount((minaDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		
		Principal principal = UserUtils.getPrincipal();
		WasSysUser genAgent = wasSysUserService.get(principal.toString());
		model.addAttribute("agent",agent);
		model.addAttribute("genAgent",genAgent);
		
		WasSysUser wasSysUser=wasUserService.get(principal.getId());
		String sign = "代理商";
		if(sign.equals(wasSysUser.getRoleList().get(0).getRoleType())){
			// 角色为代理商
			return "modules/agentsystem/agency/wasGeneralRecharge";
		}else{
			return "modules/agentsystem/agency/wasFinanceRecharge";
		}
	
	}
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateAccount"})
	public Integer updateAccount( WasSysUser sysuser,BigDecimal price,String sign,String remarks, HttpServletResponse response, Model model) throws ParseException {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		Principal principal = UserUtils.getPrincipal();
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		rechargeHistory.setOperateBy(principal.toString());
		Date date = new Date();
		BigDecimal decimal = new BigDecimal("0");
		//充值单号=R+时间戳(13位)
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(sysuser.getId());
		rechargeHistory.setRemarks(remarks);
		rechargeHistory.setCreateDate(date);
		//标识充值方式
		String cashPledgeName = "cashPledge";
		String hardwareName = "hardwareAccount";
		String publicName = "publicAccount";
		String minaName = "minaAccount";
		String vipName = "vipAccount";
		String operation ="充值";
		String  str = StringChangeUtils.OPERATION_SUCCESS;
		Integer result;
		String isSuccess = null;
		if(sign.equals(cashPledgeName)) {
			BigDecimal cashPledge = agent.getCashPledge().add(price);
			agent.setCashPledge(cashPledge);
			isSuccess = MoneyOperation.getInstance().moneyOperation(price,decimal,decimal,decimal,decimal,sysuser.getId(), operation);
			rechargeHistory.setCashRecharge(price);
		}else {
			rechargeHistory.setCashRecharge(decimal);
		}
		if(sign.equals(hardwareName)) {
			BigDecimal hardwareAccount = agent.getHardwareAccount().add(price);	
			agent.setHardwareAccount(hardwareAccount);
			isSuccess = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,price,decimal,sysuser.getId(), operation);
			rechargeHistory.setHardwareRecharge(price);
		}else {
			rechargeHistory.setHardwareRecharge(decimal);
		}
		if(sign.equals(publicName) ) {
			BigDecimal publicAccount = agent.getPublicAccount().add(price);		
			agent.setPublicAccount(publicAccount);
			isSuccess = MoneyOperation.getInstance().moneyOperation(decimal,price,decimal,decimal,decimal,sysuser.getId(), operation);
			rechargeHistory.setPublicRecharge(price);
		}else {
			rechargeHistory.setPublicRecharge(decimal);
		}
		if(sign.equals(minaName)) {
			BigDecimal minaAccount = agent.getMinaAccount().add(price);	
			agent.setMinaAccount(minaAccount);
			isSuccess = MoneyOperation.getInstance().moneyOperation(decimal,decimal,price,decimal,decimal,sysuser.getId(), operation);
			rechargeHistory.setMinaRecharge(price);
		}else {
			rechargeHistory.setMinaRecharge(decimal);
		}
		if(sign.equals(vipName)) {
			BigDecimal vipAccount = agent.getVipAccount().add(price);		
			agent.setVipAccount(vipAccount);
			isSuccess = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,decimal,price,sysuser.getId(), operation);
			rechargeHistory.setVipRecharge(price);
		}else {
			rechargeHistory.setVipRecharge(decimal);
		}
		agent.setUpdate_by(principal.toString());
		agent.setUpdate_date(date);
		//更新代理商记录
		 
		//插入充值记录
		rechargeHistoryService.insert(rechargeHistory);
		if(isSuccess.equals(str)) {
			result = 1;
		}else {
			result = 0;
		}
		return result ;
	}
	
	/**
	 * 总代给代理商充值押金
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateCashPledgeAccount"})
	public Integer updateCashPledge( WasSysUser sysuser,HttpServletResponse response, Model model) throws ParseException {
		BigDecimal hardwareMoney = sysuser.getHardwareAccount();
		BigDecimal publicMoney = sysuser.getPublicAccount();
		BigDecimal minaMoney = sysuser.getMinaAccount();
		BigDecimal vipMoney = sysuser.getVipAccount();
		BigDecimal totalMoney = hardwareMoney.add(publicMoney).add(minaMoney).add(vipMoney);
		String operationA ="充值";
		String operationB ="消费";
		String str =StringChangeUtils.OPERATION_SUCCESS;
		Integer result;
		String isSuccessA = null;
		String isSuccessB = null;
		//被充值代理商secAgent
		WasSysUser secAgent  = wasSysUserService.get(sysuser.getId());
		//充值代理商genAgent
		Principal principal = UserUtils.getPrincipal();
		WasSysUser genAgent = wasSysUserService.get(principal.toString());
		
		//被充值代理商押金账户余额
		BigDecimal cashPledge = secAgent.getCashPledge();
		//充值代理商各账户余额
		BigDecimal genHardware = genAgent.getHardwareAccount();
		BigDecimal genPublic = genAgent.getPublicAccount();
		BigDecimal genMina =  genAgent.getMinaAccount();
		BigDecimal genVip = genAgent.getVipAccount();
		
		if(hardwareMoney != null) {
			cashPledge = cashPledge.add(hardwareMoney);
			genHardware = genHardware.subtract(hardwareMoney);
		}
		if(publicMoney != null ) {
			cashPledge = cashPledge.add(publicMoney);
			genPublic = genPublic.subtract(publicMoney);
		}
		if(minaMoney != null) {
			cashPledge = cashPledge.add(minaMoney);
			genMina = genMina.subtract(minaMoney);
		}
		if(vipMoney != null) {
			cashPledge = cashPledge.add(vipMoney);
			genVip = genVip.subtract(vipMoney);
		}
		
		//插入总代充值消费记录
		WasExpendPay expendPay = new WasExpendPay();
		Date date = new Date();
		expendPay.setOrderNo("EP"+OrderNumberUtils.orderNumber());
		expendPay.setUserId(genAgent.getId());
		expendPay.setBehavior("总代冲消");
		expendPay.setPayMoney(cashPledge.subtract(secAgent.getCashPledge()));
		expendPay.setHardwareExpend(hardwareMoney);
		expendPay.setPublicExpend(publicMoney);
		expendPay.setMinaExpend(minaMoney);
		expendPay.setVipExpend(vipMoney);
		expendPay.setReceivedUserId(sysuser.getId());
		expendPay.setRemarks(sysuser.getRemarks());
		expendPay.setCreateDate(date);
		expendPay.setCreateId(genAgent.getId());
		expendPayService.insert(expendPay);
		//插入被充值代理商充值记录
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		rechargeHistory.setOperateBy(principal.toString());
		//充值单号=R+时间戳(13位)
		BigDecimal decimal = new BigDecimal("0");
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(sysuser.getId());
		rechargeHistory.setRemarks(sysuser.getRemarks());
		rechargeHistory.setCreateDate(date);
		rechargeHistory.setCashRecharge(cashPledge.subtract(secAgent.getCashPledge()));
		rechargeHistory.setHardwareRecharge(decimal);
		rechargeHistory.setPublicRecharge(decimal);
		rechargeHistory.setMinaRecharge(decimal);
		rechargeHistory.setVipRecharge(decimal);
		rechargeHistory.setOperateBy(genAgent.getId());
		WasExpendPay wasExpendPay = expendPayService.get(expendPay);
		rechargeHistory.setExpendPayId(wasExpendPay.getExpendPayId());
		rechargeHistoryService.insert(rechargeHistory);
		
		//更新被充值代理商押金账户
		secAgent.setCashPledge(cashPledge);
		secAgent.setUpdate_by(principal.toString());
		secAgent.setUpdate_date(date);
		isSuccessA = MoneyOperation.getInstance().moneyOperation(totalMoney,decimal,decimal,decimal,decimal,sysuser.getId(), operationA);
		//Integer resultA = wasSysUserService.updateAccount(secAgent);
		
		//更新充值代理商各个账户
		genAgent.setHardwareAccount(genHardware);
		genAgent.setPublicAccount(genPublic);
		genAgent.setMinaAccount(genMina);
		genAgent.setVipAccount(genVip);
		genAgent.setUpdate_by(principal.toString());
		genAgent.setUpdate_date(date);
		isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,publicMoney,minaMoney,hardwareMoney,vipMoney,genAgent.getId(), operationB);
		//Integer resultB = wasSysUserService.updateAccount(genAgent);
		
		//记录更新是否成功
		if(isSuccessA.equals(str) && isSuccessB.equals(str)) {
			result  = 1;
		}else{
			result  = 0;
		}
		return result;
	
	}
	/**
	 * 总代给代理商充值硬件，小程序，公众号
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateAccountCharge"})
	public Integer updateAccountCharge( WasSysUser sysuser,BigDecimal price,String sign,String remarks,HttpServletResponse response, Model model) throws ParseException {
		String operationA ="充值";
		String operationB ="消费";
		String str =StringChangeUtils.OPERATION_SUCCESS;
		Integer result;
		String isSuccessA = null;
		String isSuccessB = null;
		BigDecimal vipMoney = sysuser.getVipAccount();
		BigDecimal totalMoney = price.add(vipMoney);
		//被充值代理商secAgent
		WasSysUser secAgent  = wasSysUserService.get(sysuser.getId());
		
		//充值代理商genAgent
		Principal principal = UserUtils.getPrincipal();
		WasSysUser genAgent = wasSysUserService.get(principal.toString());
		
		//被充值代理商各账户余额
		BigDecimal secHardware = secAgent.getHardwareAccount();
		BigDecimal secPublic  = secAgent.getPublicAccount();
		BigDecimal secMina = secAgent.getMinaAccount();
		//充值代理商各账户余额
		BigDecimal genHardware = genAgent.getHardwareAccount();
		BigDecimal genPublic = genAgent.getPublicAccount();
		BigDecimal genMina =  genAgent.getMinaAccount();
		BigDecimal genVip = genAgent.getVipAccount();
		BigDecimal genHardwareExpend = genAgent.getHardwareExpend();
		BigDecimal genPublicExpend = genAgent.getPublicExpend();
		BigDecimal genMinaExpend =  genAgent.getMinaExpend();
		BigDecimal genVipExpend =  genAgent.getVipExpend();
		
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		WasExpendPay expendPay = new WasExpendPay();
		Date date = new Date();
		BigDecimal decimal = new BigDecimal("0");
		//标识充值方式
		String hardwareName = "hardwareAccount";
		String publicName = "publicAccount";
		String minaName = "minaAccount";
		if(sign.equals(hardwareName)) {	
			genAgent.setHardwareAccount(genHardware.subtract(price));
			genAgent.setVipAccount(genVip.subtract(vipMoney));
			genAgent.setHardwareExpend(genHardwareExpend.add(price));
			genAgent.setVipExpend(genVipExpend.add(vipMoney));
			secAgent.setHardwareAccount(secHardware.add(totalMoney));
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,price,vipMoney,genAgent.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,totalMoney,decimal,sysuser.getId(), operationA);
			rechargeHistory.setHardwareRecharge(totalMoney);
			expendPay.setHardwareExpend(price);
		}else {
			rechargeHistory.setHardwareRecharge(decimal);
			expendPay.setHardwareExpend(decimal);
		}
		if(sign.equals(publicName) ) {	
			genAgent.setPublicAccount(genPublic.subtract(price));
			genAgent.setVipAccount(genVip.subtract(vipMoney));
			genAgent.setPublicExpend(genPublicExpend.add(price));
			genAgent.setVipExpend(genVipExpend.add(vipMoney));
			secAgent.setPublicAccount(secPublic.add(totalMoney));
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,price,decimal,decimal,vipMoney,genAgent.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(decimal,totalMoney,decimal,decimal,decimal,sysuser.getId(), operationA);
			rechargeHistory.setPublicRecharge(totalMoney);
			expendPay.setPublicExpend(price);
		}else {
			rechargeHistory.setPublicRecharge(decimal);
			expendPay.setPublicExpend(decimal);
		}
		if(sign.equals(minaName)) {	
			genAgent.setMinaAccount(genMina.subtract(price));
			genAgent.setVipAccount(genVip.subtract(vipMoney));
			genAgent.setMinaExpend(genMinaExpend.add(price));
			genAgent.setVipExpend(genVipExpend.add(vipMoney));
			secAgent.setMinaAccount(secMina.add(totalMoney));
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,price,decimal,vipMoney,genAgent.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(decimal,decimal,totalMoney,decimal,decimal,sysuser.getId(), operationA);
			rechargeHistory.setMinaRecharge(totalMoney);
			expendPay.setMinaExpend(price);
		}else {
			rechargeHistory.setMinaRecharge(decimal);
			expendPay.setMinaExpend(decimal);
		}
		secAgent.setUpdate_by(principal.toString());
		secAgent.setUpdate_date(date);
		genAgent.setUpdate_by(principal.toString());
		genAgent.setUpdate_date(date);
		//更新代理商记录
		//Integer resultA = wasSysUserService.updateAccount(genAgent);
		//Integer resultB = wasSysUserService.updateAccount(secAgent);
		//插入总代充值消费记录
		expendPay.setOrderNo("EP"+OrderNumberUtils.orderNumber());
		expendPay.setUserId(genAgent.getId());
		expendPay.setBehavior("总代冲消");
		expendPay.setPayMoney(price.add(vipMoney));
		expendPay.setVipExpend(vipMoney);
		expendPay.setReceivedUserId(sysuser.getId());
		expendPay.setRemarks(remarks);
		expendPay.setCreateDate(date);
		expendPay.setCreateId(genAgent.getId());
		expendPayService.insert(expendPay);
		//插入充值记录
		//充值单号=R+时间戳(13位)
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(sysuser.getId());
		rechargeHistory.setCashRecharge(decimal);
		rechargeHistory.setVipRecharge(decimal);
		rechargeHistory.setRemarks(remarks);
		rechargeHistory.setCreateDate(date);
		WasExpendPay wasExpendPay = expendPayService.get(expendPay);
		rechargeHistory.setExpendPayId(wasExpendPay.getExpendPayId());
		rechargeHistoryService.insert(rechargeHistory);
		
		//记录更新是否成功
		if(isSuccessA.equals(str) && isSuccessB.equals(str)) {
			result  = 1;
		}else{
			result  = 0;
		}
		return result;
		
	}
	/**
	 * 总代给代理商充值vip账户
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateVipCharge"})
	public Integer updateVipCharge( WasSysUser sysuser,HttpServletResponse response, Model model) throws ParseException {
		String operationA ="充值";
		String operationB ="消费";
		String str = StringChangeUtils.OPERATION_SUCCESS;
		Integer result;
		String isSuccessA = null;
		String isSuccessB = null;
		BigDecimal vipMoney = sysuser.getVipAccount();
		//被充值代理商secAgent
		WasSysUser secAgent  = wasSysUserService.get(sysuser.getId());
		BigDecimal secVip = secAgent.getVipAccount();
		
		//充值代理商genAgent
		Principal principal = UserUtils.getPrincipal();
		WasSysUser genAgent = wasSysUserService.get(principal.toString());
		BigDecimal genVip = genAgent.getVipAccount();
		BigDecimal genVipExpend = genAgent.getVipExpend();
		
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		WasExpendPay expendPay = new WasExpendPay();
		Date date = new Date();
		BigDecimal decimal = new BigDecimal("0");
		
		//插入总代充值消费记录
		expendPay.setOrderNo("EP"+OrderNumberUtils.orderNumber());
		expendPay.setUserId(genAgent.getId());
		expendPay.setBehavior("总代冲消");
		expendPay.setPayMoney(vipMoney);
		expendPay.setHardwareExpend(decimal);
		expendPay.setPublicExpend(decimal);
		expendPay.setMinaExpend(decimal);
		expendPay.setVipExpend(vipMoney);
		expendPay.setReceivedUserId(secAgent.getId());
		expendPay.setRemarks(sysuser.getRemarks());
		expendPay.setCreateDate(date);
		expendPay.setCreateId(genAgent.getId());
		expendPayService.insert(expendPay);
		//插入充值记录
		//充值单号=R+时间戳(13位)
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(sysuser.getId());
		rechargeHistory.setCashRecharge(decimal);
		rechargeHistory.setPublicRecharge(decimal);
		rechargeHistory.setHardwareRecharge(decimal);
		rechargeHistory.setMinaRecharge(decimal);
		rechargeHistory.setVipRecharge(vipMoney);
		rechargeHistory.setRemarks(sysuser.getRemarks());
		rechargeHistory.setCreateDate(date);
		WasExpendPay wasExpendPay = expendPayService.get(expendPay);
		rechargeHistory.setExpendPayId(wasExpendPay.getExpendPayId());
		rechargeHistoryService.insert(rechargeHistory);
		
		
		secAgent.setVipAccount(secVip.add(vipMoney));
		secAgent.setUpdate_by(principal.toString());
		secAgent.setUpdate_date(date);
		genAgent.setVipAccount(genVip.subtract(vipMoney));
		genAgent.setVipExpend(genVipExpend.add(vipMoney));
		genAgent.setUpdate_by(principal.toString());
		genAgent.setUpdate_date(date);
		//更新代理商记录
		isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,decimal,vipMoney,genAgent.getId(), operationB);
		isSuccessA = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,decimal,vipMoney,sysuser.getId(), operationA);
		//Integer resultA = wasSysUserService.updateAccount(genAgent);
		//Integer resultB = wasSysUserService.updateAccount(secAgent);
		//记录更新是否成功
		if(isSuccessA.equals(str) && isSuccessB.equals(str)) {
			result  = 1;
		}else{
			result  = 0;
		}
		return result;
	}
	/**
	 * 财务退款
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agency:wasSysUser:drawback")
	@ResponseBody
	@RequestMapping(value = {"updateDrawBackAccount"})
	public Integer updateDrawBackAccount( WasSysUser sysuser,String menuId,HttpServletResponse response, Model model) throws ParseException {
		String operation ="充值";
		String str =StringChangeUtils.OPERATION_SUCCESS;
		Integer result;
		String isSuccess = null;
		BigDecimal decimal = new BigDecimal("0");
		BigDecimal hardwareMoney = sysuser.getHardwareAccount();
		BigDecimal publicMoney = sysuser.getPublicAccount();
		BigDecimal minaMoney = sysuser.getMinaAccount();
		BigDecimal vipMoney = sysuser.getVipAccount();
		WasSysUser agent  = wasSysUserService.get(sysuser.getId());
		Principal principal = UserUtils.getPrincipal();
		
		BigDecimal agentHardwareMoney  = agent.getHardwareAccount().add(hardwareMoney);
		BigDecimal agentPublicMoney = agent.getPublicAccount().add(publicMoney);
		BigDecimal agentMinaMoney = agent.getMinaAccount().add(minaMoney);
		BigDecimal agentVipMoney = agent.getVipAccount().add(vipMoney);
		Date date = new Date();
		agent.setHardwareAccount(agentHardwareMoney);
		agent.setPublicAccount(agentPublicMoney);
		agent.setMinaAccount(agentMinaMoney);
		agent.setVipAccount(agentVipMoney);
		agent.setUpdate_by(principal.toString());
		agent.setUpdate_date(date);
	
		//Integer result = wasSysUserService.updateAccount(agent);
		isSuccess = MoneyOperation.getInstance().moneyOperation(decimal,publicMoney,minaMoney,hardwareMoney,vipMoney,sysuser.getId(), operation);
		//wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,date,principal.getId(),"用户"+principal.getLoginName()+"给"+sysuser.getCompanyName()+"退款"));
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(sysuser.getId());
		rechargeHistory.setPublicRecharge(publicMoney);
		rechargeHistory.setMinaRecharge(minaMoney);
		rechargeHistory.setHardwareRecharge(hardwareMoney);
		rechargeHistory.setVipRecharge(vipMoney);
		rechargeHistory.setCashRecharge(decimal);
		rechargeHistory.setRemarks(sysuser.getRemarks());
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setCreateDate(date);
		rechargeHistoryService.insert(rechargeHistory);
		if(isSuccess.equals(str)) {
			result  = 1;
		}else{
			result  = 0;
		}
		return result;
	}
	/**
	 * 代理商逻辑删除
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agency:wasSysUser:del")
	@ResponseBody
	@RequestMapping(value = {"updateDelState"})
	public Integer updateDelState(WasSysUser sysuser,String menuId,HttpServletResponse response, Model model)  {
		 List<WasSysUser> listSysUsers = wasSysUserService.findList(sysuser);
		 sysuser = wasSysUserService.get(sysuser.getId());
		 Integer delState ;
		 char state = '1';
		 if(listSysUsers.size() != 0) {
			delState = 0;
		 }else {
			 Date date = new Date();
			 Principal principal = UserUtils.getPrincipal();
			 sysuser.setDel_flag(state);
			 sysuser.setUpdate_date(date);
			 sysuser.setUpdate_by(principal.toString());
			 delState = wasSysUserService.updateDel(sysuser);
			 wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,date,principal.getId(),"用户"+principal.getLoginName()+"删除了代理商"+sysuser.getCompanyName()));
		 }
		return delState ;
	
	}
	/**
	 * 代理商下单
	 */
	@RequiresPermissions("agency:wasSysUser:order")
	@RequestMapping(value = {"getOrderAgent"})
	public String getOrderAgent( WasSysUser sysuser, HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		model.addAttribute("agent",agent);
		return "modules/agentsystem/agency/wasAgentOrder";
	}
	/**
	 * 代理商转移
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agency:wasSysUser:transfer")
	@RequestMapping(value = {"getTransferAgent"})
	public String getTransferAgent( WasSysUser sysuser, HttpServletResponse response, Model model) {
		WasSysUser agent= wasSysUserService.get(sysuser.getId());
		BigDecimal multiplicand = new BigDecimal(10);
		BigDecimal packageDiscount = agent.getPackageDiscount();
		agent.setPackageDiscount((packageDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal  publicDiscount =  agent.getPublicDiscount();
		agent.setPublicDiscount((publicDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		BigDecimal minaDiscount = agent.getMinaDiscount();
		agent.setMinaDiscount((minaDiscount.multiply(multiplicand)).setScale(1, BigDecimal.ROUND_HALF_UP));
		model.addAttribute("agent",agent);
		List<WasSysUser> listAgents = wasSysUserService.findAllLowerAgent(sysuser);
		model.addAttribute("agentList",listAgents);
		return "modules/agentsystem/agency/wasTransferAgent";
	}
	/**
	 * 硬件，小程序，公众号转移
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateTransferAccount"})
	public BigDecimal updateTransferAccount(WasSysUser sysuser,String sign,String redoundId, BigDecimal price,BigDecimal cashPledge,HttpServletResponse response, Model model) throws ParseException {	
		String operationA ="充值";
		String operationB ="消费";
		String str =StringChangeUtils.OPERATION_SUCCESS;
		String isSuccessA = null;
		String isSuccessB = null;
		Integer state ;
		BigDecimal result = new BigDecimal("0");
		BigDecimal totalMoney = price.add(cashPledge);
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		WasExpendPay expendPay = new WasExpendPay();
		Date date = new Date();
		BigDecimal decimal = new BigDecimal("0");
		//标识是那种充值方式
		String hardwareName = "hardwareAccount";
		String publicName = "publicAccount";
		String minaName = "minaAccount";
		if(sign.equals(hardwareName)) {
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,totalMoney,decimal,sysuser.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(cashPledge,decimal,decimal,price,decimal,redoundId, operationA);
			rechargeHistory.setHardwareRecharge(price);
			rechargeHistory.setCashRecharge(cashPledge);
			expendPay.setHardwareExpend(price.add(cashPledge));
		}else {
			rechargeHistory.setHardwareRecharge(decimal);
			expendPay.setHardwareExpend(decimal);
		}
		if(sign.equals(publicName) ) {
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,totalMoney,decimal,decimal,decimal,sysuser.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(cashPledge,price,decimal,decimal,decimal,redoundId, operationA);
			rechargeHistory.setCashRecharge(cashPledge);
			rechargeHistory.setPublicRecharge(price);
			expendPay.setPublicExpend(price.add(cashPledge));
		}else{
			rechargeHistory.setPublicRecharge(decimal);
			expendPay.setPublicExpend(decimal);
		}
		if(sign.equals(minaName)) {
			isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,totalMoney,decimal,decimal,sysuser.getId(), operationB);
			isSuccessA = MoneyOperation.getInstance().moneyOperation(cashPledge,decimal,price,decimal,decimal,redoundId, operationA);
			rechargeHistory.setCashRecharge(cashPledge);
			rechargeHistory.setMinaRecharge(price);
			expendPay.setMinaExpend(price.add(cashPledge));
		}else {
			rechargeHistory.setMinaRecharge(decimal);
			expendPay.setMinaExpend(decimal);
		}
		Principal principal = UserUtils.getPrincipal();
		
		if(isSuccessA.equals(str) && isSuccessB.equals(str)) {
			state  = 1;
		}else{
			state  = 0;
		}
		//插入总代转移消费记录
		expendPay.setOrderNo("EP"+OrderNumberUtils.orderNumber());
		expendPay.setUserId(sysuser.getId());
		expendPay.setBehavior("财务转移");
		expendPay.setPayMoney(price.add(cashPledge));
		expendPay.setReceivedUserId(redoundId);
		expendPay.setVipExpend(decimal);
		expendPay.setRemarks(sysuser.getRemarks());
		expendPay.setCreateDate(date);
		expendPay.setCreateId(principal.toString());
		if(state == 1) {
			expendPayService.insert(expendPay);
		}
		
		//插入转移充值记录
		//充值单号=R+时间戳(13位)
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(redoundId);
		rechargeHistory.setVipRecharge(decimal);
		rechargeHistory.setRemarks(sysuser.getRemarks());
		rechargeHistory.setCreateDate(date);
		WasExpendPay wasExpendPay = expendPayService.get(expendPay);
		rechargeHistory.setExpendPayId(wasExpendPay.getExpendPayId());
		rechargeHistoryService.insert(rechargeHistory);
		
		//记录更新是否成功
		WasSysUser wasSysUser=wasSysUserService.get(sysuser.getId());
		if(sign.equals(hardwareName)) {
			result = wasSysUser.getHardwareAccount();
		}else if(sign.equals(publicName)) {
			result = wasSysUser.getPublicAccount();
		}else if(sign.equals(minaName)) {
			result = wasSysUser.getMinaAccount();
		}
		return result;		
	}
	/**
	 * VIP转移
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@ResponseBody
	@RequestMapping(value = {"updateTransferVipAccount"})
	public BigDecimal updateTransferVipAccount(WasSysUser sysuser,String redoundId,HttpServletResponse response, Model model) throws ParseException {
		Date date = new Date();
		BigDecimal decimal = new BigDecimal("0");
		String operationA ="充值";
		String operationB ="消费";
		String str =StringChangeUtils.OPERATION_SUCCESS;
		String isSuccessA = null;
		String isSuccessB = null;
		Integer state ;
		BigDecimal result;
		Principal principal = UserUtils.getPrincipal();
		BigDecimal cashPledgeAccount = sysuser.getCashPledge();
		BigDecimal hardwareAccount = sysuser.getHardwareAccount();
		BigDecimal publicAccount  = sysuser.getPublicAccount();
		BigDecimal minaAccount = sysuser.getMinaAccount();
		BigDecimal vipAccount = sysuser.getVipAccount();
		BigDecimal totalMoney = cashPledgeAccount.add(hardwareAccount).add(publicAccount).add(minaAccount).add(vipAccount);
		
		isSuccessB = MoneyOperation.getInstance().moneyOperation(decimal,decimal,decimal,decimal,totalMoney,sysuser.getId(), operationB);
		isSuccessA = MoneyOperation.getInstance().moneyOperation(cashPledgeAccount,publicAccount,minaAccount,hardwareAccount,vipAccount,redoundId, operationA);
		
		if(isSuccessA.equals(str) && isSuccessB.equals(str)) {
			state  = 1;
		}else{
			state  = 0;
		}
		WasExpendPay expendPay = new WasExpendPay();
		expendPay.setOrderNo("EP"+OrderNumberUtils.orderNumber());
		expendPay.setUserId(sysuser.getId());
		expendPay.setBehavior("财务转移");
		expendPay.setPayMoney(cashPledgeAccount.add(hardwareAccount).add(publicAccount).add(minaAccount).add(vipAccount));
		expendPay.setReceivedUserId(redoundId);
		expendPay.setHardwareExpend(decimal);
		expendPay.setPublicExpend(decimal);
		expendPay.setMinaExpend(decimal);
		expendPay.setVipExpend(cashPledgeAccount.add(hardwareAccount).add(publicAccount).add(minaAccount).add(vipAccount));
		expendPay.setRemarks(sysuser.getRemarks());
		expendPay.setCreateDate(date);
		expendPay.setCreateId(principal.toString());
		if(state == 1) {
			expendPayService.insert(expendPay);
		}
		
		
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(redoundId);
		rechargeHistory.setCashRecharge(cashPledgeAccount);
		rechargeHistory.setHardwareRecharge(hardwareAccount);
		rechargeHistory.setPublicRecharge(publicAccount);
		rechargeHistory.setMinaRecharge(minaAccount);
		rechargeHistory.setVipRecharge(vipAccount);
		rechargeHistory.setRemarks(sysuser.getRemarks());
		rechargeHistory.setCreateDate(date);
		WasExpendPay wasExpendPay = expendPayService.get(expendPay);
		rechargeHistory.setExpendPayId(wasExpendPay.getExpendPayId());
		rechargeHistoryService.insert(rechargeHistory);
		//记录更新是否成功
		WasSysUser wasSysUser=wasSysUserService.get(sysuser.getId());
		result = wasSysUser.getVipAccount();
		return result;
		
	}
}
