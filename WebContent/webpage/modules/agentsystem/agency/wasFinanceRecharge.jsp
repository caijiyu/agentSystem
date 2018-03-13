
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 财务充值页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style type="text/css">		
		#publicAccount{
			background-color: white !important;
		}
		#cashPledge{
			background-color: white !important;
		}
		#hardwareAccount{
			background-color: white !important;
		}
		#minaAccount{
			background-color: white !important;
		}
		#vipAccount{
			background-color: white !important;
		}
	</style>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h3 class="cardTitle">代理商充值</h3>
					<hr class="m-t-0 m-b-40">
					<form action="${ctx}/agentSystem/SysUser/getAgentRecharge" method="post" style="width: 100%" id="refreshForm">
						<input type="hidden" value="" id="id" name="id"> 
						<div class="form-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">账号：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" value="${agent.login_name}"
												readonly="readonly">
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">公司全称：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" value="${fn:escapeXml(agent.companyName)}" id="company"
												readonly="readonly">
										</div>
									</div>
								</div>
							</div>


							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">套餐折扣：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control height-control rightAngle" value="${agent.packageDiscount}" readonly>
												<span class="input-group-addon height-control leftAngle">折</span>
											</div>
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">公众号折扣：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control height-control rightAngle" value="${agent.publicDiscount}" readonly>
												<span class="input-group-addon height-control leftAngle">折</span>
											</div>
										</div>
									</div>
								</div>
								<!--/span-->
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">小程序折扣：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control height-control rightAngle" value="${agent.minaDiscount}" readonly>
												<span class="input-group-addon height-control leftAngle">折</span>
											</div>
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">所属上级：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" value="${fn:escapeXml(agent.companyParent.companyName)}"
												readonly="readonly">
										</div>
									</div>
								</div>

								<!--/span-->
							</div>
							<!--/row-->


							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">代理商等级：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" value="${fn:escapeXml(agent.agentLevel)}"
												readonly="readonly">
										</div>
									</div>
								</div>
								<!--/span-->
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">客户等级：</label>
										<div class="col-md-9">
											<c:if test="${agent.customerLevel == 1}">
												<input type="text" class="form-control" value="VIP用户" readonly>	
											</c:if>
											<c:if test="${agent.customerLevel == 0 }">
												<input type="text" class="form-control" value="普通用户" readonly>
											</c:if> 
										</div>
									</div>
								</div>



								<!--/span-->
							</div>

							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">时间范围：</label>
										<div class="col-md-9">
											<div class="input-daterange input-group" id="date-range">
												<input type="text" class="form-control height-control rightAngle" name="start"
													value="<fmt:formatDate value="${agent.startDate}" pattern="yyyy-MM-dd"/>" readonly> <span
													class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span> <input
													type="text" class="form-control height-control leftAngle" name="end"
													value="<fmt:formatDate value="${agent.endDate}" pattern="yyyy-MM-dd"/>" readonly>
											</div>
										</div>
									</div>
								</div>
								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">平台押金：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control rightAngle" value="${agent.cashPledge}${'元'}" id="cashPledge"
													readonly="readonly"> 
													 <button type="button" class="btn waves-effect waves-light btn-info leftAngle" onclick="showModal('${agent.id}','cashPledge',this)"> 充值
                                                      </button>
											</div>

										</div>
									</div>
								</div>

							
							</div>

							<div class="row">


								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">公众号余额：</label>
										<div class="col-md-9">

											<div class="input-group">
												<input type="text" class="form-control rightAngle" value="${agent.publicAccount}${'元'}" id="publicAccount"
													readonly="readonly">
													<button type="button" class="btn waves-effect waves-light btn-info leftAngle"  onclick="showModal('${agent.id}','publicAccount')"> 充值
                                                      </button>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">硬件余额：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control rightAngle" value="${agent.hardwareAccount}${'元'}" id="hardwareAccount"
													readonly="readonly">
													<button type="button" class="btn waves-effect waves-light btn-info leftAngle" onclick="showModal('${agent.id}','hardwareAccount')"> 充值
                                                      </button>
											</div>
										</div>
									</div>
								</div>
							</div>
							<!--/row-->
							<div class="row">


								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">小程序余额：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control rightAngle" value="${agent.minaAccount}${'元'}" id="minaAccount"
													readonly="readonly"> 
													<button type="button" class="btn waves-effect waves-light btn-info leftAngle" onclick="showModal('${agent.id}','minaAccount')"> 充值
                                                      </button>
											</div>
										</div>
									</div>
								</div>

								<div class="col-md-6">
									<div class="form-group row">
										<label class="col-3 col-form-label">VIP余额：</label>
										<div class="col-md-9">
											<div class="input-group">
												<input type="text" class="form-control rightAngle" value="${agent.vipAccount}${'元'}" id="vipAccount"
													readonly="readonly"> 
													<button type="button" class="btn waves-effect waves-light btn-info leftAngle" onclick="showModal('${agent.id}','vipAccount')"> 充值
                                                      </button>
											</div>
										</div>
									</div>
								</div>
							</div>

						</div>
						<div class="form-group row">
							<label class="col-3 col-form-label"></label>
							<div class="col-9">
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
	<!-- 模态框 -->

<div class="modal fade" id="cashModal" data-backdrop="static">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top: 150px;">
            <div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
            <span id="modal-header-title"></span>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span
                        aria-hidden="true">×</span></button>
            </div>
            <div class="modal-body">
                <form id="cashForm">
                 <input type="hidden" value="" id="agentId" name="id">
                 <input type="hidden" value="" id="sign" name="sign">  
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label" >公司名称：</label>
                        <div class="col-7">
                            <input type="text" class="form-control" id="companyName"  value="" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label" id="recipient" >押金充值：</label>
                        <div class="col-7">
                        <div>
                            <div class="input-group">
                                <input type="text" autocomplete="off" class="form-control height-control rightAngle"   name="price"  id="price" maxlength="9">
                                <span class="input-group-addon height-control leftAngle">元</span>  
                            </div>
                            </div>
                        </div>
                    </div>
                     <div class="form-group row" >
                        <label for="recipient" class="col-4 col-form-label">备注：</label>
                        <div class="col-7">
                        	<div>
                            <div class="input-group">
                                <textarea class="form-control" style="word-break: break-all;" spellcheck="false" name="remarks" id="remarks" spellcheck="false" maxlength="50"></textarea>
                            </div>
                            </div>
                        </div>
                    </div>
                </form>
            </div>
            
            <div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
                <button type="button" class="btn waves-effect waves-light btn-info" onclick="recharge()">确认</button>
            </div>
        </div>
    </div>
</div>
	<script type="text/javascript">
	
		$("document").ready(function() {
			//表单验证
			$("#cashForm").validate(
				{
					rules : {
						price:{
							required: true,
							number: true,
							minNumber: $("#price").val(),
							range: [0.01,999999.99]
						},
					},
					
					//错误信息提示
					messages:{
						price:{
							required: "请填写充值金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0.01到999999.99之间的金额范围"
						},
					},
					errorPlacement : function(error, element) {	
		            	error.insertAfter( element.parent().parent()); 		            	         
					}
				});
			 jQuery.validator.addMethod("minNumber",function(value, element){
		            var returnVal = true;
		            inputZ=value;
		            var ArrMen= inputZ.split(".");    //截取字符串
		            if(ArrMen.length==2){
		                if(ArrMen[1].length>2){    //判断小数点后面的字符串长度
		                    returnVal = false;
		                    return false;
		                }
		            }
		            return returnVal;
		        },"小数点后最多为两位"); 
	        
		});
		
		
		
		function showModal(agentId,sign,obj) {
			$(obj).blur();
			$("#cashForm").data("validator").resetForm();
			document.getElementById("cashForm").reset(); 
			$("#agentId").val(agentId);
			$("#companyName").val($("#company").val());
			$("#sign").val(sign);
			if(sign == "cashPledge") {				
				$("#modal-header-title").text("押金账户充值");
				$("#recipient").html("<span style='color: red'>*&nbsp;</span>押金充值：");
			}
			if(sign == "hardwareAccount") {
				$("#modal-header-title").text("硬件账户充值");
				$("#recipient").html("<span style='color: red'>*&nbsp;</span>硬件充值：");
			}
			if(sign == "publicAccount") {
				$("#modal-header-title").text("公众号账户充值");
				$("#recipient").html("<span style='color: red'>*&nbsp;</span>公众号充值：");
			}
			if(sign == "minaAccount") {
				$("#modal-header-title").text("小程序账户充值");
				$("#recipient").html("<span style='color: red'>*&nbsp;</span>小程序充值：");
			}
			if(sign == "vipAccount") {
				$("#modal-header-title").text("VIP账户充值");
				$("#recipient").html("<span style='color: red'>*&nbsp;</span>VIP充值：");
			}
			$("#cashModal").modal("show");
		}
		function recharge() {
			$("#id").val('${agent.id}');
			var isValid = $("#cashForm").valid();
			if(isValid) {
				var locked = false;
				layer.confirm('是否确认充值?', {
					closeBtn : 0,
					skin : 'layui-layer-molv',
					icon : 3,
					btn : [ '确认', '取消' ]
				//按钮
				},function() {
					if(!locked) {
						locked = true;
						var index = layer.load(1, {shade: [0.1,'#fff']});
						$.ajax({
							url : "${ctx}/agentSystem/SysUser/updateAccount",
							type : "post",
							dataType : "json",
							data : $('#cashForm').serialize(),
							success : function(result) {
								layer.close(index);
								if (result == 1) {
									$("#cashModal").hide();
									layer.msg("充值成功！", {
										icon : 1,
										time : 1000
									});
									setTimeout("sumbitForm()",1000);
								} else {
									$("#cashModal").modal("hide");
									layer.msg("充值失败！", {
										icon : 1,
										time : 1000
									});
								}
							}
						});
					}
				
				});
			}
		}
		function sumbitForm() {
			$("#refreshForm").submit();
		}
		function jump() {
			window.location.href = "${ctx}/agentSystem/SysUser/list";
		}
	</script>
</body>
</html>