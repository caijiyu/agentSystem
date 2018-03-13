/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;

import java.util.Date;
import java.util.List;

import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasSoftwareModifyPrice;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasSoftwareModifyPriceService;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 软件修改价Controller
 * @author HJT
 * @version 2017-09-29
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/wasSoftwareModifyPrice")
public class WasSoftwareModifyPriceController extends BaseController {

	@Autowired
	private WasSoftwareModifyPriceService wasSoftwareModifyPriceService;
	
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	/**
	 * 列表页面
	 */
	@RequiresPermissions("sysdata:wasSoftwareModifyPrice:list")
	@RequestMapping(value = "list")
	public String list(WasSoftwareModifyPrice wasSoftwareModifyPrice,Model model) {
		wasSoftwareModifyPrice.setState(true);
		List<WasSoftwareModifyPrice> modifyPriceList=wasSoftwareModifyPriceService.findList(wasSoftwareModifyPrice);
		model.addAttribute("modifyPriceList", modifyPriceList);
		return "modules/agentsystem/sysdata/wasSoftwareModifyPrice";
	}

	
	/**
	 * 保存软件修改价
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions(value= {"sysdata:wasSoftwareModifyPrice:edit","sysdata:wasSoftwareModifyPrice:add"})
	@RequestMapping(value = "save")
	@ResponseBody
	public Integer save(String menuId,User user,WasSoftwareModifyPrice wasSoftwareModifyPrice, Model model,Integer modifypriceId) {
		Integer result;
		String a="";
		wasSoftwareModifyPrice.setState(true);
		Principal principal = UserUtils.getPrincipal();
		user.setId(principal.getId());
		wasSoftwareModifyPrice.setUpdateBy(user);
		wasSoftwareModifyPrice.setUpdateDate(new Date());
		if(modifypriceId !=null){
			result=wasSoftwareModifyPriceService.updateModifyPrice(wasSoftwareModifyPrice);
			if(wasSoftwareModifyPrice.getIsNewRecord()) {
				wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
				new Date(),principal.getId(),"用户"+principal.getLoginName()+"编辑软件修改价ID为"+modifypriceId));	
			}
		}else{
			wasSoftwareModifyPrice.setCreateDate(new Date());
			wasSoftwareModifyPrice.setCreateId(principal.getId());
			 result=wasSoftwareModifyPriceService.saveModifyPrice(wasSoftwareModifyPrice);
			 if(wasSoftwareModifyPrice.getIsNewRecord()) {
				 if(wasSoftwareModifyPrice.getClassify()) {
					 a="小程序";
				 }else {
					 a="公众号";
				 }
					wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
					new Date(),principal.getId(),"用户"+principal.getLoginName()+"添加了所属分类为"+a+"价格为"+wasSoftwareModifyPrice.getPrice()));	
				}
		}
		return result;
	}
	
	/**
	 * 逻辑删除
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("sysdata:wasSoftwareModifyPrice:del")
	@RequestMapping(value = "delete")
	@ResponseBody
	public Integer delete(WasSoftwareModifyPrice wasSoftwareModifyPrice,String menuId) {
		wasSoftwareModifyPrice.setState(false);
		Principal principal = UserUtils.getPrincipal();
		Integer result=wasSoftwareModifyPriceService.deleteByLogicModifyPrice(wasSoftwareModifyPrice);
		if(wasSoftwareModifyPrice.getIsNewRecord()) {
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId,
			new Date(),principal.getId(),"用户"+principal.getLoginName()+"删除软件修改价ID为"+wasSoftwareModifyPrice.getModifypriceId()));	
		}
		return result;
	}
	
	/**
	 * 根据Id找实体,编辑
	 */
	@RequiresPermissions("sysdata:wasSoftwareModifyPrice:edit")
	@RequestMapping(value = "findEntiy")
	@ResponseBody
	public WasSoftwareModifyPrice findEntiy(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		WasSoftwareModifyPrice modifyPrice=wasSoftwareModifyPriceService.findModifyPrice(wasSoftwareModifyPrice);
		return modifyPrice;
	}
	@ResponseBody
	@RequestMapping(value = "validate")
	public boolean validateMobileExist(WasSoftwareModifyPrice wasSoftwareModifyPrice) {
		Integer num = wasSoftwareModifyPriceService.getNum(wasSoftwareModifyPrice);
		if(num>0){
		    	return false;
		    }else{
			    return true;
		    }
	}
}