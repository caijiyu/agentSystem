/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;


import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.utils.StringUtils;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasRoleService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.dao.RoleDao;
import com.jeeplus.modules.sys.entity.Role;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.service.SystemService;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 角色Controller
 * @author Wb
 * @version 2017-9-29
 */
@Controller
@RequestMapping(value = "${adminPath}/agentsystem/role")
public class WasRoleController extends BaseController {

	@Autowired
	private SystemService systemService;
	@Autowired
	private WasRoleService wasRoleService;
	@Autowired
	private RoleDao roleDao;
	@Autowired
	private SystemAuthorizingRealm systemRealm;
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	
	public static final String  EDIT_ROLE="编辑角色";		
	public static final String  ADD_ROLE="添加角色";
	
	/**
	 * 增删改列表页面
	 */
	@RequiresPermissions("sysdata:wasRole:list")
	@RequestMapping(value = {"list", ""})
	public String list(Role role, HttpServletRequest request, HttpServletResponse response, Model model) {
		String originalName=role.getName();
		role.setName(StringChangeUtils.specialStr(role.getName()));
		Page<Role> page = wasRoleService.findPage(new Page<Role>(request, response), role); 
		role.setName(originalName);
		model.addAttribute("log", role);
		model.addAttribute("page", page);
		return "modules/agentsystem/sysdata/wasRoleList";
	}
	
	/**
	 * 检查名称重复性
	 */
	@ResponseBody
	@RequestMapping(value = "checkName")
	public String checkName(String oldName, String name,String operation) {
		 oldName=HtmlUtils.htmlUnescape(oldName);
		 name=HtmlUtils.htmlUnescape(name);
		if(EDIT_ROLE.equals(operation)){
			if (name!=null && name.equals(oldName)) {
				return "true";
			} else if (name!=null &&wasRoleService.getByName(name) == null) {
				return "true";
			}
		}else if("".equals(oldName)&&ADD_ROLE.equals(operation)){
			if(name!=null && wasRoleService.getByName(name) == null){
				return "true";
			}
		}
		return "false";
	}
	
	/**
	 * 根据id获取角色
	 */
	@ResponseBody
	@RequestMapping(value = "get")
	public Role get(String id) {
		return wasRoleService.get(id);
	}
	
	/**
	 * 保存和编辑角色
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions(value={"sysdata:wasRole:add","sysdata:wasRole:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "saveRole")
	public Integer saveRole(Role role,String menuIdA) {
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal(); 
		int result=0;
		role.setDataScope("1");
		role.setSysData("1");
		role.setUseable("1");
		role.setDelFlag("0");
		
		if (StringUtils.isBlank(role.getId())){
			role.preInsert();
			roleDao.insert(role);
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuIdA, new Date(), principal.getId(),"用户"+principal.getLoginName()+"添加了角色"+role.getName()));                         
		}else{
			role.preUpdate();
			roleDao.update(role);
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuIdA, new Date(), principal.getId(),"用户"+principal.getLoginName()+"编辑了角色"+role.getName()));                         
		}
		// 清除用户角色缓存
		UserUtils.removeCache(UserUtils.CACHE_ROLE_LIST);
	
		result=1;
		return result;
	}
	/**
	 * 判断是否能删除角色
	 */
	@RequiresPermissions("sysdata:wasRole:del")
	@ResponseBody
	@RequestMapping(value = "judgeDelete")
	public Integer  judgeDelete(Role role) {
		int result=0;
		int countA=0;
		int countB=0;
		try {
			countA=wasRoleService.getWasAgentLevelByRoleId(role);
			countB=wasRoleService.getUserIdByRoleId(role);
		} catch (Exception e) {
			return result;
		}
		if(countA==0&&countB==0){
			result=1;
		}
		return result;
	}
	
	/**
	 * 逻辑删除角色
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasRole:del")
	@ResponseBody
	@RequestMapping(value = "delete")
	public Integer  delete(Role role,String menuIdA) {
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal(); 
		int result=0;
		
		result=wasRoleService.deleteByLogic(role);
		wasAgentSystemLogService.insert(new WasAgentSystemLog(menuIdA, new Date(), principal.getId(),"用户"+principal.getLoginName()+"删除了角色的id为"+role.getId()));              	
	
		return result;
	}
	
	@ResponseBody
	@RequestMapping(value = "getRole")
	public Role  getRole(String id) {
		 //包括角色对应的菜单列表集合
		return	systemService.getRole(id); 
	}
	
	/**
	 * 权限修改
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasRole:power")
	@ResponseBody
	@RequestMapping(value = "saveMenu")
	public Integer saveMenu(Role role,String menuIdB) {
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal(); 
		int result=0;
		
		roleDao.deleteRoleMenu(role);
		if (role.getMenuList().size() > 0){
			roleDao.insertRoleMenu(role);
		}
		wasAgentSystemLogService.insert(new WasAgentSystemLog(menuIdB, new Date(), principal.getId(),"用户"+principal.getLoginName()+"编辑了角色的id为"+role.getId()+"的权限"));              	
		// 清除权限缓存
		systemRealm.clearAllCachedAuthorizationInfo();
	
		result=1;
		return result;
	}
}
