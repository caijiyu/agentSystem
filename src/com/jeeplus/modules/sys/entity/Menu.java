/**
 * Copyright &copy; 2015-2020 <a href="http://www.jeeplus.org/">JeePlus</a> All rights reserved.
 */
package com.jeeplus.modules.sys.entity;

import java.util.List;

import javax.validation.constraints.NotNull;

import org.hibernate.validator.constraints.Length;
import org.springframework.web.util.HtmlUtils;

import com.fasterxml.jackson.annotation.JsonBackReference;
import com.fasterxml.jackson.annotation.JsonIgnore;
import com.jeeplus.common.persistence.DataEntity;
import com.jeeplus.modules.sys.utils.UserUtils;

/**
 * 菜单Entity
 * @author jeeplus
 * @version 2013-05-15
 */
public class Menu extends DataEntity<Menu> {

	private static final long serialVersionUID = 1L;
	private String parentName; //父级菜单名称
	private Menu parent;	// 父级菜单
	private String parentIds; // 所有父级编号
	private List<Menu> children;	// 父级菜单
	private String name; 	// 名称
	private String href; 	// 链接
	private String target; 	// 目标（ mainFrame、_blank、_self、_parent、_top）
	private String icon; 	// 图标
	private Integer sort; 	// 排序
	private String isShow; 	// 是否在菜单中显示（1：显示；0：不显示）
	private String permission; // 权限标识
	
	private String userId;
	
	public Menu(){
		super();
		this.sort = 30;
		this.isShow = "1";
	}
	
	public Menu(String id){
		super(id);
	}
	
	
	public String getParentName() {
		return parentName;
	}

	public void setParentName(String parentName) {
		this.parentName = parentName;
	}

	@JsonBackReference
	@NotNull
	public Menu getParent() {
		return parent;
	}

	public void setParent(Menu parent) {
		this.parent = parent;
	}

	@Length(min=1, max=2000)
	public String getParentIds() {
		return parentIds;
	}

	public void setParentIds(String parentIds) {
		this.parentIds = parentIds;
	}
	
	@Length(min=1, max=100)
	public String getName() {
		return HtmlUtils.htmlUnescape(name);
	}

	public void setName(String name) {
		this.name = HtmlUtils.htmlUnescape(name);
	}

	@Length(min=0, max=2000)
	public String getHref() {
		return HtmlUtils.htmlUnescape(href);
	}

	public void setHref(String href) {
		this.href = HtmlUtils.htmlUnescape(href);
	}

	@Length(min=0, max=20)
	public String getTarget() {
		return HtmlUtils.htmlUnescape(target);
	}

	public void setTarget(String target) {
		this.target = HtmlUtils.htmlUnescape(target);
	}
	
	@Length(min=0, max=100)
	public String getIcon() {
		return HtmlUtils.htmlUnescape(icon);
	}

	public void setIcon(String icon) {
		this.icon = HtmlUtils.htmlUnescape(icon);
	}
	
	@NotNull
	public Integer getSort() {
		return sort;
	}
	
	public void setSort(Integer sort) {
		this.sort = sort;
	}
	
	@Length(min=1, max=1)
	public String getIsShow() {
		return isShow;
	}

	public void setIsShow(String isShow) {
		this.isShow = isShow;
	}

	@Length(min=0, max=200)
	public String getPermission() {
		return HtmlUtils.htmlUnescape(permission);
	}

	public void setPermission(String permission) {
		this.permission = HtmlUtils.htmlUnescape(permission);
	}

	public String getParentId() {
		return parent != null && parent.getId() != null ? parent.getId() : "0";
	}
	
	@JsonIgnore
	public boolean hasChildren(){
		if(children == null || children.size() == 0){
			return false;
		}
		for(Menu child:children){
			if(child.getIsShow().equals("1")){
				return true;
			}
		}
		return false;
	}
	@JsonIgnore
	public boolean hasPermisson(){
		List<Menu> menuList = UserUtils.getMenuList();
		for(Menu menu:menuList){
			if(menu.getId().equals(this.getId()))
				return true;
		}
		return false;
	}
	
	@JsonIgnore
	public static void sortList(List<Menu> list, List<Menu> sourcelist, String parentId, boolean cascade){
		for (int i=0; i<sourcelist.size(); i++){
			Menu e = sourcelist.get(i);
			if (e.getParent()!=null && e.getParent().getId()!=null
					&& e.getParent().getId().equals(parentId)){
				list.add(e);
				if (cascade){
					// 判断是否还有子节点, 有则继续获取子节点
					for (int j=0; j<sourcelist.size(); j++){
						Menu child = sourcelist.get(j);
						if (child.getParent()!=null && child.getParent().getId()!=null
								&& child.getParent().getId().equals(e.getId())){
							sortList(list, sourcelist, e.getId(), true);
							break;
						}
					}
				}
			}
		}
	}

	@JsonIgnore
	public static String getRootId(){
		return "1";
	}
	
	public String getUserId() {
		return userId;
	}

	public void setUserId(String userId) {
		this.userId = userId;
	}

	@Override
	public String toString() {
		return name;
	}

	public void setChildren(List<Menu> children) {
		this.children = children;
	}

	public List<Menu> getChildren() {
		return children;
	}
}