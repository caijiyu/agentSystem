/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;

import java.math.BigDecimal;
import java.math.RoundingMode;
import java.util.Arrays;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
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
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgelimit;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentLevel;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSalesPolicy;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftware;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgelimitService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentLevelService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSalesPolicyService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSoftwareService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;
import com.jeeplus.common.utils.StringUtils;

/**
 * 销售方针Controller
 * @author HJT
 * @version 2017-10-09
 */
@Controller
@RequestMapping(value = "${adminPath}/agentsystem/wasSalesPolicy")
public class WasSalesPolicyController extends BaseController {

	@Autowired
	private WasSalesPolicyService wasSalesPolicyService;
	
	@Autowired
	private WasSoftwareService wasSoftwareService;
	
	@Autowired
	private WasAgelimitService wasAgelimitService;
	
	@Autowired
	private WasAgentLevelService wasAgentLevelService;
	
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	@ModelAttribute
	public WasSalesPolicy get(@RequestParam(required=false) String id) {
		WasSalesPolicy entity = null;
		if (StringUtils.isNotBlank(id)){
			entity = wasSalesPolicyService.get(id);
		}
		if (entity == null){
			entity = new WasSalesPolicy();
		}
		return entity;
	}
	
	/**
	 * 添加，编辑
	 */
	@RequiresPermissions(value={"sysdata:wasSalesPolicy:add","sysdata:wasSalesPolicy:edit"},logical=Logical.OR)
	@RequestMapping(value = "form")
	public String findSoftware(WasAgentLevel wasAgentLevel,WasSalesPolicy wasSalesPolicy,WasSoftware wasSoftware,Model model,Integer salesPolicyId,Integer pageSize,Integer pageNo){
		if(salesPolicyId !=null){
			//判断此方针是否已分配
			List<WasAgentLevel> list=wasAgentLevelService.findList(wasAgentLevel);
			StringBuilder sb = new StringBuilder();
			for(WasAgentLevel wl : list) {
				sb.append(wl.getSalesPolicyIds()+",");
			}
			String[] idArray=sb.toString().split(",");
			boolean isContainso = Arrays.asList(idArray).contains(String.valueOf(salesPolicyId));
			if(isContainso) {
				model.addAttribute("judge","0");
			}
			wasSalesPolicy=wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
			model.addAttribute("WasSalesPolicy",wasSalesPolicy);
			model.addAttribute("pageSize",pageSize);
			model.addAttribute("pageNo",pageNo);
		}
		wasSoftware.setState(true);
		//查找所有小程序
		wasSoftware.setClassify(true);
		List<WasSoftware> miniApps=wasSoftwareService.findSoftwareList(wasSoftware);
		//查找所有公众号
		wasSoftware.setClassify(false);
		List<WasSoftware> officialAccounts=wasSoftwareService.findSoftwareList(wasSoftware);
		model.addAttribute("officialAccounts",officialAccounts);
		model.addAttribute("miniApps",miniApps);
		return "modules/agentsystem/sysdata/wasSalesPolicyForm";
	}
	
	
	
	/**
	 * 列表页面
	 */
	@RequiresPermissions("sysdata:wasSalesPolicy:list")
	@RequestMapping(value = "list")
	public String list(String title,WasSalesPolicy wasSalesPolicy, HttpServletRequest request, HttpServletResponse response, Model model) {
		wasSalesPolicy.setTitle(StringChangeUtils.specialStr(wasSalesPolicy.getTitle()));
		Page<WasSalesPolicy> page = wasSalesPolicyService.findPage(new Page<WasSalesPolicy>(request, response), wasSalesPolicy); 
		model.addAttribute("titlea",title);
		model.addAttribute("page", page);
		return "modules/agentsystem/sysdata/wasSalesPolicyList";
	}

	

	/**
	 * 保存
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions(value={"sysdata:wasSalesPolicy:add","sysdata:wasSalesPolicy:edit"})
	@RequestMapping(value = "save")
	@ResponseBody
	public Integer save(String menuId,WasSalesPolicy wasSalesPolicy, Model model,User user,String policyClassify,Integer salesPolicyId) {
		Integer result;
		//根据页面传过来的参数判断所属分类
		String[] idArray =policyClassify.split(",");
		boolean isContainso = Arrays.asList(idArray).contains("1");
		boolean isContainsz = Arrays.asList(idArray).contains("0");
		if(isContainso && isContainsz){
			wasSalesPolicy.setClassify(2);
		}else{
			if(isContainso){
				wasSalesPolicy.setClassify(1);
			}else{
				wasSalesPolicy.setClassify(0);
			}
		}
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		
		BigDecimal ten = new BigDecimal("10"); 
		wasSalesPolicy.setRenewDiscount(wasSalesPolicy.getRenewDiscount().divide(ten,2,RoundingMode.HALF_UP));
		if(salesPolicyId !=null) {
			wasSalesPolicy.setUpdateBy(user);
			wasSalesPolicy.setUpdateDate(new Date());
			result=wasSalesPolicyService.updateSalesPolicy(wasSalesPolicy);
			if(wasSalesPolicy.getIsNewRecord()) {
				wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
				new Date(),principal.getId(),"用户"+principal.getLoginName()+"编辑了销售方针"+wasSalesPolicy.getTitle()));	
			}
		}else {
			wasSalesPolicy.setCreateDate(new Date());
			wasSalesPolicy.setUpdateDate(new Date());
			wasSalesPolicy.setCreateBy(user);
			wasSalesPolicy.setUpdateBy(user);
			result=wasSalesPolicyService.saveSalesPolicy(wasSalesPolicy);
			if(wasSalesPolicy.getIsNewRecord()) {
				wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
				new Date(),principal.getId(),"用户"+principal.getLoginName()+"添加了销售方针"+wasSalesPolicy.getTitle()));	
			}
		}
		return result;
	}
	
	/**
	 * 逻辑删除售方针
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasSalesPolicy:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(String menuId,String salesPolicyId,WasSalesPolicy wasSalesPolicy,WasAgentLevel wasAgentLevel) {
		Integer result;
		Principal principal = UserUtils.getPrincipal();
		List<WasAgentLevel> list=wasAgentLevelService.findList(wasAgentLevel);
		StringBuilder sb = new StringBuilder();
		for(WasAgentLevel wl : list) {
			sb.append(wl.getSalesPolicyIds()+",");
		}
		String[] idArray=sb.toString().split(",");
		boolean isContainso = Arrays.asList(idArray).contains(salesPolicyId);
		if(isContainso) {
			result=-1;
			return result;
		}
		wasSalesPolicy.setState(false);
		 result=wasSalesPolicyService.deleteByLogic(wasSalesPolicy);
		 if(wasSalesPolicy.getIsNewRecord()) {
				wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
				new Date(),principal.getId(),"用户"+principal.getLoginName()+"删除了销售方针ID为"+salesPolicyId));	
			}
		return result;
	}
	/**
	 * 查看
	 */
	@RequiresPermissions("sysdata:wasSalesPolicy:look")
	@RequestMapping(value = "lookover")
	public String lookOver(Integer salesPolicyId,WasSalesPolicy wasSalesPolicy,Model model,Integer pageNo,Integer pageSize){
		wasSalesPolicy=wasSalesPolicyService.findWasSalesPolicy(salesPolicyId);
		String[] idArray =wasSalesPolicy.getSoftwareIds().split(",");
		 StringBuilder sb = new StringBuilder();
		for(String id : idArray) {
			WasSoftware wasSoftware=wasSoftwareService.findSoftwareById(Integer.parseInt(id));
			//小程序
			if(wasSoftware.getClassify()==true) {
				sb.append(wasSoftware.getName()+"(小程序)+");
			}else if(wasSoftware.getClassify() ==false) {
				sb.append(wasSoftware.getName()+"(公众号)+");
			}
			
		}
		String softwares=sb.toString().substring(0,sb.length()-1);
		wasSalesPolicy.setSoftwareIds(softwares);
		model.addAttribute("WasSalesPolicy",wasSalesPolicy);
		model.addAttribute("pageSize",pageSize);
		model.addAttribute("pageNo",pageNo);
		return "modules/agentsystem/sysdata/wasSalesPolicyLook";
	}
	//根据所选产品计算总价格
	@RequestMapping(value = "total")
	@ResponseBody
	public BigDecimal totalPrice(String softwareIds,WasSoftware wasSoftware) {
		BigDecimal money = new BigDecimal(Double.toString(0.00));
		if(!"".equals(softwareIds) && softwareIds !=null) {
		String[] idArray =softwareIds.split(",");
		for(String id : idArray) {
			wasSoftware=wasSoftwareService.findSoftwareById(Integer.parseInt(id));
            money=money.add(wasSoftware.getPrice());
		}
		  }
		return money;
	}
	//根据所选产品计算总价格
		@RequestMapping(value = "findYear")
		@ResponseBody
		public List<WasAgelimit> findAllYear(WasAgelimit wasAgelimit){
			List<WasAgelimit> ageList=wasAgelimitService.findList(wasAgelimit);
			return ageList;
		}
	//验证套餐名
		@RequestMapping(value = "validateTitle")
		@ResponseBody
	public Boolean validateTitle(WasSalesPolicy wasSalesPolicy,Integer salesPolicyId) {
			String oldTitle=wasSalesPolicy.getRemarks();
			String title=wasSalesPolicy.getTitle();
		if(salesPolicyId !=null) {
			if(title.equals(oldTitle)) {
				return true;
			}else {
				if(wasSalesPolicyService.findTitleNum(title)>0) {
					return false;
				}else {
					return true;
				}
			}
			
		}else {
			if(wasSalesPolicyService.findTitleNum(title)>0) {
				return false;
			}else {
				return true;
			}
		}
	}
}