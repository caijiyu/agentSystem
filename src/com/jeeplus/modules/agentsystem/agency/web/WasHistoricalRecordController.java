package com.jeeplus.modules.agentsystem.agency.web;


/**
 * 历史纪录消费Controller
 * @author Wb
 * @version 2017-9-29
 */
import java.text.ParseException;
import java.text.SimpleDateFormat;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.SecurityUtils;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.apache.shiro.subject.Subject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.agency.entity.WasConsumeSynthesis;
import com.jeeplus.modules.agentsystem.agency.service.WasHistoricalRecordService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;
import com.jeeplus.modules.sys.security.SystemAuthorizingRealm.Principal;

@Controller
@RequestMapping(value = "${adminPath}/agency/wasHistoricalRecord")
public class WasHistoricalRecordController  extends BaseController{
	@Autowired
	private WasHistoricalRecordService wasHistoricalRecordService;
	
	/**
	 * 历史记录消费列表
	 */
	@RequiresPermissions("agency:wasSelfConsume:list")
	@RequestMapping(value = {"list", ""})
	public String list(WasConsumeSynthesis wasConsumeSynthesis,String startDateB,String endDateB, HttpServletRequest request, HttpServletResponse response, Model model) throws ParseException {
		//无法接受时间，类型为String相关问题处理
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		if(wasConsumeSynthesis!=null){
			if(startDateB!=null&&!"".equals(startDateB)){
				wasConsumeSynthesis.setStartDate(sdf.parse(startDateB));
			}
			if(endDateB!=null&&!"".equals(endDateB)){
				wasConsumeSynthesis.setEndDate(sdf.parse(endDateB)); 
			}														
		}
		Subject subject = SecurityUtils.getSubject();
		Principal principal = (Principal)subject.getPrincipal();
		wasConsumeSynthesis.setUserId(principal.getId());
		String originalOrderNo=wasConsumeSynthesis.getOrderNo();
		wasConsumeSynthesis.setOrderNo((StringChangeUtils.specialStr(wasConsumeSynthesis.getOrderNo())));
		Page<WasConsumeSynthesis> page = wasHistoricalRecordService.findPage(new Page<WasConsumeSynthesis>(request, response), wasConsumeSynthesis); 
		wasConsumeSynthesis.setOrderNo(originalOrderNo);
		model.addAttribute("log", wasConsumeSynthesis);
		model.addAttribute("page", page);
		return "modules/agentsystem/agency/wasHistoricalRecordList";
	}
	
}
