
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--文件分类列表-->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style>
	.error{
	color:red;
	} 
</style>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			
			<div class="tab-content">
				<div class="tab-pane p-20 active"  role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
						<shiro:hasPermission name="sysdata:wasFileClassify:add">
							<button type="button" class="btn btn-info" onclick="show(this)">
								<i class="fa fa-plus-circle"></i> 添加
							</button>
						</shiro:hasPermission>  
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/sysdata/wasFileClassify/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>

							<input id="fileNameA" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入分类名称关键字" name="name" value="${fn:escapeXml(log.name)}" style="float: right;">
								 <input id="fileNameB"  type="hidden" value="${fn:escapeXml(log.name)}" /> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">分类名称</th>
								<th class="tableControl">添加时间</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${page.list}" var="log">
								<tr>
									<td class="tableControl">${fn:escapeXml(log.name)}</td>
									<td class="tableControl"><fmt:formatDate value="${log.createDate}" type="both" /></td>
									<td class="tableControl">
										<shiro:hasPermission name="sysdata:wasFileClassify:del">	
											<button type="button" data-toggle="tooltip" data-original-title="删除" class="btn btn-danger btn-circle btn-xs" onclick="deleteFileClassify(${log.classifyId})">
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
			<div class="modal-content" style="margin-top: 45%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">添加分类</span>		
					<button type="button" class="close" data-dismiss="modal" 
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="inputFormD">
						<input name="classifyId" type="hidden" value="" />
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><font color="red">*&nbsp;</font>分类名称：</label>
							<div class="col-8 controls">
								<input id="fileClassifyName" autocomplete="off" type="text" name="name"  maxlength="10"
									class="form-control height-control" required>
								<input type="text" style="display:none">
							</div>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveFileClassify()">保存</button>
				</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
	$(document).ready(function(){
		$("#inputFormD").validate({
			 rules: {
				 name:{
			      	remote:{
				    type:"POST",
				    url:"${ctx}/sysdata/wasFileClassify/validateName",           
					data:{
						fileClassifyName:function(){return $("#fileClassifyName").val();}
				      }
					}
			      }
			    },
				messages: {
					name:{	
				   		  required: "分类不能为空",
				   		  remote:"文件分类名不能重复"
				   		}
				   }
			  });
	});
	
		//弹框显示
		function show(obj) {
			$("#inputFormD").data("validator").resetForm();
			$("#inputFormD")[0].reset();
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
			$("#fileNameB").val($("#fileNameA").val());
			$("#searchForm").submit();
		}
		
		function saveFileClassify(){
			var locked = false;
			var isValid = $("#inputFormD").valid();
			if (isValid) {
				layer.confirm('是否确认保存？', {closeBtn: 0, icon : 3 ,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modal").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/sysdata/wasFileClassify/save",
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
												layer.msg("删除失败", {
													time:1000,
													icon:2,
												},function(data){
													$("#searchForm").submit();	
												});
											}
										}
									});
						 }
					 });
			}
		}
		
		function deleteFileClassify(id) {
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
					url : "${ctx}/sysdata/wasFileClassify/delete",
					type : "post",
					data: {'classifyId': id},
					dataType : "json",
					success : function(result) {
						layer.close(index);
						if (parseInt(result) == 1) {
							layer.msg("删除成功", {
								time:1000,
								icon:1,
							},function(data){
								$("#searchForm").submit();	
							});
						}else if(parseInt(result) == 0){
							layer.msg("该类型正在使用，无法删除", {
								time:1000,
								icon:2,
							},function(data){
								$("#searchForm").submit();	
							});
						}else if(parseInt(result) == 2){
							layer.msg("删除失败", {
								time:1000,
								icon:2,
							},function(data){
								$("#searchForm").submit();	
							});
						}
						
					}
				});
			});
		}
		
		$('#fileNameA').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
	</script>

</body>
</html>