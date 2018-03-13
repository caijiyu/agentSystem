package com.jeeplus.modules.agentsystem.utils;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.jeeplus.common.web.BaseController;
import com.jeeplus.modules.agentsystem.terminal.service.WasTerminalUserService;

/**
 * 验证终端
 * @author: YeJR
 * @date: 2017年12月12日 上午9:13:23
 * @version 1.0
 */
@Controller
@RequestMapping(value = "agent/terminal")
public class TerminalValidate extends BaseController{
	
	@Autowired
	private WasTerminalUserService wasTerminalUserService;
	
	@ResponseBody
	@RequestMapping(value = "loginNameValidate")
	public Boolean saveFile(HttpServletRequest request,Model model,String loginName) {
		return wasTerminalUserService.validateLoginName(loginName);
	}
	
	
}
