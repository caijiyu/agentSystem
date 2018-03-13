/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSalesPolicy;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentLevelService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSalesPolicyService;
import com.jeeplus.modules.sys.entity.Role;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 代理商等级Controller
 * @author HJT
 * @version 2017-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/agentsystem/wasAgentLevel")
public class WasAgentLevelController extends BaseController {

	@Autowired
	private WasAgentLevelService wasAgentLevelService;
	@Autowired
	private WasSalesPolicyService wasSalesPolicyService;
	
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	/**
	 * 代理商等级列表页面
	 */
	@RequiresPermissions("sysdata:wasAgentLevel:list")
	@RequestMapping(value = "list")
	public String list(WasAgentLevel wasAgentLevel, HttpServletRequest request, HttpServletResponse response, Model model) {
		Page<WasAgentLevel> page = wasAgentLevelService.findPage(new Page<WasAgentLevel>(request, response), wasAgentLevel); 
		model.addAttribute("page", page);
		return "modules/agentsystem/sysdata/wasAgentLevel";
	}

	
	/**
	 * 保存代理商等级
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agentsystem:wasAgentLevel:add")
	@RequestMapping(value = "save")
	@ResponseBody
	public Integer save(WasAgentLevel wasAgentLevel, Model model,User user,String menuId) {
		wasAgentLevel.setState(1);
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		wasAgentLevel.setCreateDate(new Date());
		wasAgentLevel.setUpdateDate(new Date());
		wasAgentLevel.setCreateBy(user);
		wasAgentLevel.setUpdateBy(user);
		Integer result=wasAgentLevelService.saveAgentLevel(wasAgentLevel);
		if(wasAgentLevel.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"添加了代理商等级"+wasAgentLevel.getName()));	
		}
		return result;
	}
	/**
	 *获取代理商角色 
	 */
	@RequestMapping(value = "getRole")
	@ResponseBody
	public List<Role> getRole() {
		String roleType="代理商";
		List<Role> list=wasAgentLevelService.getroleType( roleType);
		return list;
	}
	/**
	 * 根据roleId查看是否有下放代理商的权限
	 */
	@RequestMapping(value = "judge")
	@ResponseBody
	public Integer count(String permissionA,String permissionB,String id) {
		permissionA="agency:wasSysUser:list";
		permissionB="agency:wasAgentApply:list";
		Integer result=wasAgentLevelService.whetherPermission(permissionA, permissionB, id);
		return result;
	}
	/**
	 * 删除代理商等级
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasAgentLevel:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(WasAgentLevel wasAgentLevel,Integer agentLevelId,String menuId) {
		wasAgentLevel.setState(0);
		Principal principal = UserUtils.getPrincipal();
		Integer result=wasAgentLevelService.deleteAgentLevel(wasAgentLevel);
		if(wasAgentLevel.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"删除了代理商等级ID为"+agentLevelId));	
		}
		return result;
	}
	/**
	 * 删除判断
	 */
	@RequestMapping(value = "judgeDel")
	@ResponseBody
	public Integer judgeDel(Integer agentLevelId) {
		Integer sum=wasAgentLevelService.wasAgentLevelSum(agentLevelId);
		return sum;
	}
	/**
	 * 查找所有销售方针
	 */
	@RequestMapping(value = "findAllPolicy")
	@ResponseBody
	public List<Object> findAllPolicy(WasSalesPolicy wasSalesPolicy,Integer agentLevelId,WasAgentLevel wasAgentLevel){
		List<Object> totalList=new ArrayList<Object>();
		wasAgentLevel = wasAgentLevelService.getEnity(agentLevelId);
		List<WasSalesPolicy> list=wasSalesPolicyService.getUnexpiredPolicy(wasSalesPolicy);
		totalList.add(wasAgentLevel);
		totalList.add(list);
		return totalList;
	}
	/**
	 * 更新分配销售方针
	 */
	
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasAgentLevel:fap")
	@RequestMapping(value = "update")
	@ResponseBody
	public Integer update(WasAgentLevel wasAgentLevel,User user,String menuId) {
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		wasAgentLevel.setUpdateBy(user);
		wasAgentLevel.setUpdateDate(new Date());
		Integer result=wasAgentLevelService.updateAgentLevel(wasAgentLevel);
		if(wasAgentLevel.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"更新了代理商等级ID为"+wasAgentLevel.getAgentLevelId()+"的销售方针为"+wasAgentLevel.getSalesPolicyIds()));	
		}
		return result;
	}
	/**
	 * 根据id查找实体
	 */
	@RequestMapping(value = "getAgentLevelEnity")
	@ResponseBody
	public WasAgentLevel getAgentLevelEnity(Integer agentLevelId,WasAgentLevel wasAgentLevel) {
		wasAgentLevel=wasAgentLevelService.getEnity(agentLevelId);
		return wasAgentLevel;
	}
	/**
	 *验证等级名称不能重复 
	 */
	@ResponseBody
	@RequestMapping(value = "validate")
	public boolean validate(WasAgentLevel wasAgentLevel) {
		String name=wasAgentLevel.getName();
		Integer num=wasAgentLevelService.getNum(name);
		if(num>0){
		    	return false;
		    }else{
			    return true;
		    }
	}
	
/**
 * 查看
 */
	@RequiresPermissions("sysdata:wasAgentLevel:look")
	@ResponseBody
	@RequestMapping(value = "lookover")
	public List<Object> lookOver(Integer agentLevelId,WasAgentLevel wasAgentLevel,Role role) {
		String title="";
		List<Object> list=new ArrayList<Object>();
		List<String> li=new ArrayList<String>();
		wasAgentLevel=wasAgentLevelService.getEnity(agentLevelId);
		role=wasAgentLevelService.findRoleEnity(wasAgentLevel.getRoleId());
		if(wasAgentLevel.getSalesPolicyIds() !=null && !"".equals(wasAgentLevel.getSalesPolicyIds())) {
		String[] idArry=wasAgentLevel.getSalesPolicyIds().split(",");
		for(String id : idArry) {
			 title=wasSalesPolicyService.findWasSalesPolicy(Integer.parseInt(id)).getTitle();
			li.add(title);
		    }
		 }
		list.add(wasAgentLevel);
		list.add(role.getName());
		list.add(li);
		return list;
	}
}