 
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 终端记录 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">
					</div> 
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/terminal/wasTerminalUser/terminalUserRecord" method="post" style="width: 100%" id="searchForm"> 
							<input name="id" type="hidden" value="1" /> 
							<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
							<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
							<input id="companyNameA" name="companyName" type="hidden" value="${fn:escapeXml(wasPolicyPurchase.companyName)}" />
							<input id="beginDateA" name="beginDate" type="hidden"  value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<input id="overDateA" name="overDate" type="hidden"  value="<fmt:formatDate value="${wasTerminalUser.overDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
							<input id="companyNameB" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入公司名称"  value="${fn:escapeXml(wasPolicyPurchase.companyName)}" style="float: right;">
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">添加时间范围：&nbsp;&nbsp;</div>
									<input id="beginDateB" value="<fmt:formatDate value="${startTime}" pattern="yyyy-MM-dd "/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl leftAngle rightAngle">至</span>
									<input id="overDateB" value="<fmt:formatDate value="${wasPolicyPurchase.overDate}" pattern="yyyy-MM-dd "/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">公司名称</th>
								<th class="tableControl">用户名</th>
								<th class="tableControl">方针信息</th>
								<th class="tableControl">添加时间</th>
								<!-- <th class="tableControl">到期时间</th> -->
								<th class="tableControl">所属代理商</th>
								<th class="tableControl">费用</th>
								<th class="tableControl">年限</th>
								<th class="tableControl">说明</th>
								<shiro:hasPermission name="terminal:terminalUserRecord:delete">
									<th class="tableControl">操作</th>
								</shiro:hasPermission>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="wasPolicyPurchase">
								<tr>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasPolicyPurchase.info[0])}</td>
									<td class="tableControl">${fn:escapeXml(wasPolicyPurchase.info[1])}</td>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasPolicyPurchase.info[2])}</td>
									<td class="tableControl"><fmt:formatDate value="${wasPolicyPurchase.createDate}" pattern="yyyy-MM-dd"/></td>
									<%-- <td class="tableControl"><fmt:formatDate value="${wasPolicyPurchase.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td> --%>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasPolicyPurchase.info[3])}</td>
									<td class="tableControl">${wasPolicyPurchase.payMoney}</td>
									<td class="tableControl">${wasPolicyPurchase.info[4]}</td>
									<td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${(wasPolicyPurchase.behavior eq "方针购买")?"购买方针":"方针续费"}</td>
									<shiro:hasPermission name="terminal:terminalUserRecord:delete">
										<td class="tableControl">
											<button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="删除" class="btn btn-danger btn-circle btn-xs show" onclick="deletePolicyPurchase(${wasPolicyPurchase.policyPurchaseId})">
												<i class="fa fa-times"></i>
											</button>
										</td>
									</shiro:hasPermission>
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


	<script type="text/javascript">
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
				$("#companyNameA").val($("#companyNameB").val());
				$("#beginDateA").val($("#beginDateB").val());
				$("#overDateA").val($("#overDateB").val() +" 23:59:59");
				$("#searchForm").submit();
			}
			$('#companyNameB').bind('keypress', function(event) {
				if (event.keyCode == "13") {
					$("#pageNo").val(0);
					$("#companyNameA").val($("#companyNameB").val());
					$("#beginDateA").val($("#beginDateB").val());
					$("#overDateA").val($("#overDateB").val() +" 23:59:59");
					search();
				}
			});
			//逻辑删除
			function deletePolicyPurchase(id){
				var locked=false;
				if(!locked){
					locked=true;
		    		layer.confirm('确认删除当前记录？', {closeBtn : 0,icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
						var index = layer.load(1, {shade: [0.1,'#fff']});
		    			$.post("${ctx}/agentSystem/terminal/wasTerminalUser/deleteById",{"policyPurchaseId":id},function(data){
		    				if("success" == data){
		    					layer.close(index);
		    					locked = false;
		    					layer.msg("删除成功",{icon:1,time:1000},function(){
									if(parseInt('${page.list.size()}')==1){
										$("#pageNo").val($("#pageNo").val()-1)
									}
		    						$("form").submit()
		    					}); 
		    				}else{
		    					layer.close(index);
		    					locked = false;
		    					layer.msg("删除失败",{icon:2,time:1000},function(){
		    						return;  
		    					}); 
		    				}
		    			})
		    		})
				}
			}
	</script>

</body>
</html>