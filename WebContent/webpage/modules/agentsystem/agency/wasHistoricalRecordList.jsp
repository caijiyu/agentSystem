
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!--历史记录的消费记录页面-->
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
						<form action="${ctx}/agency/wasHistoricalRecord/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>

							<input id="orderNoA" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入订单编号关键字" value="${fn:escapeXml(log.orderNo)}" style="float: right;"> 
								<input id="orderNoB" name="orderNo" type="hidden" value="${fn:escapeXml(log.orderNo)}" /> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
								<input id="startDateB" name="startDateB" type="hidden" value="<fmt:formatDate value="${log.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endDateB" name="endDateB" type="hidden" value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">消费日期范围:&nbsp;&nbsp;</div>
									<input autocomplete="off" id="startDateA" value="<fmt:formatDate value="${log.startDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间"  style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl leftAngle rightAngle">至</span>
									<input autocomplete="off" id="endDateA" value="<fmt:formatDate value="${log.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间"  style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">订单编号</th>
								<th class="tableControl">消费行为</th>
								<th class="tableControl">消费金额</th>
								<th class="tableControl">消费时间</th>
								<th class="tableControl">消费账户</th>
								<th class="tableControl">备注</th>
								<th class="tableControl">操作人</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="log">
								<tr>
									<td class="tableControl">${log.orderNo}</td>
									<td class="tableControl">${fn:escapeXml(log.behavior)}</td>
									<td class="tableControl">${log.payMoney}</td>
									<td class="tableControl"><fmt:formatDate value="${log.createDate}" type="both" /></td>
									<td class="tableControl expend">
										${log.publicExpend eq "0.00"?"":"公众号"}${(log.publicExpend ne "0.00"&&(log.minaExpend ne "0.00"||log.hardwareExpend ne "0.00"||log.vipExpend ne "0.00"))?"、":""}
										${log.minaExpend eq "0.00"?"":"小程序"}${(log.minaExpend ne "0.00"&&(log.hardwareExpend ne "0.00"||log.vipExpend ne "0.00"))?"、":""}
										${log.hardwareExpend eq "0.00"?"":"硬件"}${(log.hardwareExpend ne "0.00"&&log.vipExpend ne "0.00")?"、":""}
										${log.vipExpend eq "0.00"?"":"vip"}
									</td>
									<td class="tableControl" style="white-space: nowrap;word-break: break-all;max-width: 150px;text-overflow: ellipsis;overflow: hidden;">${fn:escapeXml((log.remarks==null||log.remarks=="")?"--":log.remarks)}</td>
									<td class="tableControl">${fn:escapeXml(log.loginName)}</td>
									<td class="tableControl">
										<shiro:hasPermission name="agency:wasSelfConsume:view">
											<button type="button" data-toggle="tooltip" data-original-title="查看" class="btn btn-info btn-circle btn-xs" onclick="consumeExamine('${log.orderNo}','${log.type}',this)">
												<i class="fa fa-search-plus"></i>
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
	
	<!-- 方针购买模态框 -->
	<div class="modal fade" id="modalPolicyPurchase" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header" style="background-color: #f4f5f9;">
					<h5 class="modal-title">查看</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">订单编号：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">套餐名：</label>
							<label for="example-text-input"
								class="col-8 col-form-label looks" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">数量：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">开始时间：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">结束时间：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">消费行为：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">消费时间：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">消费总额：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">公众号消费：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">硬件消费：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">小程序消费：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">VIP消费：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">操作人：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-4 col-form-label">备注：</label>
							<label for="example-text-input" class="col-8 col-form-label"
								style="text-align: left;white-space:pre-wrap;word-break:break-all;"></label>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<!-- 硬件购买模态框 -->
	<div class="modal fade" id="modalHardwarePurchase"
		data-backdrop="static">
		<div class="modal-dialog" style="max-width: 700px;">
			<!--宽高、定位-->
			<div class="modal-content" style="width: 700px;">
				<!--对话框头-->
				<div class="modal-header" style="background-color: #f4f5f9;">
					<h5 class="modal-title">查看</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form>
						<div class="row">
							<div class="col-md-6">
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">订单编号：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>

								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">商品名称：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">消费总额：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">硬件消费：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">VIP消费：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">收货方式：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">下单时间：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">状态：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
							</div>
							<!--/span-->
							<div class="col-md-6">
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">公司名称：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">购买数量：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">消费行为：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">公众号消费：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">小程序消费：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">收货人：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">操作人：</label>
									<label class="control-label col-7" style="white-space: pre-wrap;text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">备注：</label>
									<label class="control-label col-7" style="text-align: left;white-space:pre-wrap;word-break:break-all;"></label>
								</div>

							</div>
							<!--/span-->
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

	<!-- 充消模态框 -->
	<div class="modal fade" id="modalExpendPay" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header" style="background-color: #f4f5f9;">
					<h5 class="modal-title">查看</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">订单编号：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">消费行为：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">消费时间：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">消费金额：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">公众号消费：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">硬件消费：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">小程序消费：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">VIP消费：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">被充值代理商：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">操作人：</label> <label
								class="col-9 col-form-label" style="text-align: left;"></label>
						</div>

						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"
								style="text-align: right;">备注：</label> <label
								class="col-9 col-form-label" style="text-align: left;white-space:pre-wrap;word-break:break-all;"></label>
						</div>
					</form>
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
			if($("#startDateA").val()!=""){
				$("#startDateB").val($("#startDateA").val()+" 00:00:00");
			}else{
				$("#startDateB").val("");
			}
			if($("#endDateA").val()!=""){
				$("#endDateB").val($("#endDateA").val()+" 23:59:59");
			}else{
				$("#endDateB").val("");
			}
			$("#orderNoB").val($("#orderNoA").val());
			$("#searchForm").submit();
		}
		
		//消费记录查看
		function consumeExamine(orderNo, type,obj) {
			var index = layer.load(1, {
				shade : [ 0.1, '#fff' ]
			});
			if (type == 1) {//软件消费
				$.ajax({
					url : "${ctx}/agentSystem/PolicyPurchase/get",
					type : "post",
					dataType : "JSON",
					data : {"number" : orderNo},
						success : function(data) {
							layer.close(index);
								$("#modalPolicyPurchase label:eq(1)").text(
										data.number);
								$("#modalPolicyPurchase label:eq(3)").text(
										data.comboName);
								$("#modalPolicyPurchase label:eq(5)").text(
										data.policyNumber);
								$("#modalPolicyPurchase label:eq(7)").text(data.createDate);
								$("#modalPolicyPurchase label:eq(9)").text(data.endDate);
								$("#modalPolicyPurchase label:eq(11)").text(
										data.behavior);
								$("#modalPolicyPurchase label:eq(13)").text(data.createDate);
								$("#modalPolicyPurchase label:eq(15)").text(
										data.payMoney.toFixed(2) + " 元");
								$("#modalPolicyPurchase label:eq(17)").text(
										data.publicExpend.toFixed(2) + " 元");
								$("#modalPolicyPurchase label:eq(19)").text(
										data.hardwareExpend.toFixed(2) + " 元");
								$("#modalPolicyPurchase label:eq(21)").text(
										data.minaExpend.toFixed(2) + " 元");
								$("#modalPolicyPurchase label:eq(23)").text(
										data.vipExpend.toFixed(2) + " 元");
								$("#modalPolicyPurchase label:eq(25)").text(
										data.loginName);
								if(data.remarks==null||data.remarks==""){
									$("#modalPolicyPurchase label:eq(27)").text("--");
								}else{
									$("#modalPolicyPurchase label:eq(27)").text(data.remarks);
								}
							},
							error : function(e) {
								layer.msg('系统数据出错！', {
									icon : 2
								});
								layer.close(index);
							}
						});
				$("#modalPolicyPurchase").modal("show");
			} else if (type == 2) {//硬件消费
				$.ajax({
					url : "${ctx}/hardware/hardwarePurchase/get",
					type : "post",
					dataType : "JSON",
					data : {
						"orderNo" : orderNo
					},
					success : function(data) {
						layer.close(index);
						$("#modalHardwarePurchase label:eq(1)").text(
								data.orderNo);
						$("#modalHardwarePurchase label:eq(3)").text(
								data.hardwareName);
						$("#modalHardwarePurchase label:eq(5)").text(
								data.payMoney.toFixed(2) + " 元");
						$("#modalHardwarePurchase label:eq(7)").text(
								data.hardwareExpend.toFixed(2) + " 元");
						$("#modalHardwarePurchase label:eq(9)").text(
								data.vipExpend.toFixed(2) + " 元");
						if(data.deliveryMethod==true){
							$("#modalHardwarePurchase label:eq(11)").text("快递");
						}else{
							$("#modalHardwarePurchase label:eq(11)").text("自提");
						}
						$("#modalHardwarePurchase label:eq(13)").text(data.createDate);
						switch(data.sendState){
						case 0:
							$("#modalHardwarePurchase label:eq(15)").text("未发货");
							break;
						case 1:
							$("#modalHardwarePurchase label:eq(15)").text("发货");
							break;
						case 2:
							$("#modalHardwarePurchase label:eq(15)").text("已完成");
							break;
						}
						$("#modalHardwarePurchase label:eq(17)").text(
								data.purchasedCompanyName);
						$("#modalHardwarePurchase label:eq(19)").text(
								data.number);
						$("#modalHardwarePurchase label:eq(21)").text(
								data.behavior);
						$("#modalHardwarePurchase label:eq(23)").text(
								data.publicExpend.toFixed(2) + " 元");
						$("#modalHardwarePurchase label:eq(25)").text(
								data.minaExpend.toFixed(2) + " 元");
						$("#modalHardwarePurchase label:eq(27)")
								.text(data.name);
						$("#modalHardwarePurchase label:eq(29)").text(
								data.createLoginName);
						if(data.remarks==null||data.remarks==""){
							$("#modalHardwarePurchase label:eq(31)").text("--");
						}else{
							$("#modalHardwarePurchase label:eq(31)").text(data.remarks);
						}
					},
					error : function(e) {
						layer.msg('系统数据出错！', {
							icon : 2
						});
						layer.close(index);
					}
				});
				$("#modalHardwarePurchase").modal("show");
			} else if (type == 3) {//充消
				$.ajax({
					url : "${ctx}/agentSystem/ExpendPay/get",
					type : "post",
					dataType : "JSON",
					data : {
						"orderNo" : orderNo
					},
					success : function(data) {
						layer.close(index);
						$("#modalExpendPay label:eq(1)").text(data.orderNo);
						$("#modalExpendPay label:eq(3)").text(data.behavior);
						$("#modalExpendPay label:eq(5)").text(data.createDate);
						$("#modalExpendPay label:eq(7)").text(
								data.payMoney.toFixed(2) + " 元");
						$("#modalExpendPay label:eq(9)").text(
								data.publicExpend.toFixed(2) + " 元");
						$("#modalExpendPay label:eq(11)").text(
								data.hardwareExpend.toFixed(2) + " 元");
						$("#modalExpendPay label:eq(13)").text(
								data.minaExpend.toFixed(2) + " 元");
						$("#modalExpendPay label:eq(15)").text(
								data.vipExpend.toFixed(2) + " 元");
						$("#modalExpendPay label:eq(17)").text(
								data.receivedCompanyName);
						$("#modalExpendPay label:eq(19)").text(data.createLoginName);
						if(data.remarks==null||data.remarks==""){
							$("#modalExpendPay label:eq(21)").text("--");
						}else{
							$("#modalExpendPay label:eq(21)").text(data.remarks);
						}
					},
					error : function(e) {
						layer.msg('系统数据出错！', {
							icon : 2
						});
						layer.close(index);
					}
				});
				$("#modalExpendPay").modal("show");
			} else {
				layer.msg('系统数据出错！', {
					icon : 2
				});
				layer.close(index);
			}
			$(obj).blur();
		}


		$('#orderNoA').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
		
	</script>

</body>
</html>