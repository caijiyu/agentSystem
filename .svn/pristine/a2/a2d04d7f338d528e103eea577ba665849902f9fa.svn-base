/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasInvoiceContent;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasInvoiceContentService;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;
import com.jeeplus.common.utils.StringUtils;

/**
 * 发票内容Controller
 * @author HJT
 * @version 2017-10-08
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/wasInvoiceContent")
public class WasInvoiceContentController extends BaseController {

	@Autowired
	private WasInvoiceContentService wasInvoiceContentService;
	
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	@ModelAttribute
	public WasInvoiceContent get(@RequestParam(required=false) String id) {
		WasInvoiceContent entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wasInvoiceContentService.get(id);
		}
		if (entity == null){
			entity = new WasInvoiceContent();
		}
		return entity;
	}
	
	/**
	 * 成功列表页面
	 */
	@RequiresPermissions("sysdata:wasInvoiceContent:list")
	@RequestMapping(value = "list")
	public String list(WasInvoiceContent wasInvoiceContent, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WasInvoiceContent> page = wasInvoiceContentService.findPage(new Page<WasInvoiceContent>(request, response), wasInvoiceContent); 
		model.addAttribute("page", page);
		model.addAttribute("time", wasInvoiceContent);
		return "modules/agentsystem/sysdata/wasInvoiceContent";
	}

	
	/**
	 * 保存
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasInvoiceContent:add")
	@RequestMapping(value = "save")
	@ResponseBody
	public Integer save(WasInvoiceContent wasInvoiceContent,User user,String menuId) {
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		wasInvoiceContent.setCreateBy(user);
		wasInvoiceContent.setCreateDate(new Date());
		Integer result=wasInvoiceContentService.saveContent(wasInvoiceContent);
		if(wasInvoiceContent.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"添加开票内容为"+wasInvoiceContent.getDetails()));	
		}
		return result;
	}
	
	/**
	 * 删除
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasInvoiceContent:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(WasInvoiceContent wasInvoiceContent,String menuId) {
		Principal principal = UserUtils.getPrincipal();
		Integer result=wasInvoiceContentService.deleteContent(wasInvoiceContent);
		if(wasInvoiceContent.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"删除了开票内容ID为"+wasInvoiceContent.getContentId()));	
		}
		return result;
	}
}