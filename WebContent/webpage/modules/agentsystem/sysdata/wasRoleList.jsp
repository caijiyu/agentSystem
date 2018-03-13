
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--角色管理列表-->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<%@include file="/webpage/include/treeview.jsp" %>
<link href="${ctxStatic}/agentSystem/css/iconfont.css" rel="stylesheet" />
<style>
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
				<div class="tab-pane p-20 active" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
						<shiro:hasPermission name="sysdata:wasRole:add">
							<button type="button" class="btn btn-info" onclick="show('0',this)">
								<i class="fa fa-plus-circle"></i> 添加
							</button>
						</shiro:hasPermission> 
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentsystem/role/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>

							<input id="roleNameA" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入角色名称关键字"  value="${fn:escapeXml(log.name)}" style="float: right;"> 
								<input id="roleNameB" name="name" type="hidden" value="${fn:escapeXml(log.name)}" /> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">角色名称</th>
								<th class="tableControl">英文名称</th>
								<th class="tableControl">角色类型</th>
								<th class="tableControl">备注</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${page.list}" var="log">
								<tr>
									<td class="tableControl">${fn:escapeXml(log.name)}</td>
									<td class="tableControl">${fn:escapeXml(log.enname)}</td>
									<td class="tableControl">${log.roleType}</td>
									<td class="tableControl" style="white-space:pre-wrap;word-break:break-all;max-width: 150px;">${fn:escapeXml((log.remarks==null||log.remarks=="")?"--":log.remarks)}</td>
									<td class="tableControl">
										<shiro:hasPermission name="sysdata:wasRole:edit">
											<button type="button" data-toggle="tooltip" data-original-title="编辑" class="btn btn-info btn-circle btn-xs" onclick="show('${log.id}',this)">
												<i class="fa fa-edit"></i>
											</button>
										</shiro:hasPermission> 
										<shiro:hasPermission name="sysdata:wasRole:power">
											<button type="button" data-toggle="tooltip" data-original-title="权限设置" class="btn btn-info btn-circle btn-xs" onclick="showTree('${log.id}',this)">
												<i style="font-size:15px;color:white;margin-left: -1px;" class="iconfont icon-ICON_xitongshezhi-zhanghaoquanxianguanli"></i>
											</button>
										</shiro:hasPermission> 
										<shiro:hasPermission name="sysdata:wasRole:del">
											<button type="button" data-toggle="tooltip" data-original-title="删除" class="btn btn-danger btn-circle btn-xs" onclick="deleteRole('${log.id}')">
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

	<!-- 模态框 -->
	<div class="modal fade" id="modal" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 25%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">添加角色</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="inputFormC">
						<input id="roleId" name="id" type="hidden" value="" /> 
						<input id="oldName" name="oldName" type="hidden" value="" /> 
						<input id="menuIdA" name="menuIdA" type="hidden" value="" /> 
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><font color="red">*&nbsp;</font>角色名称：</label>
							<div class="col-8 controls">
								<input autocomplete="off" type="text" id="roleName"  name="name"
									class="form-control height-control" required maxlength="10">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><font color="red">*&nbsp;</font>英文名称：</label>
							<div class="col-8 controls">
								<input autocomplete="off" type="text"  id="roleEnName" name="enname"
									class="form-control height-control" required maxlength="20">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><font color="red">*&nbsp;</font>角色类型：</label>
							<div class="col-8 controls">
								<select id="roleType" name="roleType" class="form-control custom-select height-control" required>
									<option value="">--请选择--</option>
									<option value="内部人员">内部人员</option>
									<option value="代理商">代理商</option>
									<option value="管理员">管理员</option>
	                            </select>
                            </div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">备注：</label>
							<div class="col-8 controls">
								<textarea class="form-control" rows="3" id="roleRemarks" name="remarks" maxlength="100" style="word-break:break-all;"></textarea>
							</div>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveRole()">保存</button>
				</div>
			</div>
		</div>
	</div>
	
		<!-- 模态框 -->
		<div class="modal fade" id="ztreeModel" data-backdrop="static">
			<div class="modal-dialog" style="width:350px">
				<!--宽高、定位-->
				<div class="modal-content">
					<!--对话框头-->
					<div class="modal-header"
						style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
						<span id="modal-header-title">权限设置</span>
						<button type="button" class="close" data-dismiss="modal"
							aria-hidden="true">×</button>
					</div>
					<!--主体部分-->
					<div class="modal-body" style="width:350px;height: 620px;overflow-y: auto;">
						<form id="inputFormD">
							<div id="menuTree" class="ztree" style="margin-top:3px;float:left;"></div>
							<input id="role_id" name="id" type="hidden" value="" /> 
							<input id="menuIds" name="menuIds" type="hidden" value="" /> 
							<input id="menuIdB" name="menuIdB" type="hidden" value="" /> 
						</form>	
					</div>
					<!--对话框尾-->
					<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
						<button type="button" class="btn btn-info" onclick="saveMenu()">保存</button>
					</div>
				</div>
			</div>
		</div>

	<script type="text/javascript">
	  $(document).ready(function(){
		 $('#menuIdA').val($('#btnId',parent.document).val());
		 $('#menuIdB').val($('#btnId',parent.document).val());
		// 只能输入英文
		 jQuery.validator.addMethod("english", function(value, element) {
		     var chrnum = /^([a-zA-Z\s]+)$/;
		     return this.optional(element) || (chrnum.test(value));
		 }, "英文名只能由字母组成");

			$("#inputFormC").validate({
				 rules: {
					 name:{
						 remote:{
							    type:"POST",
							    url:"${ctx}/agentsystem/role/checkName",           
								data:{
									name:function(){return $("#roleName").val();},
									operation:function(){return $("#modal-header-title").html();},
									oldName:function(){return $("#oldName").val();}
							      }
								}
				      },
				      enname:{
				    	  english:true 
				      }
				    },
					messages: {
						name:{	
							 required: "角色名称不能为空",
							 remote:"角色名称不能重复"
					   		},
					   	enname:{
					   		required: "英文名称不能为空"
					   		},
					   	roleType:{
					   		required:"角色类型还未选择"
					   	}
					 }
			});
	  });
		//弹框显示
		function show(id,obj) {
			$("#inputFormC").data("validator").resetForm();
			$("#inputFormC")[0].reset(); 
			$("#roleType").removeClass("error");
			$("#roleName").removeClass("error");
			$("#roleEnName").removeClass("error");
			if(id!=0){
				$("#modal-header-title").html("编辑角色");
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					type : "POST",
					dataType : "json",
					url : "${ctx}/agentsystem/role/get",
					data :  {'id': id},
					success : function(result) {
						layer.close(index);
						$("#roleId").val(result.id);
						$("#oldName").val(result.name);
						$("#roleName").val(result.name);
						$("#roleEnName").val(result.enname);
						$("#roleType").val(result.roleType);
						$("#roleRemarks").val(result.remarks);
					}
				});
			}else{
				$("#modal-header-title").html("添加角色");
				$("#roleName").val('');
				$("#roleEnName").val('');
				$("#roleType").val('');
				$("#roleRemarks").val('');
				$("#oldName").val('');
			}
			
			$("#modal").modal("show");
			$(obj).blur();
		}
		
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
			$("#roleNameB").val($("#roleNameA").val());
			$("#searchForm").submit();
		}
		
		function saveRole(){
			var locked = false;
			var isValid = $("#inputFormC").valid();
			if (isValid) {
				layer.confirm('是否确认保存？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modal").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agentsystem/role/saveRole",
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
		
		function deleteRole(id){
			var menuIdA=$('#menuIdA').val();
			var judgeDelete=false;
			$.ajax({
				type : "POST",
				dataType : "json",
				async: false ,
				url : "${ctx}/agentsystem/role/judgeDelete",
				data :  {'id': id},
				success : function(result) {
					if(result==0){
						layer.msg("当前角色仍在使用", {
							time:1000,
							icon:2,
						});
					}else{
						judgeDelete=true;
					}
				}
			});
			
			if(judgeDelete){
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
						async: false ,
						url : "${ctx}/agentsystem/role/delete",
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
		}
		
		function saveMenu(){
			var locked = false;
			var isValid = $("#inputFormD").valid();
			if (isValid) {
				//将选中结果存入隐藏域提交
				var ids = [], nodes = tree.getCheckedNodes(true);
				for(var i=0; i<nodes.length; i++) {
					ids.push(nodes[i].id);
				}
				$("#menuIds").val(ids);
				layer.confirm('是否确认保存？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modal").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agentsystem/role/saveMenu",
										data : $('#inputFormD').serialize(),
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
		
		function showTree(id,obj){
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "${ctx}/agentsystem/role/getRole",
				data :  {'id': id},
				success : function(result) {
					layer.close(index);
					$('#role_id').val(id);					
					//全部节点取消勾选
					tree.checkAllNodes(false);
					// 默认选择节点
					var ids = result.menuIds.split(",");
					for(var i=0; i<ids.length; i++) {
						var node = tree.getNodeByParam("id", ids[i]);
						try{tree.checkNode(node, true, false);}catch(e){}
					}
				}
			});
			$("#ztreeModel").modal("show");	
			$(obj).blur();
		}
		
		//ztree生成
		$(document).ready(function(){
			$("#inputFormD").validate({
			
			});

			var setting = {check:{enable:true,nocheckInherit:true},view:{selectedMulti:false,showIcon:false},
					data:{simpleData:{enable:true}},callback:{beforeClick:function(id, node){
						tree.checkNode(node, !node.checked, true, true);
						return false;
					}}};
			
			// 用户-菜单
			var zNodes=[<c:forEach items="${menuList}" var="menu">{id:"${menu.id}", pId:"${not empty menu.parent.id?menu.parent.id:0}", name:"${not empty menu.parent.id?menu.name:'权限列表'}"},
		            </c:forEach>];
			// 初始化树结构
			tree = $.fn.zTree.init($("#menuTree"), setting, zNodes);
			// 不选择父节点
			tree.setting.check.chkboxType = { "Y" : "ps", "N" : "s" };
			// 默认展开全部节点
			tree.expandAll(true);
		});
		
		$('#roleNameA').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
	</script>

</body>
</html>