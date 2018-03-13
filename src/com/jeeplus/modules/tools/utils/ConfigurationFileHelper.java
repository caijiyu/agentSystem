package com.jeeplus.modules.tools.utils;

import java.io.FileInputStream;
import java.util.Properties;

/**
 * @author: YeJR
 * @date: 2017年10月31日 上午8:45:38
 * @version 1.0
 */
public class ConfigurationFileHelper {
	
	private static final String FILE_URL = "fileUrl";
	private static final String SAVE_PATH = "savePath";
	private static final String VICMOB_AGENT = "vicmobAgentUrl";
	
	private static final String WEB_CONNECTOR = "webConnector";
	private static final String MINA_CONNECTOR = "minaConnector";
	private static final String PHPINSEART_CONNECTOR = "phpInseartConnector";
	private static final String PHPUPDATE_CONNECTOR = "phpUpdateConnector";
	
	private static final String WEB_SWITCH = "webSwitch";
	private static final String MINA_SWITCH = "minaSwitch";
	private static final String PHP_SWITCH = "phpSwitch";
	
	private static final String KDNIAO_ID = "kdniaoID";
	private static final String KDNIAO_APPKEY = "kdniaoAppKey";
	private static final String KDNIAO_REQURL = "kdniaoReqURL";
	
	private static String fileUrl;
	private static String savePath;
	private static String vicmobAgentUrl;

	private static String webConnector;
	private static String minaConnector;
	private static String phpInseartConnector;
	private static String phpUpdateConnector;

	private static String webSwitch;
	private static String minaSwitch;
	private static String phpSwitch;

	private static String kdniaoID;
	private static String kdniaoAppKey;
	private static String kdniaoReqURL;
	
	/**
	 * 初始化
	 */
	static {
		initDBSource();
	}

	private static final void initDBSource() {
		Properties config = new Properties();
		try {
			// 加载配置文件
			String path = ConfigurationFileHelper.class.getResource("/").getPath();
			String websiteURL = ("/" + path + "configuration.properties").replaceFirst("/", "");
			FileInputStream in = new FileInputStream(websiteURL);
			config.load(in);
		} catch (Exception e) {
			e.printStackTrace();
		}

		fileUrl = config.getProperty(FILE_URL);
		savePath = config.getProperty(SAVE_PATH);
		vicmobAgentUrl = config.getProperty(VICMOB_AGENT);
		
		webConnector = config.getProperty(WEB_CONNECTOR);
		minaConnector = config.getProperty(MINA_CONNECTOR);
		phpInseartConnector = config.getProperty(PHPINSEART_CONNECTOR);
		phpUpdateConnector = config.getProperty(PHPUPDATE_CONNECTOR);

		webSwitch = config.getProperty(WEB_SWITCH);
		minaSwitch = config.getProperty(MINA_SWITCH);
		phpSwitch = config.getProperty(PHP_SWITCH);

		kdniaoID = config.getProperty(KDNIAO_ID);
		kdniaoAppKey = config.getProperty(KDNIAO_APPKEY);
		kdniaoReqURL = config.getProperty(KDNIAO_REQURL);

	}
	
	/**
	 * 获取文件域名
	 * @return
	 */
	public static synchronized String getFileUrl() {
		return fileUrl;
	}
	
	/**
	 * 获取保存路径
	 * @return
	 */
	public static synchronized String getSavePath() {
		return savePath;
	}
	
	/**
	 * 获取代理商的项目地址
	 * @return
	 */
	public static synchronized String getVicmobAgentUrl() {
		return vicmobAgentUrl;
	}
	
	/**
	 * web终端接口
	 * @return
	 */
	public static synchronized String getWebConnector() {
		return webConnector;
	}
	
	/**
	 * web终端接口开关
	 * @return
	 */
	public static synchronized String getWebSwitch() {
		return webSwitch;
	}
	
	/**
	 * 小程序终端接口
	 * @return
	 */
	public static synchronized String getMinaConnector() {
		return minaConnector;
	}
	/**
	 * 小程序终端接口开关
	 * @return
	 */
	public static synchronized String getMinaSwitch() {
		return minaSwitch;
	}
	
	/**
	 * php终端添加接口
	 * @return
	 */
	public static synchronized String getPhpInseartConnector() {
		return phpInseartConnector;
	}
	
	/**
	 * php终端添加接口开关
	 * @return
	 */
	public static synchronized String getPhpSwitch() {
		return phpSwitch;
	}
	
	/**
	 * php终端更新接口
	 * @return
	 */
	public static synchronized String getPhpUpdateConnector() {
		return phpUpdateConnector;
	}
	
	
	
	/**
	 * 获取快递鸟的用户ID
	 * @return
	 */
	public static synchronized String getKdniaoID() {
		return kdniaoID;
	}
	
	/**
	 * 获取快递鸟的Appkey
	 * @return
	 */
	public static synchronized String getKdniaoAppKey() {
		return kdniaoAppKey;
	}
	
	/**
	 * 获取快递鸟的物流查询接口
	 * @return
	 */
	public static synchronized String getKdniaoReqURL() {
		return kdniaoReqURL;
	}
}
