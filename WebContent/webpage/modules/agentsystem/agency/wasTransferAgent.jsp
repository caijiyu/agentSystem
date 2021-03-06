
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 代理商转移页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h3 class="cardTitle">代理商转移</h3>
					<hr class="m-t-0 m-b-40">
					<form action="#" method="post" style="width: 100%" id="transferForm">
						<input type="hidden" value="${agent.id}" id="id" name="id">
						<div class="form-body">
							<div class="form-group row">
								<label class="col-2 col-form-label">当前代理商：</label>
								<div class="col-md-9">
									<input type="text" class="form-control" value="${fn:escapeXml(agent.companyName)}" id="companyName" readonly>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label">下级代理商：</label>
								<div class="col-md-9">
									<select class="form-control custom-select height-control" tabindex="1" name="companyParentId" id="companyParentId" >
										<option value="Category">请选择</option>
										<c:forEach items="${agentList}" var="agent">
											<option value="${agent.id}">${fn:escapeXml(agent.companyName)}</option>
										</c:forEach>
									</select>
								</div>

							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label">当前代理商硬件余额：</label>
								<div class="col-md-9">
									<div class="input-group">
										<input type="text" class="form-control rightAngle" value="${agent.hardwareAccount }${'元'}"
											id="hardwareMoney" readonly>
										<button type="button" id="hardwareBtn" disabled="disabled"
											class="btn waves-effect waves-light btn-info leftAngle"
											onclick="showAccountModal('${agent.id}','hardwareAccount',this)">转移</button>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label">当前代理商公众号余额：</label>
								<div class="col-md-9">
									<div class="input-group">
										<input type="text" class="form-control rightAngle" value="${agent.publicAccount }${'元'}"
											id="publicMoney" readonly>
										<button type="button" id="publicBtn" disabled="disabled"
											class="btn waves-effect waves-light btn-info leftAngle"
											onclick="showAccountModal('${agent.id}','publicAccount',this)">转移</button>
									</div>
								</div>

							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label">当前代理商小程序余额：</label>
								<div class="col-md-9">
									<div class="input-group">
										<input type="text" class="form-control rightAngle" value="${agent.minaAccount }${'元'}"
											id="minaMoney" readonly>
										<button type="button" id="minaBtn" disabled="disabled"
											class="btn waves-effect waves-light btn-info leftAngle"
											onclick="showAccountModal('${agent.id}','minaAccount',this)">转移</button>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label">当前代理商VIP余额：</label>
								<div class="col-md-9">
									<div class="input-group">
										<input type="text" class="form-control rightAngle" value="${agent.vipAccount }${'元'}"
											id="vipMoney" readonly>
										<button type="button" id="vipBtn" disabled="disabled"
											class="btn waves-effect waves-light btn-info leftAngle" onclick="showVipModal('${agent.id}',this)">转移</button>
									</div>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-2 col-form-label"></label>
								<div class="col-9">
									<div class="text-xs-right" style="text-align: right;">
										<button type="button" class="btn btn-default" onclick="jump()">返回</button>
									</div>
								</div>
							</div>
						</div>

					</form>
				</div>

			</div>
		</div>
	</div>
	<!-- 模态框 -->
	<div class="modal fade" id="accountModal" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="margin-top: 100px;width:530px">
				<div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
				<label class="modal-title" id="title" style="font-size: 14px"></label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="accountForm">
						<input type="hidden" value="" id="agentId" name="id">
						<input type="hidden" value="" id="redoundId" name="redoundId">
						<input type="hidden" value="" id="sign" name="sign"> 
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label">下级代理商：</label>
							<div class="col-7">
								<input type="text" class="form-control" id="agentName" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label" >下级代理商押金充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendA" name="cashPledge"
										id="cashPledge" value="0" maxlength="9"> <span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label" id="recipient"></label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendA" name="price"
										id="price" value="0" maxlength="9"> <span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label">备注：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<textarea style="word-break: break-all;" class="form-control" name="remarks"
										id="remarks" maxlength="50" spellcheck="false"></textarea>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
	                	<div class="col-11" >
	                		<div style="float: right; font-size:13px"><span id="koukuan"></span><span id="totalAccountMoney"></span>元</div>
	                	</div>
	                </div>
					</form>
				</div>

				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn waves-effect waves-light btn-info"
						onclick="saveTransferAccount()">确认</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="vipModal" data-backdrop="static">
		<div class="modal-dialog" role="document">
			<div class="modal-content" style="width:530px">
				<div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<label class="modal-title" id="exampleModalLabel" style="font-size: 14px">VIP账户转移</label>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<div class="modal-body">
					<form id="vipForm">
						<input type="hidden" value="" id="agentIdA" name="id"> 
						<input type="hidden" value="" id="redoundIdA" name="redoundId">
						<div class="form-group row">
							<label for="recipient" class="col-4 control-label">下级代理商：</label>
							<div class="col-7">
								<input type="text" class="form-control" id="redoundName"
									value="" readonly>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label" >下级代理商押金充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendB" name="cashPledge" id="cashTra" value="0" maxlength="9">
									<span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label">下级代理商硬件充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendB" name="hardwareAccount" id="hardwareAccount" value="0" maxlength="9">
									<span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label">下级代理商公众号充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendB" name="publicAccount" id="publicAccount" value="0" maxlength="9">
									<span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label" >下级代理商小程序充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendB" name="minaAccount" id="minaAccount" value="0" maxlength="9">
									<span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label" >下级代理商VIP充值：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<input type="text" autocomplete="off" class="form-control height-control rightAngle ExpendB" name="vipAccount" id="vipAccount" value="0" maxlength="9">
									<span class="input-group-addon height-control leftAngle">元</span>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="recipient" class="col-4 col-form-label">备注：</label>
							<div class="col-7">
								<div>
								<div class="input-group">
									<textarea style="word-break: break-all;" spellcheck="false" class="form-control" name="remarks" id="vipRemark" maxlength="50" spellcheck="false"></textarea>
								</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
	                	<div class="col-11" >
	                		<div style="float: right; font-size:13px">${fn:escapeXml(agent.companyName)}VIP账户扣款总额：<span id="totalVipMoney"></span>元</div>
	                	</div>
	                </div>
					</form>
				</div>

				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn waves-effect waves-light btn-info"
						onclick="updateTraVipAccount()">确认</button>
				</div>
			</div>
		</div>
	</div>
	<script type="text/javascript">

		$("document").ready(function() {
			
			$("#accountForm").validate(
					{
						rules : {
							cashPledge:{
								required:true,
								number: true,
								minNumber: $("#cashPledge").val(),
							},
							price:{
								required:true,
								number: true,
								minNumber: $("#price").val(),
							},
						},
						
						//错误信息提示
						messages:{
							cashPledge:{
								required:"请输入金额",
								number: "请正确输入金额",
								length: "输入数字最多小数点后两位",
							},
							price:{
								required:"请输入金额",
								number: "请正确输入金额",
								length: "输入数字最多小数点后两位",
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
		$("#vipForm").validate(
				{
					rules : {
						cashPledge:{
							required:true,
							number: true,
							minNumber: $("#cashPledge").val(),
							range:[0,'${agent.vipAccount}']
						},
						hardwareAccount:{
							required:true,
							number: true,
							minNumber: $("#price").val(),
							range:[0,'${agent.vipAccount}']
						},
						publicAccount:{
							required:true,
							number: true,
							minNumber: $("#price").val(),
							range:[0,'${agent.vipAccount}']
						},
						minaAccount:{
							required:true,
							number: true,
							minNumber: $("#price").val(),
							range:[0,'${agent.vipAccount}']
						},
						vipAccount:{
							required:true,
							number: true,
							minNumber: $("#price").val(),
							range:[0,'${agent.vipAccount}']
						},
					},
					
					//错误信息提示
					messages:{
						cashPledge:{
							required:"请输入金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0到${agent.vipAccount}之间的金额范围"
						},
						hardwareAccount:{
							required:"请输入金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0到${agent.vipAccount}之间的金额范围"
						},
						publicAccount:{
							required:"请输入金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0到${agent.vipAccount}之间的金额范围"
						},
						minaAccount:{
							required:"请输入金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0到${agent.vipAccount}之间的金额范围"
						},
						vipAccount:{
							required:"请输入金额",
							number: "请正确输入金额",
							length: "输入数字最多小数点后两位",
							range: "请输入0到${agent.vipAccount}之间的金额范围"
						},
					},
					errorPlacement : function(error, element) {	
		            	error.insertAfter( element.parent().parent()); 		            	         
					}
				});
	        
		});
		var currentId,lowerName;
 		$("#companyParentId").change(function() {
 			if($(this).val() != "Category") {
 				$("#hardwareBtn").attr("disabled", false); 
 				$("#publicBtn").attr("disabled", false);
 				$("#minaBtn").attr("disabled", false);
 				$("#vipBtn").attr("disabled", false); 
 				currentId = $(this).val();
 				lowerName = $(this).find("option:selected").text();
 			}else {
 				$("#hardwareBtn").attr("disabled", true); 
 				$("#publicBtn").attr("disabled", true);
 				$("#minaBtn").attr("disabled", true);
 				$("#vipBtn").attr("disabled", true);
 			}
		});
		
		function showAccountModal(agentId,sign,obj) {
				$(obj).blur();
				var name=$("#companyName").val();
				$("#accountForm").data("validator").resetForm();
				document.getElementById("accountForm").reset();
				$("#sign").val(sign);
				$("#agentName").val(lowerName);
				$("#redoundId").val(currentId);
				$("#agentId").val(agentId);
				$("#totalAccountMoney").text(0);
				$("#remarks").val("");
				var account,accountMoney;
				if(sign == "hardwareAccount") {
					$("#title").text("硬件账户转移");
					$("#recipient").html("下级代理商硬件充值：");
					$("#koukuan").text(name+"硬件账户扣款总额：");
					account =$("#hardwareMoney").val();
					accountMoney = account.substring(0,account.length-1);
						if(accountMoney==0) {
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
						}else{
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
						}
				}
				if(sign == "publicAccount") {
					$("#title").text("公众号账户转移");
					$("#recipient").html("下级代理商公众号充值：");
					$("#koukuan").text(name+"公众号账户扣款金额：");
					account =$("#publicMoney").val();
					accountMoney = account.substring(0,account.length-1);
						if(accountMoney == 0) {
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
						}else{
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
						}						
					}
				if(sign == "minaAccount") {
					$("#title").text("小程序账户转移");
					$("#recipient").html("下级代理商小程序充值：");
					$("#koukuan").text(name+"小程序账户扣款金额：");
					account =$("#minaMoney").val();
					accountMoney = account.substring(0,account.length-1);
						if(accountMoney==0){
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
		                         } 
							});
						}else{
							$("#price").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
							$("#cashPledge").rules("add",{
								range: [0,accountMoney],
								messages : {  
		                             range  : "请输入0到"+accountMoney+"之间的金额范围", 
		                         } 
							});
						}
				}
				$("#accountModal").modal("show");	
		}
		$('.ExpendA').bind('input propertychange', function() {
			var total=0;
			$('.ExpendA').each(
				function(){
					if(!isNaN(this.value)){
						total+=Number(this.value);
					}
			});
			$('#totalAccountMoney').html(total.toFixed(2));
		});
		
		
		function saveTransferAccount() {
			var isValid = $("#accountForm").valid();
			var flag,isValidate,totalMoney;
			if(isValid) {
				if($("#price").val() == 0 && $("#cashPledge").val() == 0) {
					flag = false;
					layer.msg("您还未输入一个非0的转移金额",{icon:7,time:1500});
				}else {
					flag = true;
				}
				totalMoney = $("#totalAccountMoney").text();
				var str, money;
				if($("#sign").val() == 'hardwareAccount') {
					str = $("#hardwareMoney").val();
					money = str.substring(0,str.length-1);
					if(Number(money)==0){
						layer.msg("当前代理商账户余额为0.00元，请先充值后再进行转移",{icon:7,time:1500});
						isValidate = false;	
					}else if(Number(totalMoney) > Number(money)) {
						layer.msg("您输入的转移金额大于当前硬件账户的余额"+money+"元",{icon:7,time:1500});
						isValidate = false;
					}else{
						isValidate = true;
					}
				}
				if($("#sign").val() == 'publicAccount') {
					str = $("#publicMoney").val();
					money = str.substring(0,str.length-1);
					if(Number(money)==0){
						layer.msg("当前代理商账户余额为0.00元，请先充值后再进行转移",{icon:7,time:1500});
						isValidate = false;	
					}else if(Number(totalMoney) > Number(money)) {
						layer.msg("您输入的转移金额大于当前公众号账户的余额"+money+"元",{icon:7,time:1500});
						isValidate = false;
					}else{
						isValidate = true;
					}
				}
				if($("#sign").val() == 'minaAccount') {
					str = $("#minaMoney").val();
					money = str.substring(0,str.length-1);
					if(Number(money)==0){
						layer.msg("当前代理商账户余额为0.00元，请先充值后再进行转移",{icon:7,time:1500});
						isValidate = false;	
					}else if(Number(totalMoney) > Number(money)) {
						layer.msg("您输入的转移金额大于当前小程序账户的余额"+money+"元",{icon:7,time:1500});
						isValidate = false;
					}else{
						isValidate = true;
					}
				}
			}
			if(isValid && flag && isValidate) {
				var locked = false;
				layer.confirm('是否确认转移?', {
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
							url : "${ctx}/agentSystem/SysUser/updateTransferAccount",
							type : "post",
							dataType : "json",
							data : $('#accountForm').serialize(),
							success : function(result) {
								layer.close(index);
									$("#accountModal").modal("hide");
									if($("#title").text() =='硬件账户转移') {
										$("#hardwareMoney").val(result.toFixed(2)+"元");	
										hardCount = 1;
										$("#cashPledge").rules("remove","range");
										$("#price").rules("remove","range");
										if(Number(result)==0.00){
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
										}else{
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
										}
									}else if($("#title").text() =='公众号账户转移') {
										$("#publicMoney").val(result.toFixed(2)+"元");
										pubCount = 1;
										$("#cashPledge").rules("remove","range");
										$("#price").rules("remove","range");
										if(Number(result)==0.00){
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
										}else{
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
										}
									}else if($("#title").text() =='小程序账户转移') {
										$("#minaMoney").val(result.toFixed(2)+"元");
										minCount = 1;
										$("#cashPledge").rules("remove","range");
										$("#price").rules("remove","range");
										if(Number(result)==0.00){
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
						                         } 
											});
										}else{
											$("#cashPledge").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
											$("#price").rules("add",{
												range: [0,result],
												 messages : {  
						                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
						                         } 
											});
										}
									}
									layer.msg("转移成功！", {
										icon : 1,
										time : 1000
									});
									
							}
						});
					}
				
				});
			}
		}
		
		function showVipModal(agentId,obj) {
			$(obj).blur();
			$("#vipForm").data("validator").resetForm();
			document.getElementById("vipForm").reset();  
			$("#redoundName").val(lowerName);
			$("#redoundIdA").val(currentId);
			$("#agentIdA").val(agentId);		
			$("#totalVipMoney").text(0);
			var vip = $("#vipMoney").val();
			var vipMoney = vip.substring(0,vip.length-1);
				if(vipMoney==0){
					$("#cashTra").rules("remove","range");
					$("#hardwareAccount").rules("remove","range");
					$("#publicAccount").rules("remove","range");
					$("#minaAccount").rules("remove","range");
					$("#vipAccount").rules("remove","range");
					$("#cashTra").rules("add",{
						range: [0,0],
						 messages : {  
                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
                         } 
					});
					$("#hardwareAccount").rules("add",{
						range: [0,0],
						 messages : {  
                             range  :"当前代理商账户余额为0元，请先充值后再进行转移", 
                         } 
					});
					
					$("#publicAccount").rules("add",{
						range: [0,0],
						 messages : {  
                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
                         } 
					});
					$("#minaAccount").rules("add",{
						range: [0,0],
						 messages : {  
                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
                         } 
					});
					$("#vipAccount").rules("add",{
						range: [0,0],
						 messages : {  
                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
                         } 
					}); 
				}
			$("#vipModal").modal("show");
		}
		$('.ExpendB').bind('input propertychange', function() {
			var total=0;
			$('.ExpendB').each(
				function(){
					if(!isNaN(this.value)){
						total+=Number(this.value);
					}
			});
			$('#totalVipMoney').html(total.toFixed(2));
		});
		
		function updateTraVipAccount() {
			var isValid = $("#vipForm").valid();
			var totalMoney = $("#totalVipMoney").html();
			var str = $("#vipMoney").val();
			var vipMoney = str.substring(0,str.length-1);
			if(isValid) {
				if(Number(totalMoney) == 0.00) {
					layer.msg("您还未输入一个非0的转移金额",{icon:7,time:1500});
					return;
				}
				if(Number(vipMoney)==0){
					layer.msg("当前代理商账户余额为0.00元，请先充值后再进行转移",{icon:7,time:1500});
					return;
				}else if(Number(totalMoney) > Number(vipMoney)) {
					layer.msg("您输入的转移金额大于当前VIP账户的余额"+vipMoney+"元",{icon:7,time:1500});
					return;
				}
				var locked = false;
				layer.confirm('是否确认转移?', {
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
							url : "${ctx}/agentSystem/SysUser/updateTransferVipAccount",
							type : "post",
							dataType : "json",
							data : $('#vipForm').serialize(),
							success : function(result) {
								layer.close(index);
									$("#vipModal").modal("hide");
									$("#vipMoney").val(result.toFixed(2)+"元");
									
									//添加动态校验
									$("#cashTra").rules("remove","range");
									$("#hardwareAccount").rules("remove","range");
									$("#publicAccount").rules("remove","range");
									$("#minaAccount").rules("remove","range");
									$("#vipAccount").rules("remove","range");
									if(Number(result)==0.00){
										$("#cashTra").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
					                         } 
										});
										$("#hardwareAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  :"当前代理商账户余额为0元，请先充值后再进行转移", 
					                         } 
										});
										
										$("#publicAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
					                         } 
										});
										$("#minaAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
					                         } 
										});
										$("#vipAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "当前代理商账户余额为0元，请先充值后再进行转移", 
					                         } 
										}); 
									}else{
										$("#cashTra").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
					                         } 
										});
										$("#hardwareAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
					                         } 
										});
										
										$("#publicAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
					                         } 
										});
										$("#minaAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
					                         } 
										});
										$("#vipAccount").rules("add",{
											range: [0,result],
											 messages : {  
					                             range  : "请输入0到"+Number(result)+"之间的金额范围", 
					                         } 
										}); 
									}								 
									
									layer.msg("转移成功！", {
										icon : 1,
										time : 1000
									});
								
							}
						});
					}
				
				});
			}
			
			
		}
		function jump() {
			window.location.href = "${ctx}/agentSystem/SysUser/list";
		}
	</script>
</body>
</html>