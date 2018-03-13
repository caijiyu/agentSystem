package com.jeeplus.common.tag;

import java.io.IOException;

import javax.servlet.ServletContext;
import javax.servlet.jsp.JspTagException;
import javax.servlet.jsp.JspWriter;
import javax.servlet.jsp.tagext.TagSupport;

import com.jeeplus.common.config.Global;
import com.jeeplus.common.utils.SpringContextHolder;
import com.jeeplus.modules.sys.entity.Menu;

/**
 * 
 * 类描述：菜单标签
 * 
 * 张代浩 @date： 日期：2012-12-7 时间：上午10:17:45
 * 
 * @version 1.0
 */
public class MenuTag extends TagSupport {
	private static final long serialVersionUID = 1L;
	protected Menu menu;// 菜单Map

	public Menu getMenu() {
		return menu;
	}

	public void setMenu(Menu menu) {
		this.menu = menu;
	}

	public int doStartTag() throws JspTagException {
		return EVAL_PAGE;
	}

	public int doEndTag() throws JspTagException {
		try {
			JspWriter out = this.pageContext.getOut();
			String menu = (String) this.pageContext.getSession().getAttribute("menu");
			if (menu != null) {
				out.print(menu);
			} else {
				menu = end().toString();
				out.print(menu);

			}

		} catch (IOException e) {
			e.printStackTrace();
		}
		return EVAL_PAGE;
	}

	public StringBuffer end() {
		StringBuffer sb = new StringBuffer();
		sb.append(getChildOfTree(menu, 0));
		return sb;
	}

	private static String getChildOfTree(Menu parent, int level) {
		StringBuffer menuString = new StringBuffer();
		String href = "";

		if (!parent.hasPermisson())
			return "";
		if (level > 0) {// level 为0是功能菜单

			menuString.append("<li>");

			ServletContext context = SpringContextHolder.getBean(ServletContext.class);
			if (parent.getHref() != null && parent.getHref().length() > 0) {
				if (parent.getHref().endsWith(".html") && !parent.getHref().endsWith("ckfinder.html")) {// 如果是静态资源并且不是ckfinder.html，直接访问不加adminPath
					href = context.getContextPath() + parent.getHref();
				} else {
					href = context.getContextPath() + Global.getAdminPath() + parent.getHref();
				}
			}
		}
		// 有子元素的菜单
		if (parent.hasChildren()) {
			if (level == 1) {
				// 有子菜单的 一级a标签
				menuString.append("<a onclick=\"changeState(this)\" id=\"" +  parent.getId()
						+ "\" class=\"has-arrow waves-effect waves-dark menu-mark\" aria-expanded=\"false\" ><i class=\""
						+ parent.getIcon() + "\"></i> <span class=\"hide-menu\">" + parent.getName() + "</span></a>");

				menuString.append("<ul aria-expanded=\"false\" class=\"collapse\">");
			} else if (level == 2) {
				// 有子菜单的 二级a标签
				menuString.append("<a  class=\"a-mark\" onclick=\"changeState(this)\" id=\"" +  parent.getId()
						+ "\"  href=\"#\"  aria-expanded=\"false\"><i class=\"" + parent.getIcon() + "\"></i> "
						+ parent.getName() + "</a>");
				menuString.append("<ul aria-expanded=\"false\" class=\"collapse\">");
			}
			for (Menu child : parent.getChildren()) {
				if (child.getIsShow().equals("1")) {
					menuString.append(getChildOfTree(child, level + 1));
				}
			}
			if (level > 0) {
				menuString.append("</ul>");
			}
		} else {// 没有子菜单
			// 没有子菜单 的一级a标签
			if (level == 1) {
				if (href != null && !href.equals("")) {
					menuString.append("<a  target=\"myIframe\" id=\"" +  parent.getId() + "\" onclick=\"changeMyState(this)\" href=\""
							+ href
							+ "\" class=\"waves-effect waves-dark menu-single-mark\" aria-expanded=\"false\"><i class=\""
							+ parent.getIcon() + "\"></i> <span class=\"hide-menu\">" + parent.getName()
							+ "</span></a>");
				} else {
					menuString.append("<a target=\"myIframe\" id=\"" +  parent.getId()
							+ "\" onclick=\"changeMyState(this)\" href=\"#\" class=\"waves-effect waves-dark menu-single-mark\" aria-expanded=\"false\"><i class=\""
							+ parent.getIcon() + "\"></i> <span class=\"hide-menu\">" + parent.getName()
							+ "</span></a>");
				}
			} else {
				// 没有子菜单 的a标签
				if (href != null && !href.equals("")) {
					menuString.append("<a id=\"" +  parent.getId() + "\" onclick=\"changeState(this)\" target=\"myIframe\"  href=\""
							+ href + "\" ><i class=\"" + parent.getIcon() + "\"></i> <span class=\"nav-label\">"
							+ parent.getName() + "</span></a>");
				} else {
					menuString.append("<a id=\"" + parent.getId()
							+ "\" onclick=\"changeState(this)\" target=\"myIframe\"  href=\"#\" ><i class=\""
							+ parent.getIcon() + "\"></i> <span class=\"nav-label\">" + parent.getName()
							+ "</span></a>");
				}
			}
		}
		if (level > 0) {
			menuString.append("</li>");
		}

		return menuString.toString();
	}

}
