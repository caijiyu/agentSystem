package com.jeeplus.modules.agentsystem.utils;

import java.io.BufferedReader;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.net.URL;
import java.net.URLConnection;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;

import com.jeeplus.common.utils.SpringContextHolder;
import com.jeeplus.modules.agentsystem.terminal.dao.WasTerminalUserDao;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalProduct;
import com.jeeplus.modules.agentsystem.terminal.entity.WasTerminalUser;
import com.jeeplus.modules.tools.utils.ConfigurationFileHelper;

import net.sf.json.JSONObject;

/**
 * @author YeJR
 * @date 创建时间：2017年10月20日 下午5:24:55
 * @version 1.0
 * @parameter
 * @since
 * @return
 */
public class TerminalPermissionUtils {
	/**
	 * 接口部分
	 */
	private static String webUrl = ConfigurationFileHelper.getWebConnector();
	private static String minaUrl = ConfigurationFileHelper.getMinaConnector();
	private static String phpInsertUrl = ConfigurationFileHelper.getPhpInseartConnector();
	private static String phpUpdateUrl = ConfigurationFileHelper.getPhpUpdateConnector();

	/**
	 * 接口开关
	 */
	private static String webSwitch = ConfigurationFileHelper.getWebSwitch();
	private static String minaSwitch = ConfigurationFileHelper.getMinaSwitch();
	private static String phpSwitch = ConfigurationFileHelper.getPhpSwitch();

	/**
	 * 终端账户正常状态
	 */
	private static String normalState = "0";
	/**
	 * 开关打开
	 */
	private static String switchOn = "1";
	private static WasTerminalUserDao wasTerminalUserDao = SpringContextHolder.getBean(WasTerminalUserDao.class);

	public static synchronized boolean sendTerminalPermissions(WasTerminalUser wasTerminalUser) {
		try {
			/**
			 * 发送标记
			 */
			boolean webFlag = false;
			boolean minaFlag = false;
			boolean phpFlag = false;

			// php接口参数
			/** 版本信息 */
			int groupid = 0;
			/** 用户名 */
			String username = "";
			/** 年限 */
			int year = 0;
			/** 终端公司名称 */
			String qymc = "";
			/** 代理商ID */
			String did = "";
			/** 电话 */
			String telephone = "";

			// 查询出该终端的详细信息
			wasTerminalUser = wasTerminalUserDao.getTerminalInfo(wasTerminalUser);
			if (wasTerminalUser != null) {
				JSONObject jsonObject = new JSONObject();

				List<WasTerminalProduct> list = wasTerminalUser.getTerminalProducts();
				SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
				// 分组信息（暂时没有用）
				jsonObject.put("groupId", 1 + "");
				// 用户登录名
				jsonObject.put("loginName", wasTerminalUser.getLoginName());
				username = wasTerminalUser.getLoginName();

				// 用户登录密码
				jsonObject.put("passWord", wasTerminalUser.getPassword());
				// 负责人
				jsonObject.put("name", wasTerminalUser.getName());
				// 联系电话
				jsonObject.put("phone", wasTerminalUser.getPhone());
				telephone = wasTerminalUser.getPhone();

				// 公司名称
				jsonObject.put("company", wasTerminalUser.getCompanyName());
				qymc = wasTerminalUser.getCompanyName();

				// 地址
				jsonObject.put("address", wasTerminalUser.getAddress());
				// 账户开始时间
				jsonObject.put("createDate", formatter.format(wasTerminalUser.getCreateDate()));
				jsonObject.put("startTime", formatter.format(wasTerminalUser.getCreateDate()));
				// 所属代理商登录名
				did = wasTerminalUser.getParentLoginName();
				// 结束时间
				Date endTime = new Date();

				// Array数据用于存放产品
				ArrayList<HashMap<String, Object>> arrayList = new ArrayList<>();
				for (int i = 0; i < list.size(); i++) {
					// 用于存放单个产品
					HashMap<String, Object> hashMap = new HashMap<>();
					// 终端产品
					WasTerminalProduct wasTerminalProduct = list.get(i);
					// 终端开始时间
					hashMap.put("startTime", formatter.format(wasTerminalProduct.getStartDate()));
					// 终端结束时间
					hashMap.put("endTime", formatter.format(wasTerminalProduct.getEndDate()));
					// 时间比较
					if (i == 0) {
						endTime = wasTerminalProduct.getEndDate();
					} else {
						if (wasTerminalProduct.getEndDate().after(endTime)) {
							endTime = wasTerminalProduct.getEndDate();
						}
					}
					// 若终端产品中有对应的分类
					if (wasTerminalProduct.getSoftClassify() == 1) {
						minaFlag = true;
					} else if (wasTerminalProduct.getSoftClassify() == 0) {
						webFlag = true;
					}
					// 终端的ID
					hashMap.put("moduleNumber", wasTerminalProduct.getSoftwareId());
					// 终端版本等级（0：标准版）
					hashMap.put("subModuleNumber", 0 + "");
					// 终端状态
					hashMap.put("status", wasTerminalProduct.getState());
					// 添加进数组
					arrayList.add(hashMap);

					// 查看该终端产品软件的版本是否是老版本的
					if (!wasTerminalProduct.getSoftVersion()) {
						if (compareDate(wasTerminalProduct.getEndDate(), new Date()) == 1 && wasTerminalProduct.getState() == 1) {
							year = getYear(wasTerminalProduct.getStartDate(), wasTerminalProduct.getEndDate());
							phpFlag = true;
							groupid = matchOldversion(wasTerminalProduct.getSoftwareId());
						}
						
					}

				}
				// 账户结束时间
				jsonObject.put("endTime", formatter.format(endTime));
				// 用户终端集合
				jsonObject.put("userAuthoritys", arrayList);
				// 账户状态
				if (normalState.equals(wasTerminalUser.getState())) {
					jsonObject.put("loginFlag", 1 + "");// web
					jsonObject.put("delFlag", 0 + "");// mina
				} else {
					jsonObject.put("loginFlag", 0 + "");
					jsonObject.put("delFlag", 1 + "");
				}
				// 如果有小程序的就发送小程序接口
				if (minaFlag && minaSwitch.equals(switchOn)) {
					try {
						doPost(minaUrl, jsonObject.toString());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				// 如果有公众号的就发送公众号接口
				if (webFlag && webSwitch.equals(switchOn)) {
					try {
						doPost(webUrl, jsonObject.toString());
					} catch (Exception e) {
						e.printStackTrace();
					}
				}
				// 如果有旧版的就发送php接口
				if (phpFlag && phpSwitch.equals(switchOn)) {
					phpInsertUrl = phpInsertUrl + "&groupid=" + groupid + "&username=" + username + "&year=" + year + "&qymc=" + qymc + "&did=" + did + "&telephone=" + telephone;
					phpUpdateUrl = phpUpdateUrl + "&username=" + username + "&did=" + did + "&groupid=" + groupid;
					
					sendGet(phpInsertUrl);
					sendGet(phpUpdateUrl);
				}

			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return true;
	}

	/**
	 * 匹配旧版
	 * 
	 * @param softId
	 * @return
	 */
	public static int matchOldversion(int softId) {
		switch (softId) {
		// 微酒店（旧）
		case 21:
			return 5;
		// 微商城（旧）
		case 22:
			return 6;
		// 微餐饮（旧）
		case 23:
			return 11;
		// 微媒体（旧）
		case 24:
			return 12;
		// 微汽车（旧）
		case 25:
			return 13;
		// 微房产（旧）
		case 26:
			return 14;
		// 微社区（旧）
		case 27:
			return 15;
		// 微景区（旧）
		case 28:
			return 16;
		// 微婚庆（旧）
		case 29:
			return 21;
		// 微人才（旧）
		case 30:
			return 22;
		// 微医疗（旧）
		case 31:
			return 28;
		// 微教育（旧）
		case 32:
			return 29;
		// 微娱乐（旧）
		case 33:
			return 30;
		// 基础版（旧）
		case 34:
			return 31;
		default:
			return 0;
		}
	}

	/**
	 * 数据流post请求
	 * 
	 * @param urlStr
	 * @param xmlInfo
	 */
	public static String doPost(String urlStr, String strInfo) {
		String reStr = "";
		try {
			URL url = new URL(urlStr);
			URLConnection con = url.openConnection();
			con.setDoOutput(true);
			con.setRequestProperty("Pragma", "no-cache");
			con.setRequestProperty("Cache-Control", "no-cache");
			con.setRequestProperty("Content-Type", "text/xml");
			OutputStreamWriter out = new OutputStreamWriter(con.getOutputStream());
			out.write(new String(strInfo.getBytes("utf-8")));
			out.flush();
			out.close();
			BufferedReader br = new BufferedReader(new InputStreamReader(con.getInputStream(), "utf-8"));
			String line = "";
			for (line = br.readLine(); line != null; line = br.readLine()) {
				reStr += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return reStr;
	}

	/**
	 * 向指定URL发送GET方法的请求
	 * 
	 * @param url
	 *            发送请求的URL
	 * @param param
	 *            请求参数，请求参数应该是 name1=value1&name2=value2 的形式。
	 * @return URL 所代表远程资源的响应结果
	 */
	public static String sendGet(String url) {
		String result = "";
		BufferedReader in = null;
		try {
			URL realUrl = new URL(url);
			// 打开和URL之间的连接
			URLConnection connection = realUrl.openConnection();
			// 设置通用的请求属性
			connection.setRequestProperty("accept", "*/*");
			connection.setRequestProperty("connection", "Keep-Alive");
			connection.setRequestProperty("user-agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1;SV1)");
			// 建立实际的连接
			connection.connect();
			// 定义 BufferedReader输入流来读取URL的响应
			in = new BufferedReader(new InputStreamReader(connection.getInputStream()));
			String line;
			while ((line = in.readLine()) != null) {
				result += line;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		// 使用finally块来关闭输入流
		finally {
			try {
				if (in != null) {
					in.close();
				}
			} catch (Exception e2) {
				e2.printStackTrace();
			}
		}
		return result;
	}
	
	//相差年限
	public static int getYear(Date startDay,Date endDay) throws Exception{  
		SimpleDateFormat  simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String startTime = simpleDateFormat.format(startDay);
		String endTime = simpleDateFormat.format(endDay);
        int end = Integer.parseInt(endTime.substring(0, 4));
        int start = Integer.parseInt(startTime.substring(0, 4));
        return end - start;    
    }  
	
	//时间比较
	public static int compareDate(Date compareTime, Date currentTime) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd hh:mm");
		try {
			Date cTime= dateFormat.parse(dateFormat.format(compareTime));
			Date tTime = dateFormat.parse(dateFormat.format(currentTime));
			if (cTime.getTime() > tTime.getTime()) {
				return 1;
			} else if (cTime.getTime() < tTime.getTime()) {
				return -1;
			} else {
				return 0;
			}
		} catch (Exception exception) {
			exception.printStackTrace();
		}
		return 0;
	}
}
