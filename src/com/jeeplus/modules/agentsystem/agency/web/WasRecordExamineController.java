package com.jeeplus.modules.agentsystem.agency.web;

import java.math.BigDecimal;

import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasConsumeSynthesis;
import com.jeeplus.modules.agentsystem.agency.entity.WasInvoiceApplication;
import com.jeeplus.modules.agentsystem.agency.entity.WasRechargeHistory;
import com.jeeplus.modules.agentsystem.agency.service.WasConsumeSynthesisService;
import com.jeeplus.modules.agentsystem.agency.service.WasExpendPayService;
import com.jeeplus.modules.agentsystem.agency.service.WasInvoiceApplicationService;
import com.jeeplus.modules.agentsystem.agency.service.WasPolicyPurchaseService;
import com.jeeplus.modules.agentsystem.agency.service.WasRechargeHistoryService;

/**
 * 记录查看Controller
 * @author SZP
 * @version 2017-10-08
 */
@Controller
@RequestMapping(value = "${adminPath}/agentSystem/RecordExamine")
public class WasRecordExamineController  extends BaseController {

	@Autowired
	private WasRechargeHistoryService rechargeHistoryService;
	@Autowired
	private WasConsumeSynthesisService consumeSynthesisService;
	@Autowired
	private WasInvoiceApplicationService wasInvoiceApplicationService;
	
	@Autowired
	WasPolicyPurchaseService policyPurchaseService;
	@Autowired
	WasExpendPayService expendPayService;
	
	
	/**
	 * 记录查看页面
	 */
	/*@RequiresPermissions("agentSystem:wasAgentRecord:look")*/
	@RequestMapping(value = {"list", ""})
	public String list(WasConsumeSynthesis consumeSynthesis,WasRechargeHistory rechargeHistory, Date startDateA , Date endDateA , Date startDateB , Date endDateB,Date startDateC , Date endDateC,
			WasInvoiceApplication wasInvoiceApplication, HttpServletRequest request, HttpServletResponse response,String userId,
			Model model, String companyName,Integer pageNoA,Integer pageNoB,Integer pageNoC,Integer pageSizeA,Integer pageSizeB,Integer pageSizeC) {
		model.addAttribute("userId",userId);
		
		//将页面搜索的开始时间和结束时间放入实体中
		rechargeHistory.setStartDate(startDateA);
		rechargeHistory.setEndDate(endDateA);
		//判断pageNoA是否null，为null则设置其为1
		if(pageNoA == null){
			pageNoA = 1;
		}
		//判断pageSizeA是否null，为null则设置其为10
		if(pageSizeA == null){
			pageSizeA = 10;
		}
		Page<WasRechargeHistory> pageA = rechargeHistoryService.findPage(new Page<WasRechargeHistory>(pageNoA,pageSizeA), rechargeHistory);
		//遍历pageA.getList()集合
		int numA = 0;
		for(WasRechargeHistory rh : pageA.getList()){
			numA++;
			BigDecimal amount = new BigDecimal("0.00");
			//判断此条充值记录，公众号中有没充值金额
			if(rh.getPublicRecharge().compareTo(BigDecimal.ZERO) != 0){
				//计算充值总额
				amount = amount.add(rh.getPublicRecharge());
				rh.setRechargeDirection("公众号");
			}
			//判断此条充值记录，硬件中有没充值金额
			if(rh.getHardwareRecharge().compareTo(BigDecimal.ZERO) != 0){
				//计算充值总额
				amount = amount.add(rh.getHardwareRecharge());
				//判断充值去向是否为null
				if(rh.getRechargeDirection() != null){
					rh.setRechargeDirection(rh.getRechargeDirection()+"、硬件");
				}else{
					rh.setRechargeDirection("硬件");
				}
			}
			//判断此条充值记录，小程序中有没充值金额
			if(rh.getMinaRecharge().compareTo(BigDecimal.ZERO) != 0){
				//计算充值总额
				amount = amount.add(rh.getMinaRecharge());
				//判断充值去向是否为null
				if(rh.getRechargeDirection() != null){
					rh.setRechargeDirection(rh.getRechargeDirection()+"、小程序");
				}else{
					rh.setRechargeDirection("小程序");
				}
			}
			//判断此条充值记录，VIP中有没充值金额
			if(rh.getVipRecharge().compareTo(BigDecimal.ZERO) != 0){
				//计算充值总额
				amount = amount.add(rh.getVipRecharge());
				//判断充值去向是否为null
				if(rh.getRechargeDirection() != null){
					rh.setRechargeDirection(rh.getRechargeDirection()+"、VIP");
				}else{
					rh.setRechargeDirection("VIP");
				}
			}
			//判断此条充值记录，押金中有没充值金额
			if(rh.getCashRecharge().compareTo(BigDecimal.ZERO) != 0){
				//计算充值总额
				amount = amount.add(rh.getCashRecharge());
				//判断充值去向是否为null
				if(rh.getRechargeDirection() != null){
					rh.setRechargeDirection(rh.getRechargeDirection()+"、押金");
				}else{
					rh.setRechargeDirection("押金");
				}
			}
			//判断最后所得的充值金额是否为空
			if(amount.compareTo(BigDecimal.ZERO) == 0){
				rh.setRechargeDirection("此次充值无效");
			}
			//将最后所得的充值总额放入此条充值记录对象中
			rh.setAmount(amount);
		}
		model.addAttribute("numA",numA);
		pageA.setFuncName("pageA");
		model.addAttribute("rechargeHistory", rechargeHistory);
		model.addAttribute("receivedUserId",rechargeHistory.getReceivedUserId());
		model.addAttribute("companyName",companyName);
		model.addAttribute("pageA", pageA);
		model.addAttribute("pageNoA", pageA.getPageNo());
		model.addAttribute("pageSizeA", pageA.getPageSize());
		
		//将页面搜索的开始时间和结束时间放入实体中
		consumeSynthesis.setStartDate(startDateB);
		consumeSynthesis.setEndDate(endDateB);
		consumeSynthesis.setUserId(rechargeHistory.getReceivedUserId());
		//判断pageNoB是否null，为null则设置其为1
		if(pageNoB == null){
			pageNoB = 1;
		}
		//判断pageSizeB是否null，为null则设置其为10
		if(pageSizeB == null){
			pageSizeB = 10;
		}
		Page<WasConsumeSynthesis> pageB = consumeSynthesisService.findPage(new Page<WasConsumeSynthesis>(pageNoB,pageSizeB), consumeSynthesis);
		int numB = pageB.getList().size();
		model.addAttribute("numB",numB);
		pageB.setFuncName("pageB");
		model.addAttribute("consumeSynthesis", consumeSynthesis);
		model.addAttribute("pageB", pageB);
		model.addAttribute("pageNoB", pageB.getPageNo());
		model.addAttribute("pageSizeB", pageB.getPageSize());
		
		//将页面搜索的开始时间和结束时间放入实体中
		wasInvoiceApplication.setStartDate(startDateC);
		wasInvoiceApplication.setEndDate(endDateC);
		int state = 1;
		Integer orderFlag= 2;
		wasInvoiceApplication.setState(state);
		wasInvoiceApplication.setCompanyName(null);
		wasInvoiceApplication.setApplyBy(rechargeHistory.getReceivedUserId());
		wasInvoiceApplication.setOrderFlag(orderFlag);
		//判断pageNoC是否null，为null则设置其为1
		if(pageNoC == null){
			pageNoC = 1;
		}
		//判断pageSizeC是否null，为null则设置其为10
		if(pageSizeC == null){
			pageSizeC = 10;
		}
		Page<WasInvoiceApplication> pageC = wasInvoiceApplicationService.findPage(new Page<WasInvoiceApplication>(pageNoC, pageSizeC), wasInvoiceApplication); 
		int numC = pageC.getList().size();
		model.addAttribute("numC",numC);
		pageC.setFuncName("pageC");
		model.addAttribute("wasInvoiceApplication", wasInvoiceApplication);
		model.addAttribute("pageC", pageC);
		model.addAttribute("pageNoC", pageC.getPageNo());
		model.addAttribute("pageSizeC", pageC.getPageSize());
		
		return "modules/agentsystem/agency/wasRecordExamine";
	}
	
	/**
	 * 代理商首页消耗折线图
	 */
	@SuppressWarnings("rawtypes")
	@ResponseBody
	@RequestMapping(value = "homePageList")
	public List<List> homePageList(WasConsumeSynthesis consumeSynthesis,HttpServletRequest request, HttpServletResponse response) {
		
		List<BigDecimal> publicList = new ArrayList<BigDecimal>();
		List<BigDecimal> minaList = new ArrayList<BigDecimal>();
		List<BigDecimal> hardwareList = new ArrayList<BigDecimal>();
		List<BigDecimal> vipList = new ArrayList<BigDecimal>();
		//获取当前日期
		Calendar today = Calendar.getInstance();
		//获取当前日期
		Calendar endToday = Calendar.getInstance();
		/*//获取当月最后一天（当月天数）
		int lastDay = today.getActualMaximum(Calendar.DAY_OF_MONTH);*/
		 
		//获取当前日期（即当前是几号）
		int count = today.get(Calendar.DAY_OF_MONTH);
		for(int i = 0;i <= count;i++){
			//设置查询开始日期
			today.set(Calendar.DAY_OF_MONTH,i+1);
			today.set(Calendar.HOUR_OF_DAY, 0);
			today.set(Calendar.MINUTE, 0);
			today.set(Calendar.SECOND, 0);
			today.set(Calendar.MILLISECOND, 0);
			//转换为date型
			java.util.Date startDate = today.getTime();
			//将日期分别放入对象中
			consumeSynthesis.setStartDate(startDate);
			//=================================================
			//设置查询结束日期
			endToday.set(Calendar.DAY_OF_MONTH,i+1);
			/*if(endToday.get(Calendar.DAY_OF_MONTH) >= lastDay){
				//设置当前日期为最后一天的23时59分59秒，即本月的最后一天最后一刻
				endToday.set(Calendar.DAY_OF_MONTH,lastDay);
			}*/
			endToday.set(Calendar.HOUR_OF_DAY, 23);
			endToday.set(Calendar.MINUTE, 59);
			endToday.set(Calendar.SECOND, 59);
			endToday.set(Calendar.MILLISECOND, 999);
			//转换为date型
			java.util.Date endDate = endToday.getTime();
			//将日期分别放入对象中
			consumeSynthesis.setEndDate(endDate);
			//调用page的方法返回结果集
			List<WasConsumeSynthesis> conList = consumeSynthesisService.findList(consumeSynthesis);
			//公众号消耗
			BigDecimal publicExpend = new BigDecimal("0.00");
			//小程序消耗
			BigDecimal minaExpend = new BigDecimal("0.00");
			//硬件消耗
			BigDecimal hardwareExpend = new BigDecimal("0.00");
			//VIP消耗
			BigDecimal vipExpend = new BigDecimal("0.00");
			//遍历集合分别把公众号消耗、硬件消耗、小程序消耗、VIP消耗累计相加
			for(WasConsumeSynthesis cos :conList){
				publicExpend = cos.getPublicExpend().add(publicExpend);
				minaExpend = cos.getMinaExpend().add(minaExpend);
				hardwareExpend = cos.getHardwareExpend().add(hardwareExpend);
				vipExpend = cos.getVipExpend().add(vipExpend);
			}
			//把同一天的公众号消耗、硬件消耗、小程序消耗、VIP消耗分别放入各自的集合中
			publicList.add(publicExpend);
			minaList.add(minaExpend);
			hardwareList.add(hardwareExpend);
			vipList.add(vipExpend);
		}
		//把公众号消耗、硬件消耗、小程序消耗、VIP消耗的集合的第一个值都设为0.00
		publicList.add(0,new BigDecimal("0.00"));
		minaList.add(0,new BigDecimal("0.00"));
		hardwareList.add(0,new BigDecimal("0.00"));
		vipList.add(0,new BigDecimal("0.00"));
		//把公众号消耗、硬件消耗、小程序消耗、VIP消耗的集合放入list返回页面
		List<List> list = new ArrayList<List>();
		list.add(publicList);
		list.add(hardwareList);
		list.add(minaList);
		list.add(vipList);
		return list;
	}
	
}
