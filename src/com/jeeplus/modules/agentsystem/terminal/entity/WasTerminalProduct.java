package com.jeeplus.modules.agentsystem.terminal.entity;

import java.util.Date;

import com.fasterxml.jackson.annotation.JsonFormat;
import com.jeeplus.common.persistence.DataEntity;
/**
 * 
 * @author Hua
 *
 */
public class WasTerminalProduct extends DataEntity<WasTerminalProduct>{
	private static final long serialVersionUID = 1L;
	private Integer terminalProductId;
	private Integer terminalUserId;
	private Integer softwareId;
	private Date startDate;
	private Date endDate;
	private Integer state;
	private Boolean classify;
	
	/** 软件名称 */
	private String softName;
	/** 软件分类 */
	private Integer softClassify;
	/** 软件版本 */
	private Boolean softVersion;
	/**软件新旧版本*/
	private Integer newVersion;
	
	public Integer getNewVersion() {
		return newVersion;
	}
	public void setNewVersion(Integer newVersion) {
		this.newVersion = newVersion;
	}
	public Boolean getClassify() {
		return classify;
	}
	public void setClassify(Boolean classify) {
		this.classify = classify;
	}
	public Integer getTerminalProductId() {
		return terminalProductId;
	}
	public void setTerminalProductId(Integer terminalProductId) {
		this.terminalProductId = terminalProductId;
	}
	public Integer getTerminalUserId() {
		return terminalUserId;
	}
	public void setTerminalUserId(Integer terminalUserId) {
		this.terminalUserId = terminalUserId;
	}
	public Integer getSoftwareId() {
		return softwareId;
	}
	public void setSoftwareId(Integer softwareId) {
		this.softwareId = softwareId;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getStartDate() {
		return startDate;
	}
	public void setStartDate(Date startDate) {
		this.startDate = startDate;
	}
	@JsonFormat(pattern = "yyyy-MM-dd HH:mm:ss", timezone = "GMT+8")
	public Date getEndDate() {
		return endDate;
	}
	public void setEndDate(Date endDate) {
		this.endDate = endDate;
	}
	public Integer getState() {
		return state;
	}
	public void setState(Integer state) {
		this.state = state;
	}
	public WasTerminalProduct(Integer terminalUserId, Integer softwareId, Date startDate, Date endDate, Integer state) {
		super();
		this.terminalUserId = terminalUserId;
		this.softwareId = softwareId;
		this.startDate = startDate;
		this.endDate = endDate;
		this.state = state;
	}
	public WasTerminalProduct() {
		super();
	}
	
	public String getSoftName() {
		return softName;
	}
	public void setSoftName(String softName) {
		this.softName = softName;
	}
	public Integer getSoftClassify() {
		return softClassify;
	}
	public void setSoftClassify(Integer softClassify) {
		this.softClassify = softClassify;
	}
	public Boolean getSoftVersion() {
		return softVersion;
	}
	public void setSoftVersion(Boolean softVersion) {
		this.softVersion = softVersion;
	}
	
}
