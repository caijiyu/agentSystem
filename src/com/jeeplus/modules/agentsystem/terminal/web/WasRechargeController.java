package com.jeeplus.modules.agentsystem.terminal.web;

import java.math.BigDecimal;
import java.text.ParseException;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.google.common.collect.Lists;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasPolicyPurchase;
import com.jeeplus.modules.agentsystem.agency.entity.WasRechargeHistory;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
import com.jeeplus.modules.agentsystem.agency.service.WasPolicyPurchaseService;
import com.jeeplus.modules.agentsystem.agency.service.WasRechargeHistoryService;
import com.jeeplus.modules.agentsystem.agency.service.WasSysUserService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSalesPolicy;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftware;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentLevelService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSalesPolicyService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSoftwareService;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalProduct;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalUser;
import com.jeeplus.modules.agentsystem.terminal.service.WasTerminalProductService;
import com.jeeplus.modules.agentsystem.terminal.service.WasTerminalUserService;
import com.jeeplus.modules.agentsystem.utils.MoneyOperation;
import com.jeeplus.modules.agentsystem.utils.OrderNumberUtils;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.agentsystem.utils.TerminalPermissionUtils;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;
/**
 * 
 * @author Hua
 *
 */
@Controller
@RequestMapping(value="${adminPath}/agentSystem/terminal/wasRecharge")
@Transactional(readOnly = false,rollbackFor=Exception.class)
public class WasRechargeController  extends BaseController{
	@Autowired
	private WasTerminalUserService wasTerminalUserService;
	@Autowired
	private WasSysUserService wasSysUserService;
	@Autowired
	private WasTerminalProductService wasTerminalProductService;
	@Autowired
	private WasPolicyPurchaseService wasPolicyPurchaseService;
	@Autowired
	private WasSalesPolicyService wasSalesPolicyService;
	@Autowired
	private WasSoftwareService wasSoftwareService;
	@Autowired
	WasAgentLevelService wasAgentLevelService;
	@Autowired
	private WasRechargeHistoryService rechargeHistoryService;

	/**
	 * 全是公众号
	 * @param wasPolicyPurchase
	 * @param request
	 * @return
	 * @throws ParseException
	 */
	@ResponseBody
	@RequestMapping(value="payAllPublic")
	public String payAllPublic(WasPolicyPurchase wasPolicyPurchase, HttpServletRequest request) throws ParseException {
		//取参数
		Integer salesPolicyId = wasPolicyPurchase.getSalesPolicyId();
		Integer policyNumber = wasPolicyPurchase.getPolicyNumber();
		String behavior = wasPolicyPurchase.getBehavior();
		Integer terminalUserId = Integer.parseInt(request.getParameter("terminalUserId"));
		//查终端--->查所属代理商-->查各个账户
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(terminalUserId);
		String parentId = wasTerminalUser.getParentId();
    	WasSysUser sysUser = wasSysUserService.get(parentId);
		BigDecimal pubA = sysUser.getPublicAccount();
		BigDecimal vipA = sysUser.getVipAccount();
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		BigDecimal discount = new BigDecimal(0.00);
		String defaultBehavior = "方针续费";
		if(defaultBehavior.equals(behavior)){
			discount = wasSalesPolicy.getRenewDiscount();
		}else{
			discount = sysUser.getPublicDiscount();
		}
		BigDecimal payMoney = totalPayMoney(salesPolicyId, policyNumber,discount);
		BigDecimal totalMoney = totalMoney(salesPolicyId, policyNumber);
		//构造方针购买实体属性字段
		String number = "P"+OrderNumberUtils.orderNumber();
		Integer dredgeYear = wasSalesPolicy.getDredgeYear();
		Integer giveYear = wasSalesPolicy.getGiveYear();
		Calendar time = Calendar.getInstance();
		Date createDate = time.getTime();
		time.add(Calendar.YEAR, dredgeYear+giveYear);
		Date endDate = time.getTime();
		//==============														
		String userId = UserUtils.getUser().getId();
		BigDecimal publicExpend =new BigDecimal("0.00");				
		BigDecimal minaExpend = new BigDecimal("0.00");					
		BigDecimal hardwareExpend = new BigDecimal("0.00");				
		BigDecimal vipExpend = new BigDecimal("0.00");	
		Integer type = 1;
		String remarks = "";		
		Integer state = 1;
		Integer temp = payMoney.compareTo(pubA);
		//账户操作结果
		String accountResult = null;
		if(temp==-1||temp==0){
			publicExpend = payMoney;
			pubA = pubA.subtract(publicExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,publicExpend, null, null, null, parentId, behavior);
		}else {
			publicExpend = pubA;
			vipExpend = payMoney.subtract(pubA);
			pubA = new BigDecimal("0.00");
			vipA = vipA.subtract(vipExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,publicExpend, null, null, vipExpend, parentId, behavior);
		}
		WasPolicyPurchase wasPolicyPurchase2 = new WasPolicyPurchase(number, terminalUserId, salesPolicyId, policyNumber, 
																												behavior, totalMoney, payMoney,createDate , endDate, userId, publicExpend, minaExpend, 
																												hardwareExpend, vipExpend, type, remarks,  state);
		if(accountResult.equals("操作成功")){
			wasPolicyPurchaseService.save(wasPolicyPurchase2);
			updateTerminalProduct(terminalUserId, salesPolicyId, policyNumber);
			WasAgentLevel agentLevel = wasAgentLevelService.getEnity(sysUser.getAgentLevelId());
			if(agentLevel.getDelegateAgent()==2&&behavior.equals("方针购买")){
				rebate(wasTerminalUser, sysUser, wasSalesPolicy, policyNumber, "pub");
			}
		}
		return accountResult=="操作成功"?"success":"error";
	}
	@ResponseBody
	@RequestMapping(value="payAllMina")
	public String payAllMina(WasPolicyPurchase wasPolicyPurchase, HttpServletRequest request) throws ParseException {
		Integer salesPolicyId = wasPolicyPurchase.getSalesPolicyId();
		Integer policyNumber = wasPolicyPurchase.getPolicyNumber();
		String behavior = wasPolicyPurchase.getBehavior();
		Integer terminalUserId = Integer.parseInt(request.getParameter("terminalUserId"));
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(terminalUserId);
		String parentId = wasTerminalUser.getParentId();
    	WasSysUser sysUser = wasSysUserService.get(parentId);
		BigDecimal minaA = sysUser.getMinaAccount();
		BigDecimal vipA = sysUser.getVipAccount();
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		BigDecimal discount = new BigDecimal(0.00);
		String defaultBehavior = "方针续费";
		if(defaultBehavior.equals(behavior)){
			discount = wasSalesPolicy.getRenewDiscount();
		}else{
			discount = sysUser.getMinaDiscount();
		}
		BigDecimal payMoney = totalPayMoney(salesPolicyId, policyNumber,discount);
		BigDecimal totalMoney = totalMoney(salesPolicyId, policyNumber);
		//构造方针购买实体属性字段
		String number = "P"+OrderNumberUtils.orderNumber();
		Integer dredgeYear = wasSalesPolicy.getDredgeYear();
		Integer giveYear = wasSalesPolicy.getGiveYear();
		Calendar time = Calendar.getInstance();
		Date createDate = time.getTime();
		time.add(Calendar.YEAR, dredgeYear+giveYear);
		Date endDate = time.getTime();
		//==============			
		String userId = UserUtils.getUser().getId();
		BigDecimal publicExpend =new BigDecimal("0.00");				
		BigDecimal minaExpend = new BigDecimal("0.00");					
		BigDecimal hardwareExpend = new BigDecimal("0.00");				
		BigDecimal vipExpend = new BigDecimal("0.00");	
		Integer type = 1;
		String remarks = "";
		Integer state = 1;
		Integer temp = payMoney.compareTo(minaA);
		//账户操作结果
		String accountResult = null;
		if(temp==-1||temp==0){
			minaExpend = payMoney;
			minaA = minaA.subtract(minaExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,null, minaExpend, null, null, parentId, behavior);
		}else {
			minaExpend = minaA;
			vipExpend = payMoney.subtract(minaA);
			minaA = new BigDecimal("0.00");
			vipA = vipA.subtract(vipExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,null, minaExpend, null, vipExpend, parentId, behavior);
		}
		WasPolicyPurchase wasPolicyPurchase2 = new WasPolicyPurchase(number, terminalUserId, salesPolicyId,  policyNumber, 
																												behavior, totalMoney, payMoney, createDate, endDate, userId, publicExpend, minaExpend, 
																												hardwareExpend, vipExpend, type, remarks,  state);
		if(accountResult.equals("操作成功")){
			wasPolicyPurchaseService.save(wasPolicyPurchase2);
			updateTerminalProduct(terminalUserId, salesPolicyId, policyNumber);

			WasAgentLevel agentLevel = wasAgentLevelService.getEnity(sysUser.getAgentLevelId());
			if(agentLevel.getDelegateAgent()==2&&behavior.equals("方针购买")){
				rebate(wasTerminalUser, sysUser, wasSalesPolicy, policyNumber, "mina");
			}
		}
		return accountResult=="操作成功"?"success":"error";
	}
	//混合
	@ResponseBody
	@RequestMapping(value="payPublicAndMina")
	public String payPublicAndMina(WasPolicyPurchase wasPolicyPurchase, HttpServletRequest request) throws ParseException {
		Integer salesPolicyId = wasPolicyPurchase.getSalesPolicyId();
		Integer policyNumber = wasPolicyPurchase.getPolicyNumber();
		String behavior = wasPolicyPurchase.getBehavior();
		Integer terminalUserId = Integer.parseInt(request.getParameter("terminalUserId"));
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(terminalUserId);
		String parentId = wasTerminalUser.getParentId();
    	WasSysUser sysUser = wasSysUserService.get(parentId);
		BigDecimal pubA = sysUser.getPublicAccount();
		BigDecimal minaA = sysUser.getMinaAccount();
		BigDecimal vipA = sysUser.getVipAccount();
		BigDecimal pubAandMinaA = pubA.add(minaA);
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		BigDecimal discount = new BigDecimal(0.00);
		String defaultBehavior = "方针续费";
		if(defaultBehavior.equals(behavior)){
			discount = wasSalesPolicy.getRenewDiscount();
		}else{
			discount = sysUser.getPackageDiscount();
		}
		BigDecimal payMoney = totalPayMoney(salesPolicyId, policyNumber,discount);
		BigDecimal totalMoney = totalMoney(salesPolicyId, policyNumber);
		//构造方针购买实体属性字段
		String number = "P"+OrderNumberUtils.orderNumber();
		Integer dredgeYear = wasSalesPolicy.getDredgeYear();
		Integer giveYear = wasSalesPolicy.getGiveYear();
		Calendar time = Calendar.getInstance();
		Date createDate = time.getTime();
		time.add(Calendar.YEAR, dredgeYear+giveYear);
		Date endDate = time.getTime();
		//==============			
		String userId = UserUtils.getUser().getId();
		BigDecimal publicExpend =new BigDecimal("0.00");				
		BigDecimal minaExpend = new BigDecimal("0.00");					
		BigDecimal hardwareExpend = new BigDecimal("0.00");				
		BigDecimal vipExpend = new BigDecimal("0.00");	
		Integer type = 1;
		String remarks = "";
		Integer state = 1;
		Integer temp = payMoney.compareTo(pubA);
		Integer temp1 = payMoney.compareTo(pubAandMinaA);
		//账户操作结果
		String accountResult = null;
		if(temp==-1||temp==0){
			publicExpend = payMoney;
			pubA = pubA.subtract(publicExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,publicExpend, null, null, null, parentId, behavior);
		}else if(temp1==-1||temp1==0) {
			publicExpend = pubA;
			minaExpend = payMoney.subtract(pubA);
			pubA = new BigDecimal("0.00");
			minaA = minaA.subtract(minaExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,publicExpend, minaExpend, null, null, parentId, behavior);
		}else {
			publicExpend = pubA;
			minaExpend = minaA;
			vipExpend = payMoney.subtract(pubA.add(minaA));
			pubA = new BigDecimal("0.00");
			minaA =  new BigDecimal("0.00");
			vipA = vipA.subtract(vipExpend);
			accountResult = MoneyOperation.getInstance().moneyOperation(null,publicExpend, minaExpend, null, vipExpend, parentId, behavior);
		}
		WasPolicyPurchase wasPolicyPurchase2 = new WasPolicyPurchase(number, terminalUserId, salesPolicyId, policyNumber, 
																												behavior, totalMoney, payMoney, createDate, endDate, userId, publicExpend, minaExpend, 
																												hardwareExpend, vipExpend, type, remarks,  state);
		if(accountResult.equals("操作成功")){
			wasPolicyPurchaseService.save(wasPolicyPurchase2);
			updateTerminalProduct(terminalUserId, salesPolicyId, policyNumber);
			WasAgentLevel agentLevel = wasAgentLevelService.getEnity(sysUser.getAgentLevelId());
			if(agentLevel.getDelegateAgent()==2&&behavior.equals("方针购买")){
				rebate(wasTerminalUser, sysUser, wasSalesPolicy, policyNumber, "all");
			}
		}
		return accountResult=="操作成功"?"success":"error";
	}
	/**
	 * 
	 * @param policyId
	 * @param policyNumber
	 * @return
	 * 根据方针ID与数理算出折扣后的总价，精确度0.00
	 */
	public BigDecimal totalPayMoney(Integer policyId,Integer policyNumber,BigDecimal discount){
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(policyId);
		BigDecimal price = wasSalesPolicy.getPrice();
		BigDecimal singlePayMoney = price.multiply(discount);
		singlePayMoney = singlePayMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
		return singlePayMoney.multiply(new BigDecimal(policyNumber));
	}
	
	/**
	 * 
	 * @param policyId
	 * @param policyNumber
	 * @return
	 * 根据方针ID与数理算出折扣后的总价
	 */
	public BigDecimal totalMoney(Integer policyId,Integer policyNumber){
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(policyId);
		BigDecimal price = wasSalesPolicy.getPrice();
		return price.multiply(new BigDecimal(policyNumber));
	}
	/**
	 * 续费页面
	 * @param terminalUserId
	 * @param model
	 * @return
	 */
	@RequiresPermissions("terminal:wasTerminalProduct:toWasRechargeList")
	@RequestMapping(value="toWasRechargeList")
	public String findProductsByTerminalUserId(String terminalUserId,Model model) {
		//1、终端用户
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(Integer.parseInt(terminalUserId));
		model.addAttribute("wasTerminalUser",wasTerminalUser );
		//2、所属代理商
    	WasSysUser wasSysUser = wasSysUserService.get(wasTerminalUser.getParentId());
    	model.addAttribute("wasSysUser", wasSysUser);
    	//3、终端拥有产品--已经做过期产品过滤了
		List<WasTerminalProduct> list = wasTerminalProductService.findProductsByTerminalUserId(Integer.parseInt(terminalUserId));
		for(WasTerminalProduct wasTerminalProduct : list){
			Integer softId = wasTerminalProduct.getSoftwareId();
			WasSoftware soft = wasSoftwareService.findSoftwareById(softId);	
			wasTerminalProduct.setId(soft.getName());
			if(soft.getClassify()){
				wasTerminalProduct.setClassify(true);
			}else {
				wasTerminalProduct.setClassify(false);
			}		
		}
    	model.addAttribute("productList",list );
    	//4、可续费的方针列表
    	List<WasPolicyPurchase> policyList = wasPolicyPurchaseService.findPolicyOfTerminalUser(terminalUserId);   
    	List<WasSalesPolicy> salesPolicyList = new ArrayList<>();
    	for(WasPolicyPurchase wasPolicyPurchase : policyList){
    		Integer policyId = wasPolicyPurchase.getSalesPolicyId();
    		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(policyId);				
    		BigDecimal renewMoney = wasSalesPolicy.getPrice().multiply(wasSalesPolicy.getRenewDiscount());
    		renewMoney = renewMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    		wasSalesPolicy.setRenewDiscount(renewMoney);
    		wasSalesPolicy.setId("3");
    		Long start =  wasSalesPolicy.getStartDate().getTime();
    		Long end =   wasSalesPolicy.getEndDate().getTime();
    		Long now = System.currentTimeMillis();
    		if(now>=start&&now<=end){
        		salesPolicyList.add(wasSalesPolicy);
    		}
    	}
    	Collections.sort(salesPolicyList); 
    	model.addAttribute("policies", salesPolicyList);
		return "modules/agentsystem/terminal/wasRechargeList";
	}
	@RequestMapping(value="terminalUserNumber")
	@ResponseBody
	public Number terminalUserProductNumber(String terminalUserId) {
		List<WasTerminalProduct> list = wasTerminalProductService.findProductsByTerminalUserId(Integer.parseInt(terminalUserId));
		return list.size();
	}
	/**
	 * 添加产品页面
	 * @param terminalUserId
	 * @param model
	 * @return
	 */

	@RequiresPermissions("terminal:wasTerminalProduct:toAddProductList")
	@RequestMapping(value="toAddProductList")
	public String toAddProductList(String terminalUserId,String title,Model model) {
		WasSalesPolicy policy = new WasSalesPolicy();
		policy.setTitle(StringChangeUtils.specialStr(HtmlUtils.htmlUnescape(title)));
		model.addAttribute("title",title );
		//1、终端用户
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(Integer.parseInt(terminalUserId));
		model.addAttribute("wasTerminalUser",wasTerminalUser );
		//2、所属代理商
    	WasSysUser wasSysUser = wasSysUserService.get(wasTerminalUser.getParentId());
    	model.addAttribute("wasSysUser", wasSysUser);
    	//3、终端拥有产品
		List<WasTerminalProduct> list = wasTerminalProductService.findProductsByTerminalUserId(Integer.parseInt(terminalUserId));
		for(WasTerminalProduct wasTerminalProduct : list){
			Integer softId = wasTerminalProduct.getSoftwareId();
			WasSoftware soft = wasSoftwareService.findSoftwareById(softId);
			wasTerminalProduct.setNewVersion(soft.getNewVersion());
			
			wasTerminalProduct.setId(soft.getName());
			if(soft.getClassify()){
				wasTerminalProduct.setClassify(true);
			}else {
				wasTerminalProduct.setClassify(false);
			}
		}
    	model.addAttribute("productList",list );
    	//4、可选购的方针列表
    	Integer agentLevelId = wasSysUser.getAgentLevelId();
    	 WasAgentLevel wasAgentLevel = wasAgentLevelService.getEnity(agentLevelId);
     	List< WasSalesPolicy> policies = Lists.newArrayList();
    	 if(wasAgentLevel != null){
    		 String salesPolicies =  wasAgentLevel.getSalesPolicyIds();
    		 if(!StringUtils.isBlank(salesPolicies)){
    			 String[] policyIds = StringUtils.split(salesPolicies, ",");
	    		 for(String policyId : policyIds){
	    			 policy.setSalesPolicyId(Integer.valueOf(policyId));
	    			 WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findPolicy(policy);
	    			 if(wasSalesPolicy!=null && ((wasSalesPolicy.getEndDate().getTime()>new Date().getTime())&&(wasSalesPolicy.getStartDate().getTime()<new Date().getTime()))){
	    				 policies.add(wasSalesPolicy); 
	    			 }
	    		 }
    		 }
    	 }else{
    		 policies = wasSalesPolicyService.findUseablePolicies(policy);
    	 }
    	 if(policies.size()>0){
    	       	for(WasSalesPolicy wasSalesPolicy : policies){
    	    		Integer softClass = wasSalesPolicy.getClassify();
    	    		BigDecimal discount = null;
    	    		if(softClass==0){
    	    			//公众号套餐
    	    			discount = wasSysUser.getPublicDiscount();
    	    		}else if(softClass==1){
    	    			//小程序套餐
    	    			discount = wasSysUser.getMinaDiscount();
    	    		}else if(softClass == 2){
    	    			//混合套餐
    	    			discount = wasSysUser.getPackageDiscount();
    	    		}
    	    		BigDecimal renewMoney = wasSalesPolicy.getPrice().multiply(discount);
    	    		renewMoney = renewMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    	    		wasSalesPolicy.setRenewDiscount(renewMoney);
    	    		wasSalesPolicy.setId("3");
    	    	}
    	 }
    	Collections.sort(policies); 
    	model.addAttribute("policies", policies);
		return "modules/agentsystem/terminal/wasAddProductList";
	}
	@ResponseBody
	@RequestMapping(value="checkOldProduct")
	public WasSoftware checkOldProduct(Integer salesPolicyId){		
		WasSalesPolicy wasSalesPolicy =  wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		if(wasSalesPolicy!=null){
			String[] softIds = StringUtils.split(wasSalesPolicy.getSoftwareIds(), ",");
			for(String id : softIds){
				WasSoftware temp = wasSoftwareService.findSoftwareById(Integer.valueOf(id));
				if(temp.getNewVersion() == 0){
					temp.setId(wasSalesPolicy.getTitle());
					return temp;
				}
			}
		}
		return null;
	}

	
	@ResponseBody
	@RequestMapping(value="getSalePolicies")
	public List<WasSalesPolicy> getSalePolicies(String terminalUserId,String title){
		WasSalesPolicy policy = new WasSalesPolicy();
		policy.setTitle(HtmlUtils.htmlUnescape(title));
		//1、终端用户
		WasTerminalUser wasTerminalUser = wasTerminalUserService.findByTerminalUserId(Integer.parseInt(terminalUserId));
		//2、所属代理商
    	WasSysUser wasSysUser = wasSysUserService.get(wasTerminalUser.getParentId());
		//4、可选购的方针列表
    	Integer agentLevelId = wasSysUser.getAgentLevelId();
    	WasAgentLevel wasAgentLevel = wasAgentLevelService.getEnity(agentLevelId);
     	List< WasSalesPolicy> policies = Lists.newArrayList();
    	 if(wasAgentLevel != null){
    		 String salesPolicies =  wasAgentLevel.getSalesPolicyIds();
    		 String[] policyIds = StringUtils.split(salesPolicies, ",");
    		 for(String policyId : policyIds){
    			 policy.setSalesPolicyId(Integer.valueOf(policyId));
    			 WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findPolicy(policy);
    			 if(wasSalesPolicy!=null && ((wasSalesPolicy.getEndDate().getTime()>new Date().getTime())&&(wasSalesPolicy.getStartDate().getTime()<new Date().getTime()))){
    				 policies.add(wasSalesPolicy); 
    			 }
    		 }
    	 }else{
    		 policies = wasSalesPolicyService.findUseablePolicies(policy);
    	 }
    	 if(policies.size()>0){
    	       	for(WasSalesPolicy wasSalesPolicy : policies){
    	       		

       			 String[] salesPolicyIds =  StringUtils.split(wasSalesPolicy.getSoftwareIds(), ",");
       			 for (String salePolicyId : salesPolicyIds) {
   					WasSoftware wasSoftware = wasSoftwareService.findSoftwareById(Integer.valueOf(salePolicyId));
   					if(wasSoftware != null){
   	   					wasSalesPolicy.getSofts().add(wasSoftware);
   					}
   				}
    	    		Integer softClass = wasSalesPolicy.getClassify();
    	    		BigDecimal discount = null;
    	    		if(softClass==0){
    	    			//公众号套餐
    	    			discount = wasSysUser.getPublicDiscount();
    	    		}else if(softClass==1){
    	    			//小程序套餐
    	    			discount = wasSysUser.getMinaDiscount();
    	    		}else if(softClass == 2){
    	    			//混合套餐
    	    			discount = wasSysUser.getPackageDiscount();
    	    		}
    	    		BigDecimal renewMoney = wasSalesPolicy.getPrice().multiply(discount);
    	    		renewMoney = renewMoney.setScale(2, BigDecimal.ROUND_HALF_UP);
    	    		wasSalesPolicy.setRenewDiscount(renewMoney);
    	    		wasSalesPolicy.setId("3");
    	    	}
    	 }
    	Collections.sort(policies); 
		return policies;
	}
	/**
	 * 更新终端产品表
	 * @param terminalUserId
	 * @param salesPolicyId
	 * @param num
	 */
	private void updateTerminalProduct(Integer terminalUserId,Integer salesPolicyId,Integer num){
		WasSalesPolicy wasSalesPolicy = wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		String[] salesWareIds = StringUtils.split(wasSalesPolicy.getSoftwareIds(), ",");
		Integer time = (wasSalesPolicy.getDredgeYear() + wasSalesPolicy.getGiveYear())*num;
		for(int i=0;i<salesWareIds.length;i++){
			WasTerminalProduct wasTerminalProduct = wasTerminalProductService.findByTerminalUserIdAndSoftWareId(terminalUserId,Integer.parseInt(salesWareIds[i]));
			//新建一个终端产品
			if (wasTerminalProduct == null) {
				Calendar calendar = Calendar.getInstance();
				Date startDate = calendar.getTime();
				int year = calendar.get(Calendar.YEAR) + time;
				calendar.set(Calendar.YEAR, year);
				Date endDate = calendar.getTime();
				WasTerminalProduct newData = new WasTerminalProduct(terminalUserId,Integer.parseInt(salesWareIds[i]) , startDate, endDate, 1);
				wasTerminalProductService.insertProduct(newData);
			//续费-没过期
			}else{
				if(wasTerminalProduct.getEndDate().getTime() >= System.currentTimeMillis()){
					Date endDate = wasTerminalProduct.getEndDate();
					Calendar calendar=Calendar.getInstance();
					calendar.setTime(endDate);
					int year = calendar.get(Calendar.YEAR) + time;
					calendar.set(Calendar.YEAR, year);
					endDate = calendar.getTime();
					wasTerminalProduct.setEndDate(endDate);
					wasTerminalProductService.updateProduct(wasTerminalProduct);
				//续费-过期
				}else if(wasTerminalProduct.getEndDate().getTime() < System.currentTimeMillis()){
					Calendar calendar = Calendar.getInstance();
					Date startDate = calendar.getTime();
					int year = calendar.get(Calendar.YEAR) + time;
					calendar.set(Calendar.YEAR, year);
					Date endDate = calendar.getTime();
					wasTerminalProduct.setStartDate(startDate);
					wasTerminalProduct.setEndDate(endDate);
					wasTerminalProductService.updateProduct(wasTerminalProduct);
				}
			}
		}
		WasTerminalUser terminalUser = wasTerminalUserService.findByTerminalUserId(terminalUserId);
		TerminalPermissionUtils.sendTerminalPermissions(terminalUser);
	}
	/**
	 * 返点 只有二级待有此功能
	 * @throws ParseException 
	 */
	private String  rebate(WasTerminalUser wasTerminalUser,WasSysUser sysUser,WasSalesPolicy wasSalesPolicy,Integer num,String classily) throws ParseException{
		String parentAgentId =  sysUser.getCompanyParentId();
		WasSysUser parentAgent = wasSysUserService.get(parentAgentId);
		BigDecimal difference = new BigDecimal("0.00");
		BigDecimal price = wasSalesPolicy.getPrice();
		
		if(classily.equals("pub")){
			difference = sysUser.getPublicDiscount().subtract(parentAgent.getPublicDiscount());
		}else if(classily.equals("mina")){
			difference = sysUser.getMinaDiscount().subtract(parentAgent.getMinaDiscount());
		}else if(classily.equals("all")){
			difference = sysUser.getPackageDiscount().subtract(parentAgent.getPackageDiscount());
		}
		int r=difference.compareTo(BigDecimal.ZERO);
		if(r==0){
			return null;
		}
		BigDecimal rebateMoney = price.multiply(difference).multiply(new BigDecimal(num));

		String accountResult = null;
		
		BigDecimal temp = new BigDecimal("0.00");
		
		if(classily.equals("pub")){
			accountResult = MoneyOperation.getInstance().moneyOperation(null, rebateMoney, null, null, null, parentAgentId, "充值");
			rechargeRecord(rebateMoney, temp, parentAgentId, wasSalesPolicy.getSalesPolicyId());
		}else if(classily.equals("mina")){
			accountResult = MoneyOperation.getInstance().moneyOperation(null, null, rebateMoney, null, null, parentAgentId, "充值");
			rechargeRecord(temp, rebateMoney, parentAgentId, wasSalesPolicy.getSalesPolicyId());
		}else if(classily.equals("all")){
			accountResult = MoneyOperation.getInstance().moneyOperation(null, rebateMoney, null, null, null, parentAgentId, "充值");
			rechargeRecord(rebateMoney, temp, parentAgentId, wasSalesPolicy.getSalesPolicyId());
		}
		return accountResult;
	}
	
	private void rechargeRecord(BigDecimal pub,BigDecimal mina, String agentId,Integer salesPolecyId) throws ParseException{
		WasRechargeHistory rechargeHistory = new WasRechargeHistory();
		Principal principal = UserUtils.getPrincipal();
		rechargeHistory.setOperateBy(principal.toString());
		rechargeHistory.setRechargeNo("R"+OrderNumberUtils.orderNumber());
		rechargeHistory.setReceivedUserId(agentId);
		BigDecimal temp = new BigDecimal("0.00");
		rechargeHistory.setCashRecharge(temp);
		rechargeHistory.setHardwareRecharge(temp);
		rechargeHistory.setPolicyPurchaseId(salesPolecyId);
		rechargeHistory.setPublicRecharge(pub);
		rechargeHistory.setMinaRecharge(mina);
		rechargeHistory.setVipRecharge(temp);
		rechargeHistory.setRemarks("");
		rechargeHistory.setCreateDate(new Date());
		rechargeHistoryService.insert(rechargeHistory);
	}
}

