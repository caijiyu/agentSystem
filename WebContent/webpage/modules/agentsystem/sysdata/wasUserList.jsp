
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--用户管理列表-->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
 <style type="text/css">
  .noneBorder td{
    	border:none;
    	font-size:13px;
    }
   .th{
    	text-align:right;
    }
   .error{
	color:red;
	} 
  </style>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
						<shiro:hasPermission name="sysdata:wasUser:add">
							<button type="button" class="btn btn-info" onclick="showA(this)">
								<i class="fa fa-plus-circle"></i> 添加
							</button>
						</shiro:hasPermission>  
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentsystem/user/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
								<input id="login_nameA" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入登录名关键字" value="${fn:escapeXml(log.login_name)}" style="float: right;"> 
								<input id="login_nameB" name="login_name" type="hidden" value="${fn:escapeXml(log.login_name)}" /> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">登录名</th>
								<th class="tableControl">姓名</th>
								<th class="tableControl">电话</th>
								<th class="tableControl">手机</th>
								<th class="tableControl">归属公司</th>
								<th class="tableControl">角色</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${page.list}" var="log">
								<tr>
									<td class="tableControl">${fn:escapeXml(log.login_name)}</td>
									<td class="tableControl">${fn:escapeXml(log.name)}</td>
									<td class="tableControl">${(log.phone==null||log.phone=="")?"--":log.phone}</td>
									<td class="tableControl">${(log.mobile==null||log.mobile=="")?"--":log.mobile}</td>
									<td class="tableControl">${fn:escapeXml(log.companyName)}</td>
									<td class="tableControl">${fn:escapeXml(log.roleList[0].name)}</td>
									<td class="tableControl">
										<shiro:hasPermission name="sysdata:wasUser:view">
											<button type="button" data-toggle="tooltip" data-original-title="查看" class="btn btn-info btn-circle btn-xs" onclick="showB('${log.id}',this)">
												<i class="fa fa-search-plus"></i>
											</button>
										</shiro:hasPermission>  
										<shiro:hasPermission name="sysdata:wasUser:edit">
											<button type="button" data-toggle="tooltip" data-original-title="编辑" class="btn btn-info btn-circle btn-xs" onclick="showC('${log.id}',this)">
												<i class="fa fa-edit"></i>
											</button>
										</shiro:hasPermission>  
										<shiro:hasPermission name="sysdata:wasUser:del">
											<button type="button" data-toggle="tooltip" data-original-title="删除" class="btn btn-danger btn-circle btn-xs" onclick="deleteUser('${log.id}')">
												<i class="fa fa-times"></i>
											</button>
										</shiro:hasPermission>  
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页代码 -->
					<c:if test="${page.count>10}">
						<table:page page="${page}"></table:page>
					</c:if>
				</div>
				
			</div>
		</div>
	</div>

	<!-- 模态框 1-->
	<div class="modal fade" id="modalA" data-backdrop="static">
		<div class="modal-dialog"  style="max-width: 800px;">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 10%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">添加用户</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="inputFormA">
					<input id="menuIdA" name="menuIdA" type="hidden" value="" />
						<div class="table-responsive">
							<table class="table noneBorder">
								<tr>
									<td class="th"><font color="red">*&nbsp;</font>姓名：</td>
									<td style="width: 35%;">
										<div>
											<input autocomplete="off" type="text" id="userName"  name="name"
												class="form-control height-control" required maxlength="10">
										</div>
									</td>
									<td class="th"><font color="red">*&nbsp;</font>登录名：</td>
									<td style="width: 35%;">
										<div>
											<input autocomplete="off" type="text" id="loginName"  name="login_name"
												class="form-control height-control" required maxlength="15">
										</div>
									</td>
								</tr>

								<tr>
				                    <td class="th"><font color="red">*&nbsp;</font>密码：</td>
				                    <td>
				                        <div>
							             	<input autocomplete="off" type="text" id="password"  name="password" 
												class="form-control height-control" required maxlength="20">
							            </div>
				                    </td>
				                    
				                   <td class="th"><font color="red">*&nbsp;</font>用户角色：</td>
									<td>
									     <select class="form-control custom-select height-control" id="roleList" name="roleId" required>
											
									     </select>
									</td>
				                </tr>			

								<tr>
									<td class="th">归属公司：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="companyName"  name="companyName" value="无锡微炫客"
												class="form-control height-control" maxlength="30" readOnly>
										</div>
									</td>
									
									<td class="th">手机：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="mobile"  name="mobile"
												class="form-control height-control"  maxlength="20">
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">电话：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="phone"  name="phone"
												class="form-control height-control"  maxlength="20">
										</div>
									</td>
									
									<td class="th">邮箱：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="email"  name="email"
												class="form-control height-control"  maxlength="30">
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">备注：</td>
									<td>
										<div>
											<textarea id="remarks" name="remarks" class="form-control" rows="3" maxlength="50"></textarea>
										</div>
									</td>
								</tr>

							</table>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveUser()">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态框2 -->
	<div class="modal fade" id="modalB" data-backdrop="static">
		<div class="modal-dialog"  style="max-width: 800px;">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 10%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">查看用户</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
						<div class="table-responsive">
							<table class="table noneBorder">

								<tr>
									<td class="th"><font color="red">*&nbsp;</font>姓名：</td>
									<td style="width: 35%;">
										<div id="checkName">
										
										</div>
									</td>
									<td class="th"><font color="red">*&nbsp;</font>登录名：</td>
									<td style="width: 35%;">
										<div id="checkLoginName">
										
										</div>
									</td>
								</tr>

								<tr>
									<td class="th"><font color="red">*&nbsp;</font>用户角色：</td>
									<td>
										 <div id="checkRoleList">
											
										</div>
									</td>

									<td class="th">归属公司：</td>
									<td>
										<div id="checkCompany">
											
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">手机：</td>
									<td>
										<div id="checkMobile">
											
										</div>
									</td>
									<td class="th">电话：</td>
									<td>
										<div id="checkPhone" >
										
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">邮箱：</td>
									<td>
										<div id="checkMail">
										
										</div>
									</td>
									<td class="th">备注：</td>
									<td>
										<div id="checkRemarks" style="white-space:pre-wrap;word-break:break-all;">
										
										</div>
									</td>
								</tr>

							</table>
						</div>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态框3 -->
	<div class="modal fade" id="modalC" data-backdrop="static">
		<div class="modal-dialog"  style="max-width: 800px;">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 10%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">编辑用户</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="inputFormC">
						<input id="userIdA" name="id" type="hidden" value="" /> 
						<input id="oldName" name="oldName" type="hidden" value="" /> 
						<input id="oldPassword" name="oldPassword" type="hidden" value="" /> 
						<input id="menuIdB" name="menuIdB" type="hidden" value="" />
						<div class="table-responsive">
							<table class="table noneBorder">
								<tr>
									<td class="th"><font color="red">*&nbsp;</font>姓名：</td>
									<td style="width: 35%;">
										<div>
											<input autocomplete="off" type="text" id="userNameA"  name="name"
												class="form-control height-control" required maxlength="10">
										</div>
									</td>
									<td class="th"><font color="red">*&nbsp;</font>登录名：</td>
									<td style="width: 35%;">
										<div>
											<input autocomplete="off" type="text" id="loginNameA"  name="login_name"
												class="form-control height-control" required maxlength="15">
										</div>
									</td>
								</tr>

								 <tr>
				                    <td class="th">密码：</td>
				                    <td>
				                        <div>
							             	<input autocomplete="off" type="text" id="passwordA"  name="password" placeholder="若不修改密码，请留空。"
												class="form-control height-control"  maxlength="20">
							            </div>
				                    </td>
				                    <td class="th">确认密码：</td>
				                    <td>
				                        <div>
							                <input autocomplete="off" type="text" id="twoPassword"  name="twoPassword"
												class="form-control height-control" equalTo="#passwordA" maxlength="20">
							            </div>
				                    </td>
				                </tr>

								<tr>
									<td class="th"><font color="red">*&nbsp;</font>用户角色：</td>
									<td>
										<select class="form-control custom-select height-control" id="roleListA" name="roleId"  required>
										
										</select>
									</td>

									<td class="th">归属公司：</td>
									<td>
										<div>
										<input autocomplete="off" type="text" id="companyNameA"  name="companyName"
												class="form-control height-control" maxlength="30" readOnly>
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">手机：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="mobileA"  name="mobile"
												class="form-control height-control" maxlength="20">
										</div>
									</td>
									<td class="th">电话：</td>
									<td>
										<div>
										<input autocomplete="off" type="text" id="phoneA"  name="phone"
												class="form-control height-control" maxlength="20">
										</div>
									</td>
								</tr>

								<tr>
									<td class="th">邮箱：</td>
									<td>
										<div>
											<input autocomplete="off" type="text" id="emailA"  name="email"
												class="form-control height-control" maxlength="30">
										</div>
									</td>
									<td class="th">备注：</td>
									<td>
										<div>
											<textarea class="form-control" rows="3" maxlength="50" id="remarksA" name="remarks" style="word-break:break-all;"></textarea>
										</div>
									</td>
								</tr>

							</table>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="editUser()">保存</button>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		 $(document).ready(function(){
			$('#menuIdA').val($('#btnId',parent.document).val()); 
			$('#menuIdB').val($('#btnId',parent.document).val()); 
			
			addRoleSelect();
			 
			 jQuery.validator.addMethod("alnum", function(value, element) {
				 return this.optional(element) || /^[a-zA-Z0-9]+$/.test(element.value);
				 }, "只能包括英文字母和数字");
			 
			// 手机号码验证       
			 jQuery.validator.addMethod("isMobile", function(value, element) {       
			 var length = value.length;   
			 var mobile = /^(((13[0-9]{1})|(15[0-9]{1}))+\d{8})$/;   
			 return this.optional(element) || (length == 11 && mobile.test(element.value));       
			 }, "请输入正确的手机号码");       

			 // 电话号码验证       
			 jQuery.validator.addMethod("isTel", function(value, element) {       
			 var tel = /^0\d{2,3}-\d{7,8}$/;    //电话号码格式010-12345678   
			 return this.optional(element) || (tel.test(element.value));       
			 }, "请输入正确的电话号码");   
			 
			  jQuery.validator.addMethod("isRightLoginNameForm", function(value, element) {
		            var rightLoginNameForm = /^[a-zA-Z][a-zA-Z0-9]{4,14}$/;
		            return (rightLoginNameForm.test(value));
		        }, "账号只能由字母数字组成，且只能以字母开头"); 
			 
				$("#inputFormA").validate({
					 rules: {
						 name:{
							 minlength:2
						 },
						 login_name:{
							 remote:{
								    type:"POST",
								    url:"${ctx}/agentsystem/user/checkName",           
									data:{
										name:function(){return $("#loginName").val();},
										operation:"添加"
								      }
									},
							minlength:5,
							isRightLoginNameForm:true
					      },
					      password:{
					    	minlength:6,
					    	alnum:true
					      },
					      mobile:{
					    	 isMobile:true  
					      },
					      phone:{
					    	 isTel:true  
					      },
					      email:{
					    	  email : true
					      } 
					    },
						messages: {
							name:{	
								 required: "姓名不能为空",
								 minlength:"姓名不能少于2个字符"
						   		},
						   	login_name:{
						   		required: "登陆名不能为空",
						   		remote:"登录名已存在",
						   		minlength:"登录名不能少于5个字符"
						   		},
						   	password:{
						   		required:"密码不能为空",
						   		alnum:"密码必须由数字和字母构成"
						   	},
						   	roleId:{
						   		required:"用户角色还未选择"
						   	},
						    email:{
						    	  email : "请输入正确的邮箱格式"
						     } 
						 }
				});
		  });
	
		 $("#inputFormC").validate({
			 rules: {
				 name:{
					 minlength:2
				 },
				 login_name:{
					 remote:{
						    type:"POST",
						    url:"${ctx}/agentsystem/user/checkName",           
							data:{
								name:function(){return $("#loginNameA").val();},
								operation:"编辑",
								oldName:function(){return $("#oldName").val();}
						      }
							},
					minlength:5,
					isRightLoginNameForm:true
			      },
			      password:{
			    	minlength:6,
			    	alnum:true
			      },
			      mobile:{
				    	 isMobile:true  
				      },
				  phone:{
				    	 isTel:true  
				      },
				  email:{
				    	  email : true
				      } 
			    },
				messages: {
					name:{	
						 required: "姓名不能为空",
						 minlength:"姓名不能少于2个字符"
				   		},
				   	login_name:{
				   		required: "英文名称不能为空",
				   		remote:"登录名已存在",
				   		minlength:"登录名不能少于5个字符"
				   		},
				   	password:{
				   		alnum:"密码必须由数字和字母构成"
				   	},
				   	roleId:{
				   		required:"用户角色还未选择"
				   	},
					twoPassword:{
				   		equalTo:"两次密码输入不一致"
				   	},
				    email:{
				    	  email : "请输入正确的邮箱格式"
				     } 
				 }
		});
		 
		//分页方法
		function page(n,s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			$("span.page-size").text(s);
		}
		//查询方法
		function search(){//查询，页码清零
			$("#pageNo").val(0);
			$("#login_nameB").val($("#login_nameA").val());
			$("#searchForm").submit();
		}
		
		function addRoleSelect(){
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "${ctx}/agentsystem/user/getAllRole",
				success : function(result) {
					$('#roleList').append('<option value="" selected="selected">'+'--请选择--'+'</option>');
					$('#roleListA').append('<option value="" selected="selected">'+'--请选择--'+'</option>');
					for(var i=0;i<result.length;i++){
						$('#roleList').append(new Option(result[i].name,result[i].id));
						$('#roleListA').append(new Option(result[i].name,result[i].id));
					}		
				}
			});
		}
		
		//弹框显示
		function showA(obj) {
			$("#inputFormA").data("validator").resetForm();
			$("#inputFormA")[0].reset();
			$("#roleList").removeClass("error");
			$("#modalA").modal("show");
			$(obj).blur();
		}
		
		function saveUser(){
			var locked = false;
			var isValid = $("#inputFormA").valid();
			if (isValid) {
				layer.confirm('是否确认保存？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modalA").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agentsystem/user/saveUser",
										data : $('#inputFormA').serialize(),
										success : function(result) {
											layer.close(index);
											if (parseInt(result) == 1) {
												layer.msg("保存成功", {
													time:1000,
													icon:1,
												},function(data){
													$("#searchForm").submit();	
												}
												);
											}else if(parseInt(result) == 0){
												layer.msg("保存失败", {
													time:1000,
													icon:2,
												},function(data){
													$("#searchForm").submit();	
												});
											}
										},
									error:function(){
										layer.msg("保存失败", {
											time:1000,
											icon:2,
										},function(data){
											$("#searchForm").submit();	
										});
									}
									});
						 }
					 });
			}
		}
		
		//弹框显示
		function showB(id,obj) {
			$("#modalB").modal("show");
			$(obj).blur();
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "${ctx}/agentsystem/user/getUserById",
				data :  {'id': id},
				success : function(result) {
						layer.close(index);
						$('#checkName').text(result.name);
						$('#checkLoginName').text(result.login_name);
						if(result.roleList[0]!=null){
							$('#checkRoleList').text(result.roleList[0].name);
						}
						$('#checkCompany').text(result.companyName);
						$('#checkMobile').text(result.mobile);
						$('#checkPhone').text(result.phone);
						$('#checkMail').text(result.email);
						$('#checkRemarks').text(result.remarks);
					}
				});
		}
		
		//弹框显示
		function showC(id,obj) {
			$("#inputFormC").data("validator").resetForm();
			$("#inputFormC")[0].reset();
			$("#roleListA").removeClass("error");
			$("#modalC").modal("show");
			$(obj).blur();
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "${ctx}/agentsystem/user/getUserById",
				data :  {'id': id},
				success : function(result) {
						layer.close(index);
						$('#userIdA').val(result.id);
						$('#userNameA').val(result.name);
						$('#loginNameA').val(result.login_name);
						$('#oldName').val(result.login_name);
						if(result.roleList[0]!=null){
							$('#roleListA').val(result.roleList[0].id);
						}
						$('#companyNameA').val(result.companyName);
						$('#mobileA').val(result.mobile);
						$('#phoneA').val(result.phone);
						$('#emailA').val(result.email);
						$('#remarksA').val(result.remarks);
						$('#oldPassword').val(result.password);
					}
				});
		}
		
		function editUser(){
			var locked = false;
			var isValid = $("#inputFormC").valid();
			if (isValid) {
				layer.confirm('是否确认保存？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modalC").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agentsystem/user/saveUser",
										data : $('#inputFormC').serialize(),
										success : function(result) {
											layer.close(index);
											if (parseInt(result) == 1) {
												layer.msg("保存成功", {
													time:1000,
													icon:1,
												},function(data){
													$("#searchForm").submit();	
												}
												);
											}else if(parseInt(result) == 0){
												layer.msg("保存失败", {
													time:1000,
													icon:2,
												},function(data){
													$("#searchForm").submit();	
												});
											}
										},
									error:function(){
										layer.msg("保存失败", {
											time:1000,
											icon:2,
										},function(data){
											$("#searchForm").submit();	
										});
									}
									});
						 }
					 });
			}
		}
		
		function deleteUser(id){
			var menuIdA=$('#menuIdA').val();
			layer.alert('确认要彻底删除数据吗?', {
				skin : 'layui-layer-molv',
				closeBtn: 0,
				icon : 3,
				btn : [ '确认', '取消' ]
			//按钮
			}, function() {
				if($("#tbody>tr").length==1){
					$("#pageNo").val($("#pageNo").val()-1);
				}
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					type : "POST",
					dataType : "json",
					url : "${ctx}/agentsystem/user/delete",
					data :  {'id': id,'menuIdA':menuIdA},
					success : function(result) {
						layer.close(index);
						if (parseInt(result) == 1) {
							layer.msg("删除成功", {
								time:1000,
								icon:1,
							},function(data){
								$("#searchForm").submit();	
							}
							);
						}else if(parseInt(result) == 0){
							layer.msg("删除失败", {
								time:1000,
								icon:2,
							},function(data){
								$("#searchForm").submit();	
							});
						}
					},
				error:function(){
					layer.msg("删除失败", {
						time:1000,
						icon:2,
					},function(data){
						$("#searchForm").submit();	
					});
				}
				});
			});
		}
		
		$('#login_nameA').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
	</script>

</body>
</html>