
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 硬件购买已完成列表 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<div class="card-body">
				<div class="tab-content">
						<div class="row col-9" style="float: right;">
							<form action="${ctx}/hardware/hardwarePurchase/finishList" method="post" style="width: 100%" id="searchForm">
								<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
		
								<input id="searchName" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入代理商公司名称关键字" value="${fn:escapeXml(wasHardwarePurchase.purchasedCompanyName)}" style="float: right;"> 
								<input id="purCompanyName" name="purchasedCompanyName" type="hidden" value="${fn:escapeXml(wasHardwarePurchase.purchasedCompanyName)}"> 
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
								<input id="beginDate" name="beginDate" type="hidden"  value="<fmt:formatDate value="${wasHardwarePurchase.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endDate" name="endDate" type="hidden" value="<fmt:formatDate value="${wasHardwarePurchase.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
									<div class=" input-group input-daterange" id="dateRange">
										<div  style="display:inline-block;padding-top: 8px;">下单时间范围：&nbsp;&nbsp;</div>
										<input autocomplete="off" id="searchBeginDate" value="<fmt:formatDate value="${wasHardwarePurchase.beginDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间"  style="text-align: left;" />
										<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
										<input autocomplete="off" id="searchEndDate" value="<fmt:formatDate value="${wasHardwarePurchase.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control" placeholder="结束时间"  style="text-align: left;" />
									</div>
								</div>
							</form>
						</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
						<thead>
							<tr>
								<th class="tableControl">公司名称</th>
								<th class="tableControl">商品名称</th>
								<th class="tableControl">购买数量</th>
								<th class="tableControl">消费总额/元</th>
								<th class="tableControl">收货人</th>
								<th class="tableControl">联系电话</th>
								<th class="tableControl">下单时间</th>
								<th class="tableControl">完成时间</th>
								<th class="tableControl">收货方式</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="wasHardwarePurchase">
								<tr>
									<td class="tableControl"  style="white-space: pre-wrap;">${fn:escapeXml(wasHardwarePurchase.purchasedCompanyName)}</td>
									<td class="tableControl"  style="white-space: pre-wrap;">${fn:escapeXml(wasHardwarePurchase.hardwareName)}</td>
									<td class="tableControl">${fn:escapeXml(wasHardwarePurchase.number)}</td>
									<td class="tableControl">${fn:escapeXml(wasHardwarePurchase.payMoney)}</td>
									<td class="tableControl"  style="white-space: pre-wrap;">${fn:escapeXml(wasHardwarePurchase.name)}</td>
									<td class="tableControl">${fn:escapeXml(wasHardwarePurchase.phone)}</td>
									<td class="tableControl"><fmt:formatDate value="${wasHardwarePurchase.createDate}" type="both" /></td>
									<td class="tableControl"><fmt:formatDate value="${wasHardwarePurchase.receiveDate}" type="both" /></td>
									<td class="tableControl">${wasHardwarePurchase.deliveryMethod ? "快递" : "自提"}</td>
									<td class="tableControl">
										<shiro:hasPermission name="agency:wasHardwarePurchase:finishView">
											<button type="button" data-toggle="tooltip" data-original-title="查看" class="btn btn-info btn-circle btn-xs" onclick="show('${wasHardwarePurchase.hardwarePurchaseId}', this)">
												<i class="fa fa-search-plus"></i>
											</button>
										</shiro:hasPermission> 
										<shiro:hasPermission name="agency:wasHardwarePurchase:finishDelete">
											<button type="button" data-toggle="tooltip" data-original-title="删除" class="btn btn-danger btn-circle btn-xs" onclick="del('${wasHardwarePurchase.hardwarePurchaseId}',0)">
												<i class="fa fa-times"></i>
											</button>
										</shiro:hasPermission>
									</td>
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

	<!-- 模态框 -->
	<div class="modal fade" id="modal" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				<div class="modal-header" style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size: 14px">查看</span>
					<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body logisticsClass" style="overflow-y:scroll; max-height: 600px;">
					<form>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">公司名称：</label>
							<div class="col-8 divMiddle">
								<div id="purchasedCompanyName" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">购买商品：</label>
							<div class="col-8 divMiddle">
								<div id="hardwareName" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">购买数量：</label>
							<div class="col-8 divMiddle">
								<div id="number" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">消费总额：</label>
							<div class="col-8 divMiddle">
								<div id="payMoney" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">收货人：</label>
							<div class="col-8 divMiddle">
								<div id="name" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">联系电话：</label>
							<div class="col-8 divMiddle">
								<div id="phone" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row" id="addressRow">
							<label for="example-text-input" class="col-3 col-form-label">收货地址：</label>
							<div class="col-8 divMiddle">
								<div id="address" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">下单时间：</label>
							<div class="col-8 divMiddle">
								<div id="createDate" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row" id="deliverDateRow">
							<label for="example-text-input" class="col-3 col-form-label">发货时间：</label>
							<div class="col-8 divMiddle">
								<div id="deliverDate" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">完成时间：</label>
							<div class="col-8 divMiddle">
								<div id="receiveDate" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row" id="expressCompanyRow">
							<label for="example-text-input" class="col-3 col-form-label">快递公司：</label>
							<div class="col-8 divMiddle">
								<div id="expressCompany" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
						<div class="form-group row" id="expressNumberRow">
							<label for="example-text-input" class="col-3 col-form-label">快递单号：</label>
							<div class="col-8 divMiddle">
								<div id="expressNumber" class="divFont" style="white-space: pre-wrap;"></div>
							</div>
						</div>
						<div class="form-group row" id="remarksRow">
							<label for="example-text-input" class="col-3 col-form-label">备注：</label>
							<div class="col-8 divMiddle">
								<div id="remarks" class="divFont" style="white-space: pre-wrap;word-break: break-all;"></div>
							</div>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>
	
	<script type="text/javascript">
		//分页方法
		function page(n,s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			$("span.page-size").text(s);
		}
		//日期范围选择
		jQuery('#dateRange').datepicker({
			toggleActive : true,
			autoclose: true,
			format : "yyyy-mm-dd"
		});
		
		//查询方法
		function search(){//查询，页码清零
			$("#purCompanyName").val($("#searchName").val());
			$("#beginDate").val($("#searchBeginDate").val());
			$("#endDate").val($("#searchEndDate").val() + " 23:59:59");
			$("#pageNo").val(0);
			$("#searchForm").submit();
		}
		//点击回车进行搜索		
		$('#searchName').bind('keypress', function(event) {
			if (event.keyCode == "13") {
				search();
			}
		});
		//查看方法
		function show(hardwarePurchaseId, obj){
			$(obj).blur();
			var index = layer.load(1, {shade: [0.1,'#fff']});
			$.ajax({
			    url:'${ctx}/hardware/hardwarePurchase/form',
			    type:'POST',
			    data:{
			    	hardwarePurchaseId:hardwarePurchaseId,
			    },
			    dataType:'json',
			    success:function(result){
			    	$("#purchasedCompanyName").text(result.purchasedCompanyName);
			    	$("#hardwareName").text(result.hardwareName);
			    	$("#number").text(result.number);
			    	var money = result.payMoney.toFixed(2) + "元";
			    	$("#payMoney").text(money);
			    	$("#name").text(result.name);
			    	$("#phone").text(result.phone);
			    	
			    	if (result.address != null && result.address != "") {
			    		$("#address").text(result.address);
					} else {
						$("#address").text('--');
					}
			    	
			    	$("#createDate").text(result.createDate);
			    	
			    	if (result.deliverDate != null && result.deliverDate != "") {
			    		$("#deliverDate").text(result.deliverDate);
					} else {
						$("#deliverDate").text('--');
					}
			    	$("#receiveDate").text(result.receiveDate);
			    	
			    	if (result.expressCompany != null && result.expressCompany != "") {
			    		$("#expressCompany").text(result.expressCompany);
					} else {
						$("#expressCompany").text('--');
					}
			    	if (result.expressNumber != null && result.expressNumber != "") {
			    		$("#expressNumber").text(result.expressNumber);
					} else {
						$("#expressNumber").text('--');
					}
			    	if (result.remarks != null && result.remarks != "") {
				    	$("#remarks").text(result.remarks);
					} else {
						$("#remarks").text('--');
					}
			    	layer.close(index);
			    	$("#modal").modal("show");
			    },
			    error:function(xhr,textStatus){
			    	layer.msg('查看失败！', { icon : 2 });
			    },
			})
		}
		
		//删除订单
		function del(hardwarePurchaseId,state) {
			layer.confirm("确认删除数据吗？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
					function(){
						var index = layer.load(1, {shade: [0.1,'#fff']});
						$.ajax({
						    url:'${ctx}/hardware/hardwarePurchase/updateState',
						    type:'POST',
						    data:{
						    	menuId:$('#btnId',parent.document).val(),
						    	hardwarePurchaseId:hardwarePurchaseId,
						    	state:state,
						    },
						    dataType:'json',
						    success:function(result){
						    	layer.close(index);
						    	if(result > 0){
						    		layer.msg("删除成功！",{icon:1,time:1000},function(){
						    			$("#searchForm").submit();
									});	
						    	}
						    },
						    error:function(xhr,textStatus){
						    	layer.close(index);
						    	layer.msg('删除失败！', { icon : 2 });
						    },
						})
					});
		}
	</script>

</body>
</html>