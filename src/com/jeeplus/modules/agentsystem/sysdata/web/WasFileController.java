/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.agentsystem.sysdata.web;


import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.shiro.authz.annotation.Logical;
import org.apache.shiro.authz.annotation.RequiresPermissions;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeeplus.common.persistence.Page;
import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.sysdata.entity.WasFile;
import com.jeeplus.modules.agentsystem.sysdata.service.WasFileService;
import com.jeeplus.modules.agentsystem.utils.StringChangeUtils;

/**
 * 文件列表Controller
 * @author WB
 * @version 2017-09-27
 */
@Controller
@RequestMapping(value = "${adminPath}/agentsystem/wasFile")
public class WasFileController extends BaseController {

	@Autowired
	private WasFileService wasFileService;
	
	
	/**
	 * 增删改列表页面
	 */
	@RequiresPermissions("sysdata:wasFile:list")
	@RequestMapping(value = {"list", ""})
	public String list(WasFile wasFile, HttpServletRequest request, HttpServletResponse response, Model model) {
		String originalName=wasFile.getName();
		wasFile.setName(StringChangeUtils.specialStr(wasFile.getName()));
		Page<WasFile> page = wasFileService.findPage(new Page<WasFile>(request, response), wasFile); 
		wasFile.setName(originalName);
		model.addAttribute("log", wasFile);
		model.addAttribute("page", page);
		return "modules/agentsystem/sysdata/wasFileList";
	}

	/**
	 * 保存增删改
	 */

	@RequiresPermissions(value={"sysdata:wasFile:add","sysdata:wasFile:edit"},logical=Logical.OR)
	@ResponseBody
	@RequestMapping(value = "save")
	public Integer save(WasFile wasFile, Model model) {
		if(wasFile.getFileId()!=null){
			wasFile.setId(Integer.toString(wasFile.getFileId()));
			wasFile.setIsNewRecord(false);
		}else{
			wasFile.setIsNewRecord(true);
		}
		int result=0;
		try {
			wasFileService.save(wasFile);
		} catch (Exception e) {
			return result;
		}
		result=1;
		return result;
	}
	
	/**
	 * 删除文件
	 */
	@RequiresPermissions("sysdata:wasFile:del")
	@ResponseBody
	@RequestMapping(value = "delete")
	public Integer delete(WasFile wasFile) {
		int result=0;
		try {
			wasFileService.delete(wasFile);
		} catch (Exception e) {
			result=1;
			return result;
		}
		return result;
	}
	
	/**
	 * 根据id获取文件
	 */
	@ResponseBody
	@RequestMapping(value = "get")
	public WasFile get(Integer fileId) {
		String id=Integer.toString(fileId);
		return wasFileService.get(id);
	}
}