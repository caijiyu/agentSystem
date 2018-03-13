package com.jeeplus.modules.agentsystem.sysdata.entity;

import java.util.Date;

import com.jeeplus.common.persistence.DataEntity;

/**
 * 日志DataEntity
 * @author Wb
 * @date  2017-9-29
 * @version 1.0
 */
public class WasAgentSystemLog extends DataEntity<WasAgentSystemLog>{

	/**
	 * 
	 */
	private static final long serialVersionUID = 1L;
	/**主键ID*/
	private Integer logId;
	/**菜单ID*/
	private String  menuId;
	/**创建者*/
	private Date createDateA;
	/**创建时间*/
	private String createByA;
	/**备注*/
	private String remarks;
	
	public WasAgentSystemLog() {
		super();
	}
	
	public WasAgentSystemLog( String menuId, Date createDateA, String createByA, String remarks) {
		super();
		this.menuId = menuId;
		this.createDateA = createDateA;
		this.createByA = createByA;
		this.remarks = remarks;
	}
	
	public Integer getLogId() {
		return logId;
	}
	public void setLogId(Integer logId) {
		this.logId = logId;
	}
	public String getMenuId() {
		return menuId;
	}
	public void setMenuId(String menuId) {
		this.menuId = menuId;
	}
	public Date getCreateDateA() {
		return createDateA;
	}
	public void setCreateDateA(Date createDateA) {
		this.createDateA = createDateA;
	}
	public String getCreateByA() {
		return createByA;
	}
	public void setCreateByA(String createByA) {
		this.createByA = createByA;
	}
	
	@Override
	public String getRemarks() {
		return remarks;
	}
	 
	@Override
	public void setRemarks(String remarks) {
		this.remarks = remarks;
	}
	
	
}
