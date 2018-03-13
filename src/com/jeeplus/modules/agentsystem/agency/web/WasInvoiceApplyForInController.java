package com.jeeplus.modules.agentsystem.agency.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasInvoiceApplication;
import com.jeeplus.modules.agentsystem.agency.service.WasInvoiceApplicationService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;


/**
 * 
 * @author WR
 * @version 2017-9-29
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/wasInvoiceApplyForIn")
public class WasInvoiceApplyForInController extends BaseController{

	
	@Autowired
	private WasInvoiceApplicationService wasInvoiceApplicationService;
	/**
	 * 增删改列表页面申请中
	 */
	//@RequiresPermissions("agentsystem:wasInvoiceApplyForIn:list")
	@RequestMapping(value = {"list", ""})
	public String list(String body,WasInvoiceApplication wasInvoiceApplication, HttpServletRequest request, HttpServletResponse response, Model model) {							
		//排序的标志
		wasInvoiceApplication.setOrderFlag(0);
		//列表显示
		wasInvoiceApplication.setSendFlag(1);
		//查看未完成的订单
		wasInvoiceApplication.setSendState(2);
		//未删除的订单
		wasInvoiceApplication.setState(1);
		//当前用户
		Principal principal = UserUtils.getPrincipal();
		wasInvoiceApplication.setApplyBy(principal.toString());
		model.addAttribute("body", body);
		model.addAttribute("wasInvoiceApplication",wasInvoiceApplication);
		wasInvoiceApplication.setBody(StringChangeUtils.specialStr(wasInvoiceApplication.getBody()));
		Page<WasInvoiceApplication> page = wasInvoiceApplicationService.findPage(new Page<WasInvoiceApplication>(request, response), wasInvoiceApplication);        		
		boolean isLast = page.isLastPage();
		if(isLast){
			model.addAttribute("isLast", 1);
		}	
		model.addAttribute("page", page);		
		return "modules/agentsystem/agency/wasInvoiceApplyForIn";
	}
	/**
	 * 增删改列表页面申请中已完成
	 */
	@RequiresPermissions("agentsystem:wasInvoiceApplyForIn:listFinish")
	@RequestMapping(value = {"listFinish", ""})
	public String listFinish(String body,WasInvoiceApplication wasInvoiceApplication, HttpServletRequest request, HttpServletResponse response, Model model) {					
		//排序的标志
		wasInvoiceApplication.setOrderFlag(1);
		//列表显示
		wasInvoiceApplication.setSendFlag(0);
		//查看未完成的订单
		wasInvoiceApplication.setSendState(2);
		//未删除的订单
		wasInvoiceApplication.setState(1);
		//当前用户
		Principal principal = UserUtils.getPrincipal();
		wasInvoiceApplication.setApplyBy(principal.toString());	
		model.addAttribute("body", body);
		model.addAttribute("wasInvoiceApplication",wasInvoiceApplication);
		wasInvoiceApplication.setBody(StringChangeUtils.specialStr(wasInvoiceApplication.getBody()));
		Page<WasInvoiceApplication> page = wasInvoiceApplicationService.findPage(new Page<WasInvoiceApplication>(request, response), wasInvoiceApplication);        		
		model.addAttribute("page", page); 
		return "modules/agentsystem/agency/wasInvoiceApplyForInFinish";
	}
}
