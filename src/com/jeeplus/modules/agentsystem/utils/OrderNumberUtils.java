package com.jeeplus.modules.agentsystem.utils;

/**
 * 工具类
 * @author Ricky
 * @version 2017-09-27
 */
public class OrderNumberUtils {

	public synchronized static String orderNumber(){
		 String res;
		 long ts = System.currentTimeMillis();
		 res = String.valueOf(ts);
		 try {
			 //防止线程运行过快
			 Thread.sleep(1);                  
			} catch (InterruptedException e) {
			 return res="订单号生成失败";
			}
		 return res;
	}
}
