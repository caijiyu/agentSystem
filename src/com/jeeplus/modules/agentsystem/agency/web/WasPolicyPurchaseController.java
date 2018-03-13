package com.jeeplus.modules.agentsystem.agency.web;


import java.util.Date;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasPolicyPurchase;
import com.jeeplus.modules.agentsystem.agency.service.WasPolicyPurchaseService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSalesPolicyService;
import com.jeeplus.modules.agentsystem.terminal.service.WasTerminalUserService;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.service.SystemService;
import com.jeeplus.modules.sys.utils.UserUtils;


/**
 * （软件）方针购买Controller
 * @author SZP
 * @version 2017-10-9
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/PolicyPurchase")
@Transactional(readOnly = false,rollbackFor=Exception.class)
public class WasPolicyPurchaseController extends BaseController{
	@Autowired
	WasPolicyPurchaseService policyPurchaseService;
	@Autowired
	WasTerminalUserService wasTerminalUserService;
	@Autowired
	SystemService systemService;
	@Autowired
	WasSalesPolicyService wasSalesPolicyService;
	@Autowired
	private WasAgentSystemLogService agentSystemLogService;
	
	
	/**
	 * 软件记录查看
	 */
	@ResponseBody
	@RequestMapping(value = "get")
	public WasPolicyPurchase get(WasPolicyPurchase policyPurchase,Model model) {
		policyPurchase = policyPurchaseService.get(policyPurchase);
		return policyPurchase;
	}
	
	/**
	 * 删除软件记录
	 */
	@RequiresPermissions("agentSystem:wasRecordExamine:consume:delete")
	@ResponseBody
	@RequestMapping(value = "deleteByLogic")
	public Integer deleteByLogic(WasPolicyPurchase policyPurchase,String menuId) {
		Integer result;
		Principal principal = UserUtils.getPrincipal();
		result = policyPurchaseService.deleteByLogic(policyPurchase);
		//删除成功插入日志
		agentSystemLogService.insert(new WasAgentSystemLog(menuId, new Date(), principal.toString(), "用户"+principal.getLoginName()+"删除了消费记录单号："+policyPurchase.getNumber()));
		return result;
	}
}
