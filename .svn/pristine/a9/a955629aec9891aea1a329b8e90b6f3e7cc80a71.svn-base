
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 代理商记录查看页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>

<style type="text/css">
/* table td{
	white-space:pre-wrap;
	} */
</style>
</head>
<body>
	<div class="divControl" hidden="hidden" id="hiddenDiv">
		<div class="card cardControl">
			<!-- Nav tabs -->
			<div>

				<%-- <div style="padding:15px 20px 0px 0px;float:right;">
					<p style="white-space:pre-wrap;font-size: 14px;">${companyName}</p>
				</div> --%>


				<ul class="nav nav-tabs customtab" id="pageJump" role="tablist">

					<shiro:hasPermission
						name="agentSystem:wasRecordExamine:recharge:tab">
						<li class="nav-item"><a class="nav-link active"
							id="rechargeTab" href="#"
							onclick="switchover(0)"> <span class="hidden-sm-up"><i
									class="ti-home"></i></span> <span class="hidden-xs-down">充值记录</span>
						</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission
						name="agentSystem:wasRecordExamine:consume:tab">
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							id="consumeTab" href="#"
							onclick="switchover(1)"> <span class="hidden-sm-up"><i
									class="ti-user"></i></span> <span class="hidden-xs-down">消费记录</span>
						</a></li>
					</shiro:hasPermission>
					<shiro:hasPermission
						name="agentSystem:wasRecordExamine:invoice:tab">
						<li class="nav-item"><a class="nav-link" data-toggle="tab"
							id="invoiceTab" href="#"
							onclick="switchover(2)"> <span class="hidden-sm-up"><i
									class="ti-email"></i></span> <span class="hidden-xs-down">开票记录</span>
						</a></li>
					</shiro:hasPermission>
					<li style="position: absolute; right: 20px; padding-top: 15px;">
						<p style="white-space: pre-wrap; font-size: 14px;">${companyName}</p>
					</li>
				</ul>

			</div>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- 充值记录 -->
				<shiro:hasPermission
					name="agentSystem:wasRecordExamine:recharge:tab">
					<div class="tab-pane p-20 active" id="recharge" role="tabpanel">
						<div class="row col-8" style="float: right;">
							<form action="${ctx}/agentSystem/RecordExamine/list"
								method="post" style="width: 100%" id="rechargeRearchForm">
								<button type="button"
									class="btn waves-effect waves-light btn-info"
									onclick="rechargeSearch()"
									style="float: right; margin-left: 15px;height:35px;">搜索</button>

								<input id="startTimeA" name="startDateA" type="hidden"value="<fmt:formatDate value="${rechargeHistory.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endTimeA" name="endDateA" type="hidden"value="<fmt:formatDate value="${rechargeHistory.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="rechargeId" name="receivedUserId" type="hidden" value="${receivedUserId}" /> 
								<input id="pageNoA" name="pageNoA" type="hidden" value="${pageNoA}" /> 
								<input id="pageSizeA" name="pageSizeA" type="hidden" value="${pageSizeA}" /> 
								<input name="pageNoB" type="hidden" value="${pageNoB}" /> 
								<input name="pageSizeB" type="hidden" value="${pageSizeB}" /> 
								<input name="pageNoC" type="hidden" value="${pageNoC}" /> 
								<input name="pageSizeC" type="hidden" value="${pageSizeC}" />
								<input id="companyName" name="companyName" type="hidden" value="${companyName}" />
								
								<div class="form-group col-6"
									style="margin-bottom: 0px; float: right;padding-right: 0px;padding-left: 0px;">
									<div class=" input-group input-daterange" id="date-rangeA">
										<div style="display: inline-block; padding-top: 8px;">充值时间范围：&nbsp;&nbsp;</div>
										<input value="<fmt:formatDate value="${rechargeHistory.startDate}" pattern="yyyy-MM-dd"/>"
											type="text" class="form-control height-control rightAngle"
											id="startDateIdA" placeholder="开始时间" autocomplete="off"
											style="text-align: left;" /> <span
											class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
										<input
											value="<fmt:formatDate value="${rechargeHistory.endDate}" pattern="yyyy-MM-dd"/>"
											type="text" class="form-control height-control"
											id="endDateIdA" placeholder="结束时间" autocomplete="off"
											style="text-align: left;" />
									</div>
								</div>
							</form>
						</div>
						<table
							class="display nowrap table table-hover table-striped table-bordered"
							cellspacing="0" width="100%">
							<thead>
								<tr>
									<th class="tableControl">订单编号</th>
									<th class="tableControl">充值金额/元</th>
									<th class="tableControl">充值去向</th>
									<th class="tableControl">充值时间</th>
									<th class="tableControl">操作人</th>
									<shiro:hasPermission
										name="agentSystem:wasRecordExamine:recharge:delete">
										<th class="tableControl">操作</th>
									</shiro:hasPermission>
								</tr>
							</thead>
							<tbody>

								<c:forEach items="${pageA.list}" var="recharge">

									<tr>
										<td class="tableControl">${recharge.rechargeNo}</td>

										<td class="tableControl">${recharge.amount}</td>
										<td class="tableControl">${recharge.rechargeDirection}</td>


										<td class="tableControl"><fmt:formatDate
												value="${recharge.createDate}" type="both" /></td>
										<td class="tableControl">${recharge.loginName}</td>
										<td class="tableControl"><shiro:hasPermission
												name="agentSystem:wasRecordExamine:recharge:delete">
												<button type="button" data-toggle="tooltip"
													data-original-title="删除"
													onclick="rechargeDelete('${recharge.rechargeId}','${userId}')"
													class="btn btn-danger btn-circle btn-xs ">
													<i class="fa fa-times"></i>
												</button>
											</shiro:hasPermission></td>
									</tr>

								</c:forEach>
							</tbody>
						</table>
						<!-- 分页代码 -->
							<c:if test="${pageA.count gt 10}">
								<table:page page="${pageA}"></table:page>
							</c:if>
					</div>
				</shiro:hasPermission>
				<!-- 消费记录 -->
				<shiro:hasPermission name="agentSystem:wasRecordExamine:consume:tab">
					<div class="tab-pane p-20" id="consume" role="tabpanel">
						<div class="row col-8" style="float: right;">
							<form action="${ctx}/agentSystem/RecordExamine/list"
								method="post" style="width: 100%" id="consumeSearchForm">
								<button type="button"
									class="btn waves-effect waves-light btn-info"
									onclick="searchConsume()"
									style="float: right; margin-left: 15px;height:35px;">搜索</button>
								<input id="startTimeB" name="startDateB" type="hidden"value="<fmt:formatDate value="${consumeSynthesis.startDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endTimeB" name="endDateB" type="hidden"value="<fmt:formatDate value="${consumeSynthesis.endDate }" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="consumeId" name="receivedUserId" type="hidden" value="${receivedUserId}" /> 
								<input name="pageNoA" type="hidden" value="${pageNoA}" /> 
								<input name="pageSizeA" type="hidden" value="${pageSizeA}" />
								<input id="pageNoB" name="pageNoB" type="hidden" value="${pageNoB}" /> 
								<input id="pageSizeB" name="pageSizeB" type="hidden" value="${pageSizeB}" /> 
								<input name="pageNoC" type="hidden" value="${pageNoC}" /> 
								<input name="pageSizeC" type="hidden" value="${pageSizeC}" />
								<input id="companyName" name="companyName" type="hidden" value="${companyName}" />
								<div class="form-group col-6"
									style="margin-bottom: 0px; float: right;padding-right: 0px;padding-left: 0px;">
									<div class=" input-group input-daterange" id="date-rangeB">
										<div style="display: inline-block; padding-top: 8px;">消费时间范围：&nbsp;&nbsp;</div>
										<input
											value="<fmt:formatDate value="${consumeSynthesis.startDate }" pattern="yyyy-MM-dd"/>"
											id="startDateIdB" autocomplete="off" type="text"
											class="form-control height-control rightAngle" placeholder="开始时间"
											style="text-align: left;" /> <span
											class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
										<input
											value="<fmt:formatDate value="${consumeSynthesis.endDate }" pattern="yyyy-MM-dd"/>"
											id="endDateIdB" autocomplete="off" type="text"
											class="form-control height-control" placeholder="结束时间"
											style="text-align: left;" />
									</div>
								</div>
							</form>
						</div>
						<table
							class="display nowrap table table-hover table-striped table-bordered">
							<thead>
								<tr>
									<th class="tableControl">订单编号</th>
									<th class="tableControl">消费金额/元</th>
									<th class="tableControl">消费行为</th>
									<th class="tableControl">消费时间</th>
									<th class="tableControl">操作人</th>
									<th class="tableControl">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pageB.list}" var="consume">

									<tr>
										<td class="tableControl">${consume.orderNo}</td>
										<td class="tableControl">${consume.payMoney}</td>
										<td class="tableControl">${fn:escapeXml(consume.behavior)}</td>
										<td class="tableControl"><fmt:formatDate
												value="${consume.createDate}" type="both" /></td>
										<td class="tableControl">${consume.loginName}</td>
										<td class="tableControl"><shiro:hasPermission
												name="agentSystem:wasRecordExamine:consume:look">
												<button type="button" data-toggle="tooltip"
													data-original-title="查看"
													onclick="consumeExamine('${consume.orderNo}','${consume.type}',this)"
													class="btn btn-info btn-circle btn-xs">
													<i class="fa fa-search-plus"></i>
												</button>
											</shiro:hasPermission> <shiro:hasPermission
												name="agentSystem:wasRecordExamine:consume:delete">
												<button type="button" data-toggle="tooltip"
													data-original-title="删除"
													onclick="consumeDelete('${consume.orderNo}','${consume.type}')"
													class="btn btn-danger btn-circle btn-xs ">
													<i class="fa fa-times"></i>
												</button>
											</shiro:hasPermission></td>

									</tr>

								</c:forEach>
							</tbody>
						</table>
							<!-- 分页代码 -->
						<c:if test="${pageB.count gt 10}">
							<table:page page="${pageB}"></table:page>
						</c:if>
					</div>
				</shiro:hasPermission>

				<!-- 开票记录 -->
				<shiro:hasPermission name="agentSystem:wasRecordExamine:invoice:tab">
					<div class="tab-pane p-20" id="invoice" role="tabpanel">
						<div class="row col-8" style="float: right;">

							<form action="${ctx}/agentSystem/RecordExamine/list"
								method="post" style="width: 100%" id="invoiceSearchForm">
								<button type="button"
									class="btn waves-effect waves-light btn-info"
									onclick="invoiceSearch()"
									style="float: right; margin-left: 15px;height:35px;">搜索</button>
								<input id="startTimeC" name="startDateC" type="hidden"value="<fmt:formatDate value="${wasInvoiceApplication.startDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endTimeC" name="endDateC" type="hidden"value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="consumeId" name="receivedUserId" type="hidden" value="${receivedUserId}" /> 
								<input name="pageNoA" type="hidden" value="${pageNoA}" /> 
								<input name="pageSizeA" type="hidden" value="${pageSizeA}" />
								<input name="pageNoB" type="hidden" value="${pageNoB}" /> 
								<input name="pageSizeB" type="hidden" value="${pageSizeB}" /> 
								<input id="pageNoC" name="pageNoC" type="hidden" value="${pageNoC}" /> 
								<input id="pageSizeC" name="pageSizeC" type="hidden" value="${pageSizeC}" /> 
								<input id="companyName" name="companyName" type="hidden" value="${companyName}" />
								<div class="form-group col-6"
									style="margin-bottom: 0px; float: right;padding-right: 0px;padding-left: 0px;">
									<div class=" input-group input-daterange" id="date-rangeC">
										<div style="display: inline-block; padding-top: 8px;">申请时间范围：&nbsp;&nbsp;</div>
										<input
											value="<fmt:formatDate value="${wasInvoiceApplication.startDate}" pattern="yyyy-MM-dd"/>"
											type="text" class="form-control height-control rightAngle"
											id="startDateIdC" placeholder="开始时间" autocomplete="off"
											style="text-align: left;" /> <span
											class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
										<input
											value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd"/>"
											type="text" class="form-control height-control"
											id="endDateIdC" placeholder="结束时间" autocomplete="off"
											style="text-align: left;" />
									</div>
								</div>
							</form>
						</div>
						<table
							class="display nowrap table table-hover table-striped table-bordered"
							cellspacing="0" width="100%">
							<thead>
								<tr>
									<th class="tableControl">发票申请号</th>
									<th class="tableControl">发票内容</th>
									<th class="tableControl">状态</th>
									<th class="tableControl">开票金额/元</th>
									<th class="tableControl">申请时间</th>
									<th class="tableControl">操作人</th>
									<th class="tableControl">操作</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${pageC.list}" var="invoice">
									<tr>
										<td class="tableControl">${invoice.invoiceNo}</td>
										<td style="white-space: pre-wrap;" class="tableControl">${fn:escapeXml(invoice.body)}</td>
										<c:if test="${invoice.sendState eq 0}">
											<td class="tableControl">申请中</td>
										</c:if>
										<c:if test="${invoice.sendState eq 1}">
											<td class="tableControl">已发货</td>
										</c:if>
										<c:if test="${invoice.sendState eq 2}">
											<td class="tableControl">已完成</td>
										</c:if>
										<c:if test="${invoice.sendState eq 3}">
											<td class="tableControl">已驳回</td>
										</c:if>
										<td class="tableControl">${invoice.money}</td>
										<td class="tableControl"><fmt:formatDate
												value="${invoice.applyDate}" type="both" /></td>
										<td class="tableControl">${invoice.loginName}</td>
										<td class="tableControl"><shiro:hasPermission
												name="agentSystem:wasRecordExamine:invoice:look">
												<button type="button" data-toggle="tooltip"
													data-original-title="查看"
													onclick="examineJump('${invoice.invoiceNo}')"
													class="btn btn-info btn-circle btn-xs">
													<i class="fa fa-search-plus"></i>
												</button>
											</shiro:hasPermission> <shiro:hasPermission
												name="agentSystem:wasRecordExamine:invoice:delete">
												<button type="button" data-toggle="tooltip"
													onclick="examineDelete('${invoice.invoiceId}','${userId}')"
													data-original-title="删除"
													class="btn btn-danger btn-circle btn-xs ">
													<i class="fa fa-times"></i>
												</button>
											</shiro:hasPermission></td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
							<!-- 分页代码 -->
						<c:if test="${pageC.count gt 10}">
							<table:page page="${pageC}"></table:page>
						</c:if> 
					</div>
				</shiro:hasPermission>
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
								style="white-space: pre-wrap; text-align: left;"></label>
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
								style="word-break: break-word;white-space:pre-wrap;word-wrap:break-word;text-align: left;"></label>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<!-- <div class="modal-footer"
					style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info">保存</button>
				</div> -->
			</div>
		</div>
	</div>

	<!-- 硬件购买模态框 -->
	<div class="modal fade" id="modalHardwarePurchase"
		data-backdrop="static">
		<div class="modal-dialog" style="max-width: 700px;">
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
						<div class="row">
							<div class="col-md-6">
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">订单编号：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>

								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">商品名称：</label>
									<label class="control-label col-7"
										style="white-space: pre-wrap; text-align: left;"></label>
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
									<label class="control-label col-7"
										style="white-space: pre-wrap; text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">购买数量：</label>
									<label class="control-label col-7" style="text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">消费行为：</label>
									<label class="control-label col-7"
										style="white-space: pre-wrap; text-align: left;"></label>
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
									<label class="control-label col-7"
										style="white-space: pre-wrap;text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">操作人：</label>
									<label class="control-label col-7" style="white-space: pre-wrap;text-align: left;"></label>
								</div>
								<div class="form-group row">
									<label class="control-label col-4" style="text-align: right;">备注：</label>
									<label class="control-label col-7"
										style="word-break: break-word;white-space:pre-wrap;word-wrap:break-word;text-align: left;"></label>
								</div>

							</div>
							<!--/span-->
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<!-- <div class="modal-footer"
					style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info">保存</button>
				</div> -->
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
								class="col-9 col-form-label"
								style="white-space: pre-wrap; text-align: left;"></label>
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
								class="col-9 col-form-label"
								style="word-break: break-word;white-space:pre-wrap;word-wrap:break-word;text-align: left;"></label>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<!-- <div class="modal-footer"
					style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info">保存</button>
				</div> -->
			</div>
		</div>
	</div>
	<!-- 开票记录查看跳转 -->
	<form id="exammineJump" method="post"
		action="${ctx}/agentSystem/wasInvoiceApplication/lookInvoice">
		<input id="invoiceNo" name="invoiceNo" type="hidden" value="" />
		<input id="companyName" name="companyName" type="hidden" value="${companyName}" />
		<input id="pageNoC" name="pageNoC" type="hidden" value="${pageNoC}" /> 
		<input id="pageSizeC" name="pageSizeC" type="hidden" value="${pageSizeC}" />
	</form>
	<script type="text/javascript">
		$("document").ready(function() {
			
			var recordFlag = $.cookie("recordFlag");
			if (recordFlag == 0) {

			} else if (recordFlag == 1) {
				document.getElementById("consumeTab").click();
			} else if (recordFlag == 2) {
				document.getElementById("invoiceTab").click();
			}

			$("#hiddenDiv").removeAttr("hidden");

		});

		//日期范围选择
		jQuery('#date-rangeA').datepicker({
			toggleActive : true,
			autoclose : true,
			format : "yyyy-mm-dd"
		});
		jQuery('#date-rangeB').datepicker({
			toggleActive : true,
			autoclose : true,
			format : "yyyy-mm-dd"
		});
		jQuery('#date-rangeC').datepicker({
			toggleActive : true,
			autoclose : true,
			format : "yyyy-mm-dd"
		});
		
		//充值记录分页方法
		function pageA(n, s) {
			$("#pageNoA").val(n);
			$("#pageSizeA").val(s);
			$("#rechargeRearchForm").submit();
			$("span.page-size").text(s);
		}
		//消费记录分页方法
		function pageB(n, s) {
			$("#pageNoB").val(n);
			$("#pageSizeB").val(s);
			$("#consumeSearchForm").submit();
			$("span.page-size").text(s);
		}
		//开票记录分页方法
		function pageC(n, s) {
			$("#pageNoC").val(n);
			$("#pageSizeC").val(s);
			$("#invoiceSearchForm").submit();
			$("span.page-size").text(s);
		}

		//查询方法
		function rechargeSearch() {//查询，页码清零
			$("#pageNoA").val(0);
			$("#startTimeA").val($("#startDateIdA").val());
			$("#endTimeA").val($("#endDateIdA").val()+" 23:59:59");
			$("#rechargeRearchForm").submit();
		}
		function searchConsume() {
			$("#pageNoB").val(0);
			$("#startTimeB").val($("#startDateIdB").val());
			$("#endTimeB").val($("#endDateIdB").val()+" 23:59:59");
			$("#consumeSearchForm").submit();
		}
		function invoiceSearch() {
			$("#pageNoC").val(0);
			$("#startTimeC").val($("#startDateIdC").val());
			$("#endTimeC").val($("#endDateIdC").val()+" 23:59:59");
			$("#invoiceSearchForm").submit();
		}
		var pageNoA = ${pageNoA};
		var pageSizeA = ${pageSizeA};
		var pageNoB = ${pageNoB};
		var pageSizeB = ${pageSizeB};
		var pageNoC = ${pageNoC};
		var pageSizeC = ${pageSizeB};
		var aria ;
		//针对tab切换会出现其他的问题
		function switchover(recordFlag) {
			$.cookie("recordFlag", recordFlag);
			//判断处在哪个tab
				if (recordFlag == 0) {
					$("#rechargeTab").addClass("active");
					$("#consumeTab").removeClass("active");
					$("#invoiceTab").removeClass("active");
					$('#recharge').show();
					$('#consume').hide();
					$('#invoice').hide();
					
				} else if(recordFlag == 1){
					$("#rechargeTab").removeClass("active");
					$("#consumeTab").addClass("active");
					$("#invoiceTab").removeClass("active");
					$('#recharge').hide();
					$('#consume').show();
					$('#invoice').hide();
					
				}else if(recordFlag == 2){
					$("#rechargeTab").removeClass("active");
					$("#consumeTab").removeClass("active");
					$("#invoiceTab").addClass("active");
					$('#recharge').hide();
					$('#consume').hide();
					$('#invoice').show();
					
				}
			
			
		}
		//充值记录删除
		function rechargeDelete(rechargeId, userId) {
			var menuId = $("#btnId", parent.document).val();
			layer.confirm("确认删除数据吗?", {
				closeBtn : 0,
				icon : 3,
				skin : 'layui-layer-molv',
				btn : [ '确认', '取消' ]
			}, function() {
				var index = layer.load(1, {
					shade : [ 0.1, '#fff' ]
				});
				$.ajax({
					url : "${ctx}/agentSystem/RechargeHistory/deleteByLogic",
					type : "post",
					data : {
						rechargeId : rechargeId,
						menuId : menuId
					},
					success : function(data) {
						layer.close(index);
						if (data == 1) {
							var num = ${numA};
							layer.msg("删除成功！", {icon : 1,time : 1000
							}, function() {
								if(num == 1){
									$("#pageNoA").val(pageNoA-1);
									$("#rechargeRearchForm").submit();
								}else{$("#rechargeRearchForm").submit();}
								/* $("#rechargeRearchForm").submit(); */
							});
						}
					},
					error : function(e) {
						layer.msg('删除失败！', {
							icon : 2
						});
						layer.close(index);
					}
				});
			});
		}

		
		//消费记录查看
		function consumeExamine(orderNo, type,obj) {
			$(obj).blur();
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
								if(data.remarks != null && data.remarks != ""){
									$("#modalPolicyPurchase label:eq(27)").text(
											data.remarks);
								}else{
									$("#modalPolicyPurchase label:eq(27)").text("--");
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
						if(data.remarks != null && data.remarks != ""){
							$("#modalHardwarePurchase label:eq(31)").text(
								data.remarks);
						}else{
							$("#modalHardwarePurchase label:eq(31)").text("--");
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
						if(data.remarks != null && data.remarks != ""){
							$("#modalExpendPay label:eq(21)").text(data.remarks);
						}else{
							$("#modalExpendPay label:eq(21)").text("--");
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
		}

		//消费记录删除
		function consumeDelete(orderNo, type) {
			var menuId = $("#btnId", parent.document).val();

			layer.confirm("确认删除数据吗?",{closeBtn : 0,icon : 3,skin : 'layui-layer-molv',
								btn : [ '确认', '取消' ]},
							function() {
								var index = layer.load(1, {
									shade : [ 0.1, '#fff' ]
								});
								if (type == 1) {//软件消费删除
									$.ajax({
										url : "${ctx}/agentSystem/PolicyPurchase/deleteByLogic",
											type : "post",
											dataType : "JSON",
											data : {"number" : orderNo,
													"menuId" : menuId},
											success : function(data) {
												layer.close(index);
												if (data == 1) {
													var num = ${numB};
													layer.msg("删除成功！",{icon : 1,time : 1000},function() {
														if(num == 1){
															$("#pageNoB").val(pageNoB-1);
															$("#consumeSearchForm").submit();
														}else{
															$("#consumeSearchForm").submit();
														}
														
													});
												}
											},error : function(e) {
													layer.close(index);
													layer.msg('删除失败！', {
														icon : 2
													});
												}
											});
								} else if (type == 2) {//硬件消费删除
									$.ajax({
												url : "${ctx}/hardware/hardwarePurchase/deleteByLogic",
												type : "post",
												dataType : "JSON",
												data : {
													"orderNo" : orderNo,
													"menuId" : menuId
												},
												success : function(data) {
													if (data == 1) {
														var num = ${numB};
														layer.close(index);
														layer.msg("删除成功！",{icon : 1,time : 1000},
															function() {
															if(num == 1){
																$("#pageNoB").val(pageNoB-1);
																$("#consumeSearchForm").submit();
															}else{
																$("#consumeSearchForm").submit();
															}
															});
													}
												},
												error : function(e) {
													layer.close(index);
													layer.msg('删除失败！', {
														icon : 2
													});

												}
											});
								} else if (type == 3) {//充消删除
									$.ajax({
												url : "${ctx}/agentSystem/ExpendPay/deleteByLogic",
												type : "post",
												dataType : "JSON",
												data : {
													"orderNo" : orderNo,
													"menuId" : menuId
												},
												success : function(data) {
													if (data == 1) {
														var num = ${numB};
														layer.close(index);
														layer.msg("删除成功！",{icon : 1,time : 1000},
															function() {
															if(num == 1){
																$("#pageNoB").val(pageNoB-1);
																$("#consumeSearchForm").submit();
															}else{
																$("#consumeSearchForm").submit();
															}
															});
													}
												},
												error : function(e) {
													layer.close(index);
													layer.msg('删除失败！', {
														icon : 2
													});

												}
											});
								} else {
									layer.close(index);
									layer.msg('系统数据出错！', {
										icon : 2
									});
								}
							});
		}

		//开票记录查看
		function examineJump(invoiceNo) {
			$("#invoiceNo").val(invoiceNo);
			$("#exammineJump").submit();

		}

		//开票记录删除
		function examineDelete(invoiceId, userId) {
			var menuId = $("#btnId", parent.document).val();

			layer.confirm(
							"确认删除数据吗?",
							{
								closeBtn : 0,
								icon : 3,
								skin : 'layui-layer-molv',
								btn : [ '确认', '取消' ]
							},
							function() {
								var index = layer.load(1, {
									shade : [ 0.1, '#fff' ]
								});
								$.ajax({
											url : "${ctx}/agentSystem/wasInvoiceApplication/updateState",
											type : "post",
											data : {
												invoiceId : invoiceId,
												"userId" : userId,
												"menuId" : menuId
											},
											success : function(data) {
												if (data == 1) {
													var num = ${numC};
													layer.close(index);
													layer.msg("删除成功！", {icon : 1,time : 1000
													}, function() {
														if(num == 1){
															$("#pageNoC").val(pageNoC-1);
															$("#invoiceSearchForm").submit();
														}else{
															$("#invoiceSearchForm").submit();
														}
														
													});
												}
											},
											error : function(e) {
												layer.msg('删除失败！', {
													icon : 2
												});
												layer.close(index);
											}
										});
							});
		}
	</script>

</body>
</html>