<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>

	<head>
		<!-- 提交终端 -->
		<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
		<style>
			.error {
				color: red;
			}
			
			select.error {
				color: #67757c;
			}
			
			select {
				height: 18px
			}
		</style>
	</head>

	<body>
		<div class="row divControl">
			<div class="col-sm-12">
				<div class="card">
					<div class="card-body">
						<h3 class="box-title cardTitle">
						${(empty wasTerminalUser.terminalUserId)?"添加终端":"编辑终端"}
					</h3>
						<hr class="m-t-0 m-b-40">
						<form class="form">
							<div class="row">
								<div class="col-md-12">
									<input type="text" class="form-control" id="terminalUserId" name="terminalUserId" value="${(empty wasTerminalUser.terminalUserId)? '':wasTerminalUser.terminalUserId}" hidden>
									<%-- <input type="text" class="form-control" name="parentId" value="${wasTerminalUser.parentId}"  hidden> --%>
									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">${(empty wasTerminalUser.terminalUserId)?'*&nbsp;':''}</span>公司名称：</label>
										<div class="col-md-9">
											<input id="companyName" type="text" class="form-control" name="companyName" maxlength="30" value="${fn:escapeXml(wasTerminalUser.companyName)}">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">*&nbsp;</span>负责人：</label>
										<div class="col-md-9">
											<input type="text" class="form-control form-control-danger" name="name" maxlength="10" value="${fn:escapeXml(wasTerminalUser.name)}">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">*&nbsp;</span>联系方式：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" name="phone" value="${wasTerminalUser.phone}">
										</div>
									</div>

									<div id="add" class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">*&nbsp;</span>地区：</label>
										<div class="col-md-9  area ">
											<div id="distpicker" class="row" style="height:35px">
												<div class=" col-md-4">
													<label class="sr-only" for="province6">Province</label>
													<select class="form-control" id="province6" name="province" style="padding:0px"></select>
												</div>
												<div class=" col-md-4">
													<label class="sr-only" for="city6">City</label>
													<select class="form-control" id="city6" name="city" style="padding:0px"></select>
												</div>
												<div class=" col-md-4">
													<label class="sr-only" for="district6">District</label>
													<select class="form-control" id="district6" name="county" style="padding:0px"></select>
												</div>
											</div>
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">*&nbsp;</span>详细地址：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" name="address" maxlength="50" value="${fn:escapeXml(wasTerminalUser.address)}">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">${(empty wasTerminalUser.terminalUserId)?'*&nbsp;':''}</span>账号：</label>
										<div class="col-md-9">
											<input id="loginName" type="text" class="form-control" name="loginName" maxlength="15" value="${fn:escapeXml(wasTerminalUser.loginName)}" ${(empty wasTerminalUser.terminalUserId)? '': "readonly"}>
										</div>
									</div>

									<div class="form-group row" hidden>
										<label class="col-form-label text-right col-md-2"><span style="color: red">*&nbsp;</span>密码：</label>
										<div class="col-md-9">
											<input id="password" type="text" class="form-control" name="password" value="${fn:escapeXml(wasTerminalUser.password)}">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label text-right col-md-2"><span style="color: red">${(empty wasTerminalUser.terminalUserId)?'*&nbsp;':''}</span>密码：</label>
										<div class="col-md-9">
											<input id="secondPassword" type="text" class="form-control" name="secondPassword" maxlength="20" placeHolder="${(empty wasTerminalUser.terminalUserId)?'':'如不修改密码，请不要输入'}">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-2 col-form-label"></label>
										<div class="col-9">
											<div class="text-xs-right" style="text-align: right;">
												<c:if test="${!empty wasTerminalUser.terminalUserId}">
													<button type="button" class="btn btn-default" onclick="back()">返回</button>
												</c:if>
												<shiro:hasPermission name="terminal:wasTerminalUser:add">
													<button id="saveTerminalUser" type="button" class="btn waves-effect waves-light btn-info">保存</button>
												</shiro:hasPermission>
											</div>
										</div>
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
			</div>
		</div>

		<script src="${ctxStatic}/agentSystem/js/distpicker.data.js"></script>
		<script src="${ctxStatic}/agentSystem/js/distpicker.js"></script>
		<script type="text/javascript">
			$(document).ready(function() {
				//初始化省市区
				$('#distpicker').distpicker({
					province: "${empty wasTerminalUser.province?'---- 选择省 ----':wasTerminalUser.province }",
					city: "${empty wasTerminalUser.city?'---- 选择市 ----':wasTerminalUser.city }",
					district: "${empty wasTerminalUser.county?'---- 选择区 ----':wasTerminalUser.county }"
				});
				//表单验证
				$("form").validate({
					rules: {
						companyName: {
							required: true,
							minlength: 2,
							maxlength: 30
						},
						name: {
							required: true,
							minlength: 2,
							maxlength: 10,
						},
						phone: {
							required: true,
							isphone: true,
						},
						province: {
							validateArea: true,
						},
						address: {
							required: true,
							minlength: 1,
							maxlength: 50,
						},
						loginName: {
							required: true,
							minlength: 5,
							maxlength: 15,
							isRightLoginNameForm: true,
							remote: {
								type: "POST",
								url: "${ctx}/agentSystem/terminal/wasTerminalUser/" + "${(empty wasTerminalUser.terminalUserId)?'VName':'validate'}",								          
								data: {
									loginName: function() {
										return  $("#loginName").val();
									},
								}
							}
						},
						secondPassword: {
							required: true,
							minlength: 6,
							maxlength: 20,
							isRightPasswordForm: true,
						}
					},
					messages: {
						companyName: {
							required: "请输入公司名称",
							minlength: "公司名称至少为2个字符",
							maxlength: "公司名称最多为30个字符"
						},
						name: {
							required: "请输入负责人名字",
							minlength: "负责人名字至少为2个字符",
							maxlength: "负责人名字最多为10个字符"
						},
						phone: {
							required: "请输入联系方式",
						},
						address: {
							required: "请输入详细地址",
							minlength: "地址至少为1个字符",
							maxlength: "地址最多为50个字符"
						},
						loginName: {
							required: "请输入账号",
							minlength: "账号至少5个字符",
							maxlength: "账号最多15个字符",
							remote: "此账号已经注册过"
						},
						secondPassword: {
							required: "请输入密码",
							minlength: "密码至少6个字符",
							maxlength: "密码最多20个字符"
						},
					},
					errorPlacement: function(error, element) {
						if(element.attr("id") == "province6") {
							$(".area").append(error)
						} else {
							error.insertAfter(element);
						}
					}
				});
				jQuery.validator.addMethod("isphone", function(value, element) {
					//var isphone =  /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9})|(^400-?[0-9]{3}-?[0-9]{4})|(^800-?[0-9]{3}-?[0-9]{4}))$/;   
					var isphone = /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9}))$/;
					return this.optional(element) || (isphone.test(element.value));
					//return this.optional(element) || (isphone.test(value));  
				}, $.validator.format("请输入正确的电话号码"));
				jQuery.validator.addMethod("isRightLoginNameForm", function(value, element) {
					var rightLoginNameForm = /^[a-zA-Z][a-zA-Z0-9]{4,14}$/;
					return(rightLoginNameForm.test(value));
				}, "账号只能由字母数字组成，且只能以字母开头");
				jQuery.validator.addMethod("isRightPasswordForm", function(value, element) {
					var rightPasswordForm = /^[a-zA-Z0-9]{0,20}$/;
					return(rightPasswordForm.test(value));
				}, "密码只能由字母数字组成");
				jQuery.validator.addMethod("validateArea", function(value, element) {
					return("" != value);
				}, "请选择地区");
				//保存数据
				$("#saveTerminalUser").click(function() {
					//编辑状态下去掉密码必须校验规则
					if('${(empty wasTerminalUser.terminalUserId)}' == 'false') {
						$("#secondPassword").rules('remove', 'required');
					}
					var locked = false;
					if(!locked && $("form").valid()) {
						//处理密码
						var pwd = $("#secondPassword").val()
						if(pwd.length > 0) {
							$("#password").val(pwd)
						}
						locked = true;
						layer.confirm('是否确认保存？', {
							closeBtn: 0,
							icon: 3,
							skin: 'layui-layer-molv',
							btn: ['确认', '取消']
						}, function() {
							var index = layer.load(1, {
								shade: [0.1, '#fff']
							});
							$.ajax({
								url: "${ctx}/agentSystem/terminal/wasTerminalUser/save",
								type: "post",
								dataType: "text",
								async: false,
								data: $('form').serialize(),
								success: function(data) {
									layer.close(index);
									locked = false;
									if(data > 0) {
										if($("#terminalUserId").val() != '') {
											layer.msg("保存成功！", {
												icon: 1,
												time: 2000,
												shade: [0.1, '#fff']
											}, function() {
												var btn = window.parent.document.getElementById("d27fba1272a44378910684252a3b6893")
												btn.click()
											});
										} else {
											layer.msg("保存成功，请为该终端选择产品！", {
												icon: 1,
												time: 2000,
												shade: [0.1, '#fff']
											}, function() {
												$("#fa8c13b84b104043a63a8f9f7677a254", window.parent.document).removeClass("active");
												$("#07b4d0f6f7bc4d6e9541591a484e4fa9", window.parent.document).addClass("active");
												window.location.href = "${ctx}/agentSystem/terminal/wasRecharge/toAddProductList?terminalUserId=" + data;
											});
										}
									} else {
										layer.msg("保存失败", {
											icon: 2,
											time: 1000
										});
									}
								},
								error: function(result) {
									layer.close(index);
									locked = false;
									layer.msg("保存失败", {
										icon: 2,
										time: 1000
									}, function() {
										return;
									});
								}
							});
						});
					}
				})
			});
			//编辑状态下返回终端列表页面方法
			function back() {
				layer.confirm('确认放弃本次操作？', {
					closeBtn: 0,
					icon: 3,
					skin: 'layui-layer-molv',
					btn: ['确认', '取消']
				}, function() {
					window.location.href = "${ctx}/agentSystem/terminal/wasTerminalUser/list";
				})
			}
		</script>
	</body>

</html>