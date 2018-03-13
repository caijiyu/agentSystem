
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--代理商申请列表-->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style>
	#price-error{
	    margin-left: 139px;
	} 
</style>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
		
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
						<shiro:hasPermission name="agency:wasAgentApply:add">
							<button type="button" class="btn btn-info" onclick="show()">
								<i class="fa fa-plus-circle"></i> 申请
							</button>
						</shiro:hasPermission>  
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agency/wasAgentApply/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
							<input id="companyNameA" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入代理商公司名称关键字" value="${fn:escapeXml(sysUser.companyName)}" style="float: right;"> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
								<input id="beginCreatedateB" name="startDateA" type="hidden"  value="<fmt:formatDate value="${sysUser.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endCreatedateB" name="endDateA" type="hidden"  value="<fmt:formatDate value="${sysUser.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>"/>
								<input id="companyNameB" name="companyName" type="hidden"  value="${fn:escapeXml(sysUser.companyName)}"/>
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">申请时间范围:&nbsp;&nbsp;</div>
									<input autocomplete="off" id="beginCreatedateA"  type="text" value="<fmt:formatDate value="${sysUser.startDate}" pattern="yyyy-MM-dd"/>" class="form-control height-control rightAngle" placeholder="开始时间"  style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control leftAngle rightAngle">至</span>
									<input autocomplete="off" id="endCreatedateA"  type="text" value="<fmt:formatDate value="${sysUser.endDate}" pattern="yyyy-MM-dd"/>" class="form-control height-control leftAngle" placeholder="结束时间"   style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">公司名称</th>
								<th class="tableControl">开始时间</th>
								<th class="tableControl">到期时间</th>
								<th class="tableControl">代理商等级</th>
								<th class="tableControl">所属上级</th>
								<th class="tableControl">上级代理等级</th>
								<th class="tableControl">申请时间</th>
								<th class="tableControl">申请状态</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="tbody">
							<c:forEach items="${page.list}" var="log">
								<tr>
									<td style="white-space:pre-wrap;" class="tableControl">${fn:escapeXml(log.companyName)}</td>
									<td class="tableControl"><fmt:formatDate value="${log.startDate}" type="both" /></td>
									<td class="tableControl"><fmt:formatDate value="${log.endDate}" type="both" /></td>
									<td class="tableControl">${fn:escapeXml(log.agentLevel)}</td>
									<td class="tableControl">${fn:escapeXml(log.companyParent.companyName)}</td>
									<td class="tableControl">${fn:escapeXml(( log.companyParent.agentLevel==null|| log.companyParent.agentLevel=="")?"--": log.companyParent.agentLevel) }</td>
									<td class="tableControl"><fmt:formatDate value="${log.create_date}" type="both" /></td>
									<td class="tableControl">${log.state==2?'申请中':'驳回'}</td>
									<td class="tableControl">
										<shiro:hasPermission name="agency:wasAgentApply:view">
											<button type="button" data-toggle="tooltip" data-original-title="查看" class="btn btn-info btn-circle btn-xs" onclick="check('${log.id}')">
												<i class="fa fa-search-plus"></i>
											</button>
										</shiro:hasPermission>  
										<shiro:hasPermission name="agency:wasAgentApply:pass">
											<button type="button" data-toggle="tooltip" data-original-title="通过" class="btn btn-info btn-circle btn-xs" ${log.state==2?'':'disabled'} onclick="showD('${log.id}',this)">
												<i style="font-size:13px" class="iconfont icon-queren-"></i>
											</button>
										</shiro:hasPermission>  
										<shiro:hasPermission name="agency:wasAgentApply:refuse">
											<button type="button" data-toggle="tooltip" data-original-title="驳回" class="btn btn-info btn-circle btn-xs" ${log.state==2?'':'disabled'} onclick="showC('${log.id}',this)">
												<i style="margin-left: -1.5px;" class="iconfont icon-zl_bohui"></i>
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
	<form id="submitForm" action="#" method="post">
		<input id="userId" name="id" type="hidden" value="" /> 
	</form>
	<!-- 模态框 -->
	<div class="modal fade" id="modalA" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 40%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">驳回</span>	
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="modalFormA">
						<input id="userIdA" name="id" type="hidden" value="" /> 
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><font color="red">*&nbsp;</font>驳回原因：</label>
							<div class="col-8 controls">
								<textarea id="remarks" name="remarks" required class="form-control" rows="3" maxlength="100" style="word-break:break-all;"></textarea>
							</div>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="overRule()">保存</button>
				</div>
			</div>
		</div>
	</div>

	<!-- 模态框 -->
	<div class="modal fade" id="modalB" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content" style="margin-top: 35%;">
				<!--对话框头-->
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">平台押金充值</span>	
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="modalFormB">
						<input id="userIdB" name="id" type="hidden" value="" /> 
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">企业名称：</label>
							<div class="col-8 controls">
								<input autocomplete="off" type="text" id="companyName"
									class="form-control height-control" value="" readOnly required>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label height-control"><font color="red">*&nbsp;</font>充值金额：</label>
							<div class="col-8 controls input-group">
								<input style="border-radius:0.25rem 0 0 0.25rem ;"  id="price" autocomplete="off" type="text" name="cashPledge"
								maxlength="9"	class="form-control height-control" required>
								<span class="input-group-addon height-control" style="border-radius:0 0.25rem 0.25rem 0;border-left:0px;">元</span>
							</div>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="pass()">保存</button>
				</div>
		</div>
	  </div>
	</div>
	
	<script type="text/javascript">
		$.validator.addMethod("minNumber",function(value, element) {
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
		},"最多支持两位小数");
		
		$("#modalFormB").validate({
			 rules: {
				 cashPledge:{
						number : true,
						min :1,
						max : 999999.99,
						minNumber : true
			      }
			    },
			    messages: {
			    	cashPledge:{
						required : "请填写充值金额",
						number :"有效数字范围1~999999.99",
						min : "有效数字范围1~999999.99",
						max : "有效数字范围1~999999.99"
				   	}
				 },
			errorPlacement : function(error, element) {
						error.insertAfter(element.parent());
					}
		});
		
		$("#modalFormA").validate({
				 rules: {
				 
			    },
			    messages: {
			    	remarks:{
			    		required : "请填写驳回原因"	
			    	}
				 }
		});
		
		//日期范围选择
		jQuery('#date-range').datepicker({
			toggleActive : true,
			autoclose: true,
			format : "yyyy-mm-dd"
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
			if($("#beginCreatedateA").val()!=""){
				$("#beginCreatedateB").val($("#beginCreatedateA").val()+" 00:00:00");
			}else{
				$("#beginCreatedateB").val("");
			}
			if($("#endCreatedateA").val()!=""){
				$("#endCreatedateB").val($("#endCreatedateA").val()+" 23:59:59");
			}else{
				$("#endCreatedateB").val("");
			}
			$("#companyNameB").val($("#companyNameA").val());
			$("#searchForm").submit();
		}
		
		function check(id){
			$('#userId').val(id);
			$('#submitForm').attr("action","${ctx}/agency/wasAgentApply/checkDetail");
			$('#submitForm').submit();
		}
		
		function showD(id,obj){
			$("#modalFormB").data("validator").resetForm();
			$("#modalFormB")[0].reset(); 
			$("#modalB").modal("show");
			$(obj).blur();
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
				type : "POST",
				dataType : "json",
				url : "${ctx}/agency/wasAgentApply/get",
				data : {'id': id}, 
				success : function(result) {
						layer.close(index);
						$("#companyName").val(result.companyName);	
						$("#userIdB").val(id);	
				}
			});	
		}
		
		function pass(){
			var locked = false;
			var isValid = $("#modalFormB").valid();
			if (isValid) {
				layer.confirm('是否正式成为代理商？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modalB").modal("hide");
							if($("#tbody>tr").length==1){
								$("#pageNo").val($("#pageNo").val()-1);
							}
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agency/wasAgentApply/pass",
										data : $('#modalFormB').serialize(),
										success : function(result) {
											layer.close(index);
											if (parseInt(result) == 1) {
												layer.msg("充值成功", {
													time:1000,
													icon:1,
												},function(data){
													$("#searchForm").submit();	
												}
												);
											}else if(parseInt(result) == 0){
												layer.msg("充值失败", {
													time:1000,
													icon:2,
												},function(data){
													$("#searchForm").submit();	
												});
											}
										},
										error:function(){
											layer.msg("充值失败", {
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
		
		function showC(id,obj){
			$("#modalFormA").data("validator").resetForm();
			$("#modalFormA")[0].reset(); 
			$("#modalA").modal("show");
			$(obj).blur();
			$("#userIdA").val(id);	
		}
		
		function overRule(){
			var locked = false;
			var isValid = $("#modalFormA").valid();
			if (isValid) {
				layer.confirm('是否确认保存？', { icon : 3 ,closeBtn: 0,
					 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						 if(!locked){
							locked=true;
							$("#modalB").modal("hide");
							var index = layer.load(1, {shade: [0.1,'#fff']});
								$.ajax({
										type : "POST",
										dataType : "json",
										url : "${ctx}/agency/wasAgentApply/overRule",
										data : $('#modalFormA').serialize(),
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
										}
									});
						 }
					 });
			}
		}
		
		function show(){
			$('#submitForm').attr("action","${ctx}/agency/wasAgentApply/addAgentApply");
			$('#submitForm').submit();
		}
		
		$('#companyNameA').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
	</script>

</body>
</html>