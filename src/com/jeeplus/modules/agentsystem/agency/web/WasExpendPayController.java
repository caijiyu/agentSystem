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
import com.jeeplus.modules.agentsystem.agency.entity.WasExpendPay;
import com.jeeplus.modules.agentsystem.agency.service.WasExpendPayService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 充消Controller
 * @author SZP
 * @version 2017-10-9
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/ExpendPay")
public class WasExpendPayController extends BaseController {

	
	@Autowired
	WasExpendPayService expendPayService;
	@Autowired
	private WasAgentSystemLogService agentSystemLogService;
	
	/**
	 * 充消记录查看
	 */
	@ResponseBody
	@RequestMapping(value = "get")
	public WasExpendPay get(WasExpendPay expendPay,Model model) {
		expendPay = expendPayService.get(expendPay);
		return expendPay;
	}
	
	/**
	 * 删除充消记录
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agentSystem:wasRecordExamine:consume:delete")
	@ResponseBody
	@RequestMapping(value = "deleteByLogic")
	public Integer deleteByLogic(WasExpendPay expendPay,String menuId) {
		Integer result;
		Principal principal = UserUtils.getPrincipal();
		result = expendPayService.deleteByLogic(expendPay);
		//删除成功插入日志
		agentSystemLogService.insert(new WasAgentSystemLog(menuId, new Date(), principal.toString(), "用户"+principal.getLoginName()+"删除了消费记录单号："+expendPay.getOrderNo()));
		return result;
	}
	
}
