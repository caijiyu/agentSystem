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
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.util.HtmlUtils;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFileClassify;
import com.jeeplus.modules.agentsystem.sysdata.service.WasFileClassifyService;
import com.jeeplus.modules.agentsystem.sysdata.service.WasFileService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;

/**
 * 文件分类Controller
 * @author WB
 * @version 2017-09-27
 */
@Controller
@RequestMapping(value = "${adminPath}/sysdata/wasFileClassify")
public class WasFileClassifyController extends BaseController {

	@Autowired
	private WasFileService wasFileService;
	@Autowired
	private WasFileClassifyService wasFileClassifyService;
	
	
	/**
	 * 增删改列表页面
	 */
	@RequiresPermissions("sysdata:wasFileClassify:list")
	@RequestMapping(value = {"list", ""})
	public String list(WasFileClassify wasFileClassify, HttpServletRequest request, HttpServletResponse response, Model model) {
		String originalName=wasFileClassify.getName();
		wasFileClassify.setName(StringChangeUtils.specialStr(wasFileClassify.getName()));
		Page<WasFileClassify> page = wasFileClassifyService.findPage(new Page<WasFileClassify>(request, response), wasFileClassify); 
		wasFileClassify.setName(originalName);
		model.addAttribute("page", page);
		model.addAttribute("log", wasFileClassify);
		return "modules/agentsystem/sysdata/wasFileClassifyList";
	}


	/**
	 * 保存增删改
	 */
	@RequiresPermissions("sysdata:wasFileClassify:add")
	@ResponseBody
	@RequestMapping(value = "save")
	public Integer save(WasFileClassify wasFileClassify, Model model) {
		if(wasFileClassify.getClassifyId()!=null){
			wasFileClassify.setId(Integer.toString(wasFileClassify.getClassifyId()));
			wasFileClassify.setIsNewRecord(false);
		}else{
			wasFileClassify.setIsNewRecord(true);
			Date nowDate=new Date();
			wasFileClassify.setCreateDate(nowDate);
		}
		int result=0;
		try {
			wasFileClassifyService.save(wasFileClassify);
		} catch (Exception e) {
			return result;
		}
		result=1;
		return result;
	}
	
	/**
	 * 删除增删改
	 */
	@RequiresPermissions("sysdata:wasFileClassify:del")
	@ResponseBody
	@RequestMapping(value = "delete")
	public Integer delete(WasFileClassify wasFileClassify) {
		int result=0;
		Integer count=0;
		
		try {
			 count=wasFileService.getFileByClassifyId(wasFileClassify.getClassifyId());
		} catch (Exception e) {
			result=2;
			return result;
		}
		
		if(count==0){
			try {
				wasFileClassifyService.delete(wasFileClassify);
			} catch (Exception e) {
				result=2;
				return result;
			}
			result=1;
			return result;
		}
		return result;
	}
	
	/**
	 * 名称重复性验证
	 */
	@ResponseBody
	@RequestMapping(value = "validateName")
	public String getFileClassifyByName(String fileClassifyName) {
		fileClassifyName=HtmlUtils.htmlUnescape(fileClassifyName);
		Integer count=wasFileClassifyService.getFileClassifyByName(fileClassifyName);
		if(count==0){
			return "true";
		}
		return "false";
		
	}
	
	/**
	 * 获取所有分类
	 */
	@ResponseBody
	@RequestMapping(value = "getAll")
	public List<WasFileClassify> getAll(){
		return wasFileClassifyService.findAllList();
	}
}