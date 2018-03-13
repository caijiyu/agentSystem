
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 代理商详情页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style type="text/css">
	label{
	white-space:pre-wrap;
	}
</style>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h3 class="cardTitle">代理商详细信息</h3>
					<hr class="m-t-0 m-b-40">
					<form action="#" method="post"
						style="width: 100%" id="addForm">
						<div class="form-body">
 							<div class="row">
                                  <div class="col-md-6">
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">账号：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.login_name)}</label> 
                                      </div>

                                      <div class="form-group row">
                                      <label class="control-label col-3" style="text-align: right;">负责人：</label>
                                      <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.name)}</label>

                                  </div>
                                      <div class="form-group row">
                                      <label class="control-label col-3" style="text-align: right;">地区：</label>
                                      <label class="control-label col-9" style="text-align: left;">${agent.province}${agent.city}${agent.county}</label>

                                  </div>
                                  <div class="form-group row" id="qq">

										<label class="control-label col-3" style="text-align: right;">QQ：</label>
										<label class="control-label col-9" style="text-align: left;">${agent.qq}</label>

									</div>
                                  
									<div class="form-group row" id="email">

										<label class="control-label col-3" style="text-align: right;">邮箱：</label>
										<label class="control-label col-9" style="text-align: left;">${agent.email}</label>

									</div>
									
									<div class="form-group row" id="theater">
                                      
                                          <label class="control-label col-3" style="text-align: right;">所属战区：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.theater)}</label>
										
                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">套餐折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;">${agent.packageDiscount}${'折'}</label>

                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">小程序折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;">${agent.minaDiscount}${'折'}</label>

                                      </div>

                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">代理商等级：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.agentLevel)}</label>

                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">时间期限：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatDate value="${agent.startDate}" pattern="yyyy-MM-dd"/>${'--'}<fmt:formatDate value="${agent.endDate}" pattern="yyyy-MM-dd"/></label>
                                      </div>
                                

                                  </div>
                                  <!--/span-->
                                  <div class="col-md-6">
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">公司全称：</label>
                                          <label class="control-label col-9" style="text-align: left;white-space: pre-wrap;">${fn:escapeXml(agent.companyName)}</label>

                                      </div>

                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">联系方式：</label>
                                          <label class="control-label col-9" style="text-align: left;">${agent.mobile}</label>

                                      </div>

                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">地址：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.address)}</label>

                                      </div>
                                      <div class="form-group row" id="principal">
                                       
                                          <label class="control-label col-3" style="text-align: right;">战区负责人：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.principal)}</label>
                                         
                                      </div>
									<div class="form-group row" id="wechat">

										<label class="control-label col-3" style="text-align: right;">微信号：</label>
										<label class="control-label col-9" style="text-align: left;">${agent.wechat}</label>

									</div>

									<div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">公众号折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;">${agent.publicDiscount}${'折'}</label>

                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">所属上级：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(agent.companyParent.companyName)}</label>

                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">客户等级：</label>
                                          <c:if test="${agent.customerLevel == 1}">
												<label class="control-label col-9" style="text-align: left;">VIP用户</label>
											</c:if>
											<c:if test="${agent.customerLevel == 0 }">
												<label class="control-label col-9" style="text-align: left;">普通用户</label>
											</c:if> 
                                          
                                      </div>
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">状态：</label>
                                          	<c:if test="${agent.state == 1}">
												<label class="control-label col-9" style="text-align: left;">正常</label>
											</c:if>
											<c:if test="${agent.state == 0 }">
												<label class="control-label col-9" style="text-align: left;">冻结</label>
											</c:if>        

                                      </div>
                                   
                                      <div class="form-group row">
                                      <c:if test="${(not empty agent.certificate ) }">
                                          <label class="control-label col-3" style="text-align: right;">证书：</label>
                                          	 <img style="width:auto;height:100px" src="${fn:escapeXml(vicmobAgentSystemFileUrl)}${agent.certificate}" onclick="layerPhoto('${agent.id}')"/>
									 	</c:if>
                                      </div>

                                  </div>
                              </div>

						</div>
						<div class="form-group row">
							<label class="col-2 col-form-label"></label>
							<div class="col-12">
								<div class="text-xs-right" style="text-align: right;">
									<button type="button" class="btn btn-default" onclick="jump()">返回</button>
								</div>
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		layer.config({
		  extend: 'extend/layer.ext.js'
		});  
		$("document").ready(function(){
			if("${agent.theater}" == null || "${agent.theater}" == undefined || "${agent.theater}" == "") {
				$("#theater").hide();
			}
			if("${agent.principal}" == null || "${agent.principal}" == undefined || "${agent.principal}" == "") {
				$("#principal").hide();
			}
			if("${agent.qq}" == null || "${agent.qq}" == undefined || "${agent.qq}" == "") {
				$("#qq").hide();
			}
			if("${agent.email}" == null || "${agent.email}" == undefined || "${agent.email}" == "") {
				$("#email").hide();
			}
			if("${agent.wechat}" == null || "${agent.wechat}" == undefined || "${agent.wechat}" == "") {
				$("#wechat").hide();
			}
		
		});
		function layerPhoto(id){
	   		var pic = [];
			   var str={ "alt":"",//图片名
						 "pid":id, 
						  "src":'${fn:escapeXml(vicmobAgentSystemFileUrl)}'+'${agent.certificate}',//原图地址
						  "thumb":'${fn:escapeXml(vicmobAgentSystemFileUrl)}'+'${agent.certificate}' //缩略图地址
						};
			 pic.push(str);
		  	var img={
				  "title":"",//相册标题
				  "id":id, 
				  "start":0,//初始显示的图片序号，默认0
				  "data": pic,
		  		};
		  		layer.photos({
			  		photos:img,
		  		});
			
	   	}
		
		
		function jump() {
			window.location.href = "${ctx}/agentSystem/SysUser/list";
		}
		
	</script>
</body>
</html>