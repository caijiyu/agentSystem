
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--代理商申请查看页面-->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h3 class="box-title cardTitle">代理商申请详细信息</h3>
					<hr class="m-t-0 m-b-40">
						<div class="form-body">
 							<div class="row">
                                  <div class="col-md-6">
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">公司名称：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(wasSysUser.companyName) }</label> 
                                      </div>

                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">代理等级：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(wasSysUser.agentLevel) }</label>
                                      </div>
                                      
                                     <div class="form-group row">
                                      	<label class="control-label col-3" style="text-align: right;">套餐代理折扣：</label>
                                     	 <label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.packageDiscount*10 }" type="currency" pattern="#0.0#"/>折</label>
                                 	 </div>
                                 	 
                                 	    <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">公众号代理折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.publicDiscount*10 }" type="currency" pattern="#0.0#"/>折</label>

                                      </div>
                                 	 
                                	  <div class="form-group row">
										<label class="control-label col-3" style="text-align: right;">小程序代理折扣：</label>
										<label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.minaDiscount*10 }" type="currency" pattern="#0.0#"/>折</label>
									</div>
                               
									 <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">添加时间：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatDate value="${wasSysUser.startDate }" type="both" /></label>
                                      </div>

                                    <div class="form-group row">
                                      <label class="control-label col-3" style="text-align: right;">到期时间：</label>
                                      <label class="control-label col-9" style="text-align: left;"><fmt:formatDate value="${wasSysUser.endDate }" type="both" /></label>
                                 	</div>
                                 	 
                                  </div>
                                  <!--/span-->
                                  <div class="col-md-6">
                                  
                                     <div class="form-group row" id="principal">
                                       
                                          <label class="control-label col-3" style="text-align: right;">所属上级：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml(wasSysUser.companyParent.companyName) }</label>
                                         
                                      </div>
                                      
                                      <div class="form-group row">

										<label class="control-label col-3" style="text-align: right;">上级代理等级：</label>
										<label class="control-label col-9" style="text-align: left;">${fn:escapeXml((wasSysUser.companyParent.agentLevel==null||wasSysUser.companyParent.agentLevel=="")?"--":wasSysUser.companyParent.agentLevel) }</label>

									</div>
									
                                  	<div class="form-group row" id="wechat">

										<label class="control-label col-3" style="text-align: right;">上级套餐折扣：</label>
										<label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.companyParent.packageDiscount*10}" type="currency" pattern="#0.0#"/>折</label>

									</div>
                                     
									<div class="form-group row">
                                      
                                          <label class="control-label col-3" style="text-align: right;">上级公众号折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.companyParent.publicDiscount*10}" type="currency" pattern="#0.0#"/>折</label>
										
                                      </div>

									<div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">上级小程序折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${wasSysUser.companyParent.minaDiscount*10 }" type="currency" pattern="#0.0#"/>折</label>

                                      </div>
                                      
                                       <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">申请时间：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatDate value="${wasSysUser.create_date }" type="both" /></label>

                                      </div>
                                      
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">备注：</label>
                                          <label class="control-label col-9" style="text-align: left;">${fn:escapeXml((wasSysUser.remarks==null||wasSysUser.remarks=="")?"--":wasSysUser.remarks) }</label>

                                      </div>
                                     
                                     <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">证书：</label>
                                          <label class="control-label col-9" style="text-align: left;">
	                                          <c:choose>  
											   <c:when test="${(wasSysUser.certificate==null||wasSysUser.certificate=='')}">    
											   -- 
											   </c:when>  
											     
											   <c:otherwise>  
											  	 <img style="width:auto;height:100px" src="${vicmobAgentSystemFileUrl}${wasSysUser.certificate}"  onclick="layerPhoto(0)"/>
											   </c:otherwise>  
											</c:choose>  
                                        </label>

                                      </div>
                                     
                                  </div>
                              </div>
        
						</div>
						<div class="form-group row">
							<div class="col-12">
								<div class="text-xs-right" style="text-align: right;">
									<button type="button" class="btn btn-default" onclick="jump()">返回</button>
								</div>
							</div>
						</div>
				</div>

			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">
		layer.config({
			  extend: 'extend/layer.ext.js'
			}); 	
	
		function jump() {
			window.location.href = "${ctx}/agency/wasAgentApply/list";
		}
		
		function layerPhoto(index){
			   var pic = [];
				   var str={ "alt":"",//图片名
							  "src":"${vicmobAgentSystemFileUrl}"+"${wasSysUser.certificate}", //原图地址
							  "thumb":"${vicmobAgentSystemFileUrl}"+"${wasSysUser.certificate}" //缩略图地址
							  };
				   pic.push(str);
				  var img={
						  "title":"",//相册标题
						  "start":index,//初始显示的图片序号，默认0
						  "data": pic,
				  };
				  layer.photos({
					  photos:img,
					//anim:5   //0-6的选择，指定弹出图片动画类型，默认随机（请注意，3.0之前的版本用shift参数） */
				  });
		}
		
	</script>
</body>
</html>