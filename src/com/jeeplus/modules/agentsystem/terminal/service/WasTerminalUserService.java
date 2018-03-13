package com.jeeplus.modules.agentsystem.terminal.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.jeeplus.common.service.CrudService;
import com.jeeplus.modules.agentsystem.terminal.dao.WasTerminalUserDao;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalUser;
import com.jeeplus.modules.sys.dao.MenuDao;
import com.jeeplus.modules.sys.entity.Menu;
import com.jeeplus.modules.sys.entity.User;
import com.jeeplus.modules.sys.utils.UserUtils;
/**
 * 
 * @author Hua
 *
 */
@Service
@Transactional(readOnly = true,rollbackFor=Exception.class)
public class WasTerminalUserService extends CrudService<WasTerminalUserDao,WasTerminalUser>{
	@Autowired
	private MenuDao menuDao;
	@Autowired
	private WasTerminalUserDao wasTerminalUserDao;
	/**
	 * 查找menuId
	 * @param permission
	 * @return
	 */
	public String getMenuIdByPermission(String permission){
		Menu menu = menuDao.findUniqueByProperty("permission", "\"" + permission + "\"");
		return menu.getId();
	}
	/**
	 * 查找终端
	 * @param terminalUserId
	 * @return
	 */
	public WasTerminalUser findByTerminalUserId(Integer  terminalUserId){
		return wasTerminalUserDao.findByTerminalUserId(terminalUserId);
	}
	/**
	 * 保存数据
	 * @param wasTerminalUser
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer saveWasTerminalUser(WasTerminalUser wasTerminalUser) {
		Integer terminalUserId = wasTerminalUser.getTerminalUserId();
		if (terminalUserId == null){
			wasTerminalUser.preInsert();
			wasTerminalUserDao.insertWasTerminalUser(wasTerminalUser);
			return wasTerminalUser.getTerminalUserId();
		}else{
			wasTerminalUser.preUpdate();
			wasTerminalUserDao.updateWasTerminalUser(wasTerminalUser);
			return wasTerminalUser.getTerminalUserId();
		}
	}
	/**
	 * 逻辑删除
	 * @param terminalUserId
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer findIdBycompanyName(String companyName){
		return wasTerminalUserDao.findIdBycompanyName(companyName);
	}
	
	//逻辑删除
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer deleteLogic(Integer terminalUserId) {
		updateInfomation(terminalUserId);
		return wasTerminalUserDao.deleteLogic(terminalUserId);
	}
	/**
	 * 解冻
	 * @param reason
	 * @param terminalUserId
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer thaw(String reason,Integer terminalUserId){
		updateInfomation(terminalUserId);
		return wasTerminalUserDao.thaw(reason, terminalUserId);
	}
	/**
	 * 冻结
	 * @param reason
	 * @param terminalUserId
	 * @return
	 */
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public Integer freeze(String reason,Integer terminalUserId){
		updateInfomation(terminalUserId);
		return wasTerminalUserDao.freeze(reason, terminalUserId);
	}
	/**
	 * 公司名唯一性验证
	 * @param companyName
	 * @return
	 */
	public Boolean validateCompanyName(String companyName) {
		Integer num = -1;
		num = wasTerminalUserDao.validateCompanyName(companyName);
		return num>0?false:true;
	}
	/**
	 * 用户名唯一性验证
	 * @param loginName
	 * @return
	 */
	public Boolean validateLoginName(String loginName) {
		Integer num = -1;
		num = wasTerminalUserDao.validateLoginName(loginName);
		return num>0?false:true;
	}
	/**
	 * 最后操作数据时间及操作人
	 * @param terminalUserId
	 */
	public void updateInfomation(Integer terminalUserId){
		User user = UserUtils.getUser();
		wasTerminalUserDao.insertUpdateInfo(user.getId(), new Date(), terminalUserId);
	}
	/**
	 * 查找其能看到的下级所有用户
	 * @param id
	 * @return
	 */
	public List<String> findSubUsers(String id){
		return wasTerminalUserDao.findSubUsers(id);
	}
	/**
	 * 根据登录名查找终端
	 * @param loginName
	 * @return
	 */
	public WasTerminalUser findByLoginName(String loginName){
		return wasTerminalUserDao.findByLoginName(loginName);
	}
	@Transactional(readOnly = false,rollbackFor=Exception.class)
	public int insertWasTerminal(WasTerminalUser wasTerminalUser){
		wasTerminalUser.preInsert();
		wasTerminalUserDao.insertWasTerminal(wasTerminalUser);
		return wasTerminalUser.getTerminalUserId();
		
	}
}
