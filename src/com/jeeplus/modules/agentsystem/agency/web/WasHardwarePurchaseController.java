package com.jeeplus.modules.agentsystem.agency.web;

import java.math.BigDecimal;
import java.text.ParseException;
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

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasHardwarePurchase;
import com.jeeplus.modules.agentsystem.agency.entity.WasSysUser;
import com.jeeplus.modules.agentsystem.agency.service.WasHardwarePurchaseService;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasAgentSystemLog;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasHardware;
import com.jeeplus.modules.agentsystem.sysdata.service.WasAgentSystemLogService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasHardwareService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasUserService;
import com.jeeplus.modules.agentsystem.utils.KdniaoSubscribeAPI;
import com.jeeplus.modules.agentsystem.utils.MoneyOperation;
import com.jeeplus.modules.agentsystem.utils.OrderNumberUtils;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;
import com.jeeplus.modules.sys.utils.UserUtils;

import net.sf.json.JSONObject;

/**
 * 硬件购买记录Controller
 * @author: YeJR
 * @date: 2017年9月28日 下午2:50:20
 * @version 1.0
 */
@Controller
@RequestMapping(value = "${adminPath}/hardware/hardwarePurchase")
public class WasHardwarePurchaseController extends BaseController {

	@Autowired
	private WasHardwarePurchaseService wasHardwarePurchaseService;
	@Autowired
	private WasHardwareService wasHardwareService;
	@Autowired
	private WasAgentSystemLogService agentSystemLogService;
	@Autowired
	private WasUserService wasUserService;
	@Autowired
	private WasAgentSystemLogService wasAgentSystemLogService;
	/**
	 * 代理商
	 */
	private  static final String  AGENCY="代理商";
	
	/**
	 * 硬件购买自提列表
	 * @param wasHardwarePurchase
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("agency:wasHardwarePurchase:selfList")
	@RequestMapping(value = {"selfList"})
	public String selfList(WasHardwarePurchase wasHardwarePurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		//按照下单时间排序
		wasHardwarePurchase.setOrderingRule(0);
		//设置查看自提状态的订单
		wasHardwarePurchase.setDeliveryMethod(false);
		//查看未发货的订单
		wasHardwarePurchase.setSendState(0);
		//查看未被删除状态下的订单
		wasHardwarePurchase.setState(true);
		
		//判断当前登录进来的是哪个角色
		Principal principal = UserUtils.getPrincipal();
		String userId = principal.getId();
		WasSysUser sysUser = wasUserService.get(userId);
		if (sysUser.getRoleList().get(0).getRoleType().equals(AGENCY)) {
			wasHardwarePurchase.setUserId(userId);
		}
		
		String name = wasHardwarePurchase.getPurchasedCompanyName();
		wasHardwarePurchase.setPurchasedCompanyName(StringChangeUtils.specialStr(name));
		Page<WasHardwarePurchase> page = wasHardwarePurchaseService.findPage(new Page<WasHardwarePurchase>(request, response), wasHardwarePurchase); 
		wasHardwarePurchase.setPurchasedCompanyName(name);
		model.addAttribute("page", page);
        return "modules/agentsystem/agency/wasHardwarePurchaseSelfList";
	}
	
	/**
	 * 硬件购买待发货列表
	 * @param wasHardwarePurchase
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("agency:wasHardwarePurchase:sendList")
	@RequestMapping(value = {"sendList"})
	public String sendList(WasHardwarePurchase wasHardwarePurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		//按照下单时间排序
		wasHardwarePurchase.setOrderingRule(0);
		//设置查看快递状态的订单
		wasHardwarePurchase.setDeliveryMethod(true);
		//查看未发货的订单
		wasHardwarePurchase.setSendState(0);
		//查看未被删除状态下的订单
		wasHardwarePurchase.setState(true);
		
		//判断当前登录进来的是哪个角色
		Principal principal = UserUtils.getPrincipal();
		String userId = principal.getId();
		WasSysUser sysUser = wasUserService.get(userId);
		if (sysUser.getRoleList().get(0).getRoleType().equals(AGENCY)) {
			wasHardwarePurchase.setUserId(userId);
		}
		
		String name = wasHardwarePurchase.getPurchasedCompanyName();
		wasHardwarePurchase.setPurchasedCompanyName(StringChangeUtils.specialStr(name));
		Page<WasHardwarePurchase> page = wasHardwarePurchaseService.findPage(new Page<WasHardwarePurchase>(request, response), wasHardwarePurchase); 
		wasHardwarePurchase.setPurchasedCompanyName(name);
		model.addAttribute("page", page);
        return "modules/agentsystem/agency/wasHardwarePurchaseSendList";
	}
	
	/**
	 * 硬件购买已发货列表
	 * @param wasHardwarePurchase
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("agency:wasHardwarePurchase:sendedList")
	@RequestMapping(value = {"sendedList"})
	public String sendedList(WasHardwarePurchase wasHardwarePurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		//按照下单时间排序
		wasHardwarePurchase.setOrderingRule(0);
		//设置查看快递状态的订单
		wasHardwarePurchase.setDeliveryMethod(true);
		//查看未发货的订单
		wasHardwarePurchase.setSendState(1);
		//查看未被删除状态下的订单
		wasHardwarePurchase.setState(true);
		
		//判断当前登录进来的是哪个角色
		Principal principal = UserUtils.getPrincipal();
		String userId = principal.getId();
		WasSysUser sysUser = wasUserService.get(userId);
		if (sysUser.getRoleList().get(0).getRoleType().equals(AGENCY)) {
			wasHardwarePurchase.setUserId(userId);
		}
		
		String name = wasHardwarePurchase.getPurchasedCompanyName();
		wasHardwarePurchase.setPurchasedCompanyName(StringChangeUtils.specialStr(name));
		Page<WasHardwarePurchase> page = wasHardwarePurchaseService.findPage(new Page<WasHardwarePurchase>(request, response), wasHardwarePurchase); 
		wasHardwarePurchase.setPurchasedCompanyName(name);
		model.addAttribute("page", page);
        return "modules/agentsystem/agency/wasHardwarePurchaseSendedList";
	}
	
	/**
	 * 硬件购买已完成列表
	 * @param wasHardwarePurchase
	 * @param request
	 * @param response
	 * @param model
	 * @return
	 */
	@RequiresPermissions("agency:wasHardwarePurchase:finishList")
	@RequestMapping(value = {"finishList"})
	public String finishList(WasHardwarePurchase wasHardwarePurchase, HttpServletRequest request, HttpServletResponse response, Model model) {
		//按照下单时间排序
		wasHardwarePurchase.setOrderingRule(2);
		//查看已完成的订单
		wasHardwarePurchase.setSendState(2);
		//查看未被删除状态下的订单
		wasHardwarePurchase.setState(true);
		
		//判断当前登录进来的是哪个角色
		Principal principal = UserUtils.getPrincipal();
		String userId = principal.getId();
		WasSysUser sysUser = wasUserService.get(userId);
		if (sysUser.getRoleList().get(0).getRoleType().equals(AGENCY)) {
			wasHardwarePurchase.setUserId(userId);
		}
				
		String name = wasHardwarePurchase.getPurchasedCompanyName();
		wasHardwarePurchase.setPurchasedCompanyName(StringChangeUtils.specialStr(name));
		Page<WasHardwarePurchase> page = wasHardwarePurchaseService.findPage(new Page<WasHardwarePurchase>(request, response), wasHardwarePurchase); 
		wasHardwarePurchase.setPurchasedCompanyName(name);
		model.addAttribute("page", page);
        return "modules/agentsystem/agency/wasHardwarePurchaseFinishList";
	}
	
	/**
	 * 查看表单页面
	 * @param wasHardwarePurchase
	 * @param model
	 * @return
	 */
	@RequiresPermissions(value={"agency:wasHardwarePurchase:selfView","agency:wasHardwarePurchase:sendView","agency:wasHardwarePurchase:sendedView","agency:wasHardwarePurchase:finishView"},logical=Logical.OR)
	@RequestMapping(value = "form")
	@ResponseBody
	public WasHardwarePurchase form(WasHardwarePurchase wasHardwarePurchase, Model model) {
		wasHardwarePurchase = wasHardwarePurchaseService.get(wasHardwarePurchase);
		return wasHardwarePurchase;
	}
	
	/**
	 * 确认，删除订单
	 * @param wasHardwarePurchase
	 * @param model
	 * @return
	 */
	@RequiresPermissions(value={"agency:wasHardwarePurchase:selfConfirm","agency:wasHardwarePurchase:selfDelete","agency:wasHardwarePurchase:sendDelete","agency:wasHardwarePurchase:sendedConfirm","agency:wasHardwarePurchase:finishDelete"},logical=Logical.OR)
	@RequestMapping(value = "updateState")
	@ResponseBody
	public int updateState(WasHardwarePurchase wasHardwarePurchase,String menuId, Model model) {
		int sendState = 2;
		if (wasHardwarePurchase.getSendState() != null && wasHardwarePurchase.getSendState() == sendState) {
			wasHardwarePurchase.setReceiveDate(new Date());
		} else if(!wasHardwarePurchase.getState()){
			Subject subject = SecurityUtils.getSubject();
			Principal principal = (Principal)subject.getPrincipal(); 
			wasAgentSystemLogService.insert(new WasAgentSystemLog(menuId, new Date(), principal.getId(),"用户"+principal.getLoginName()+"删除了硬件购买记录："+wasHardwarePurchase.getHardwarePurchaseId()));
		}
		int result = wasHardwarePurchaseService.saveData(wasHardwarePurchase);
		return result;
	}
	
	/**
	 * 订单发货
	 * @param wasHardwarePurchase
	 * @param model
	 * @return
	 */
	@RequiresPermissions(value={"agency:wasHardwarePurchase:sendOut"},logical=Logical.OR)
	@RequestMapping(value = "sendOut")
	@ResponseBody
	public int sendOut(WasHardwarePurchase wasHardwarePurchase, Model model) {
		wasHardwarePurchase.setSendState(1);
		wasHardwarePurchase.setDeliverDate(new Date());
		int result = wasHardwarePurchaseService.update(wasHardwarePurchase);
		return result;
	}
	
	/**
	 * 物流查看
	 * @param wasHardwarePurchase
	 * @param model
	 * @return
	 */
	@RequiresPermissions(value={"agency:wasHardwarePurchase:sendedLogistics"},logical=Logical.OR)
	@RequestMapping(value = "logistics")
	@ResponseBody
	public JSONObject logistics(String expressCoding,String expressNumber, Model model) {
		
		try {
			String requestData = "{'ShipperCode': '"+expressCoding+"'," + "'LogisticCode':'"+ expressNumber +"'}";
			String result = KdniaoSubscribeAPI.orderTracesSubByJson(requestData);
			JSONObject paramJson = JSONObject.fromObject(result);
			return paramJson;
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
			return null;
		}
	}
	
	/**
	 * 插入硬件购买记录
	 * @param wasHardwarePurchase
	 * @param model
	 * @return
	 * @throws ParseException 
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions(value={"agent:hardwarePurchase:buy"},logical=Logical.OR)
	@RequestMapping(value = "insertState")
	@ResponseBody
	public int insert(WasHardwarePurchase wasHardwarePurchase, Model model) throws ParseException{
		int result = 0;
		Principal principal = UserUtils.getPrincipal();
		wasHardwarePurchase.setUserId(principal.toString());
		wasHardwarePurchase.setCreateId(principal.toString());
		Date date = new Date();
		//硬件购买单号=H+时间戳(13位)
		wasHardwarePurchase.setOrderNo("H"+OrderNumberUtils.orderNumber());
		wasHardwarePurchase.setCreateDate(date);
		wasHardwarePurchase.setBehavior("硬件购买");
		wasHardwarePurchase.setPublicExpend(new BigDecimal(0));
		wasHardwarePurchase.setMinaExpend(new BigDecimal(0));
		/*-----------------插入硬件购买记录-----------------*/
		wasHardwarePurchaseService.save(wasHardwarePurchase);
		
		/*-----------------更新硬件卖出数量-----------------*/
		WasHardware wasHardware = wasHardwareService.get(wasHardwarePurchase.getHardwareId().toString());
		wasHardware.setSellNum(wasHardware.getSellNum()+wasHardwarePurchase.getNumber());
		wasHardwareService.updateSellNum(wasHardware);
		
		
		/*-----------------更新用户表记录-----------------*/
		String resultM = MoneyOperation.getInstance().moneyOperation(null,wasHardwarePurchase.getPublicExpend(), 
				wasHardwarePurchase.getMinaExpend(), wasHardwarePurchase.getHardwareExpend(), wasHardwarePurchase.getVipExpend(), wasHardwarePurchase.getUserId(), "扣钱");
		if(StringChangeUtils.OPERATION_SUCCESS.equals(resultM)){
			result = 1;
		}else{
			result = -1;
		}
		return result;
	}
	
	
	/**
	 * 硬件消费查看
	 */
	@ResponseBody
	@RequestMapping(value = "get")
	public WasHardwarePurchase get(WasHardwarePurchase hardwarePurchase,Model model) {
		hardwarePurchase = wasHardwarePurchaseService.get(hardwarePurchase);
		return hardwarePurchase;
	}
	
	/**
	 * 删除硬件记录
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	@RequiresPermissions("agentSystem:wasRecordExamine:consume:delete")
	@ResponseBody
	@RequestMapping(value = "deleteByLogic")
	public Integer deleteByLogic(WasHardwarePurchase hardwarePurchase,String menuId) {
		Integer result;
		Principal principal = UserUtils.getPrincipal();
		result = wasHardwarePurchaseService.deleteByLogic(hardwarePurchase);
		//删除成功插入日志
		agentSystemLogService.insert(new WasAgentSystemLog(menuId, new Date(), principal.toString(), "用户"+principal.getLoginName()+"删除了消费记录单号："+hardwarePurchase.getOrderNo()));
		return result;
	}
}