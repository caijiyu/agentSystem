<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 代理商记录页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style type="text/css">
	/* #contentTable td{
	white-space:pre-wrap;
	} */
</style>

</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/SysUser/recordList" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px;height:35px;">搜索</button>

							<input id="companyNameId" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入代理商公司名称关键字"  value="${fn:escapeXml(companyName)}" style="float: right;"> 
							<input id="nameId" name="companyName" type="hidden" value="${fn:escapeXml(companyName)}" /> 
							<input id="StartTime" name="startDate" type="hidden" value="<fmt:formatDate value="${sysUser.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" /> 
							<input id="endTime" name="endDate" type="hidden" value="<fmt:formatDate value="${sysUser.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" /> 
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top:8px;">添加时间范围：&nbsp;&nbsp;</div>
									<input id="startDate" autocomplete="off" value="<fmt:formatDate value="${sysUser.startDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
									<input id="endDate" autocomplete="off" value="<fmt:formatDate value="${sysUser.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control" placeholder="结束时间" style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th class="tableControl">公司名称</th>
								<th class="tableControl">添加时间</th>
								<th class="tableControl">状态</th>
								<th class="tableControl">公众号消耗/元</th>
								<th class="tableControl">硬件消耗/元</th>
								<th class="tableControl">小程序消耗/元</th>
								<th class="tableControl">VIP消耗/元</th>
								<th class="tableControl">平台押金/元</th>
								<th class="tableControl">代理等级</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="log">
								<tr>
									<c:if test="${log.state ne 3&&log.state ne 2}">
										<td style="white-space:pre-wrap;" class="tableControl companyName">${fn:escapeXml(log.companyName)}</td>
									<td class="tableControl"><fmt:formatDate value="${log.create_date}" type="both" /></td>
									<c:if test="${log.state eq 0}">
										<td class="tableControl">冻结</td>
									</c:if>
									<c:if test="${log.state eq 1}">
										<td class="tableControl">正常</td>
									</c:if>
									<c:if test="${log.state eq 2}">
										<td class="tableControl">申请中</td>
									</c:if>
									<c:if test="${log.state eq 3}">
										<td class="tableControl">驳回</td>
									</c:if>
									<td class="tableControl">${log.publicExpend}</td>
									<td class="tableControl">${log.hardwareExpend}</td>
									<td class="tableControl">${log.minaExpend}</td>
									<td class="tableControl">${log.vipExpend}</td>
									<td class="tableControl">${log.cashPledge}</td>
									<td class="tableControl">${log.agentLevel}</td>
									<td class="tableControl">
										<shiro:hasPermission name="agentSystem:wasAgentRecord:look">
											<button type="button" data-toggle="tooltip" data-original-title="查看" onclick="examineJump('${log.id}','${fn:escapeXml(log.companyName)}')" class="btn btn-info btn-circle btn-xs">
												<i class="fa fa-search-plus"></i>
											</button>
										</shiro:hasPermission> 
									</td>
									</c:if>
									
									
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页代码 -->
					<c:if test="${page.count gt 10}">
						<table:page page="${page}"></table:page>
					</c:if>
				</div>
			</div>
		</div>
	</div>
<form type="hidden" id="jump" method="post" action="${ctx}/agentSystem/RecordExamine/list">
	<input id="receivedUserId" name="receivedUserId" type="hidden" value="" />
	<input id="companyName" name="companyName" type="hidden" value="" />
	<input id="userId" name="userId" type="hidden" value="${sysUser.id}" />
</form>
	

	<script type="text/javascript">
		
	$('#companyNameId').bind('keypress', function(event) {
		if (event.keyCode == "13") {
			search();
		}
	});
		//弹框显示
		function show() {
			$("#modal").modal("show");
		}
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
			$("#nameId").val($("#companyNameId").val());
			$("#StartTime").val($("#startDate").val());
			$("#endTime").val($("#endDate").val()+" 23:59:59");
			$("#searchForm").submit();
			
		}
		//查看跳转
		function examineJump(id,companyName){
			$("#receivedUserId").val(id);
			$("#companyName").val(companyName);
			$("#jump").submit();
			
		}
		
		
	</script>

</body>
</html>