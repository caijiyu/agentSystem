/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;

import java.util.Date;
import java.util.List;

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
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgelimit;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgelimitService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;
import com.jeeplus.common.utils.StringUtils;

/**
 * 年限Controller
 * @author HJT
 * @version 2017-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/wasAgelimit")
public class WasAgelimitController extends BaseController {

	@Autowired
	private WasAgelimitService wasAgelimitService;
	
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	
	@ModelAttribute
	public WasAgelimit get(@RequestParam(required=false) String id) {
		WasAgelimit entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wasAgelimitService.get(id);
		}
		if (entity == null){
			entity = new WasAgelimit();
		}
		return entity;
	}
	
	/**
	 * 列表展示
	 */
	@RequiresPermissions("sysdata:wasAgelimit:list")
	@RequestMapping(value = "list")
	public String list(WasAgelimit wasAgelimit, HttpServletRequest request, HttpServletResponse response, Model model) {
		List<WasAgelimit> ageList=wasAgelimitService.findList(wasAgelimit);
		model.addAttribute("ageList", ageList);
		return "modules/agentsystem/sysdata/wasAgelimit";
	}

	/**
	 * 保存
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasAgelimit:add")
	@RequestMapping(value = "save")
	@ResponseBody
	public Integer save(Integer year,WasAgelimit wasAgelimit,User user,String menuId) {
		wasAgelimit.setCreateDate(new Date());
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		wasAgelimit.setCreateBy(user);
		Integer result=wasAgelimitService.saveAgelimit(wasAgelimit);
		if(wasAgelimit.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"添加了年限"+year));	
		}
		return result;
	}
	
	/**
	 * 删除保
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasAgelimit:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(WasAgelimit wasAgelimit,String menuId) {
		Principal principal = UserUtils.getPrincipal();
		Integer result=wasAgelimitService.deleteAge(wasAgelimit);
		if(wasAgelimit.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"删除了年限ID为"+wasAgelimit.getAgelimitId()));	
		}
		return result;
	}
	
	
	
	
	/**
	 * 验证
	 */
	@ResponseBody
	@RequestMapping(value = "validate")
	public boolean validate(Integer year) {
		WasAgelimit yearenity=wasAgelimitService.findYear(year);
		if(yearenity ==null){
		    	return true;
		    }else{
			    return false;
		    }
	}

}