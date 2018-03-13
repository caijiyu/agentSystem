
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 开票申请已申请列表 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<style>
.space{
	white-space: pre-wrap;
}
</style>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="home2" role="tabpanel">
					<div class="row button-group col-3" style="float: left;">						
					</div>
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/wasInvoiceApplication/list" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>

							<input autocomplete="off" type="text" class="form-control height-control col-3" id="keywordOne" placeholder="请输入代理商名称关键字" autocomplete="off" value="${companyNameUser}" style="float: right;"/> 
								<input type="hidden" id="keyword" value="${fn:escapeXml(companyNameUser)}"  name="companyNameUser" />
								<input id="timeStartOne" value="<fmt:formatDate value="${wasInvoiceApplication.beginDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>" type="hidden" name="beginDate"/>
								<input id="timeEndOne" value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="hidden" name="endDate"/>
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 								
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">申请时间范围：&nbsp;&nbsp;</div>
									<input id="timeStart" value="<fmt:formatDate value="${wasInvoiceApplication.beginDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" autocomplete="off" style="text-align: left;" />								
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
									<input id="timeEnd" value="<fmt:formatDate value="${wasInvoiceApplication.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" autocomplete="off" style="text-align: left;" />									
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable"
						class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th class="tableControl">代理商</th>
								<th class="tableControl">开票公司名称</th>
								<th class="tableControl">发票内容</th>
								<th class="tableControl">开票金额/元</th>
								<th class="tableControl">申请时间</th>
								<th class="tableControl">申请状态</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${page.list}" var="log">
								<tr>
									<c:if test="${log.sendState == 3}">
										<td class="tableControl space">${fn:escapeXml(log.companyNameUser)}</td>
										<td class="tableControl space">${fn:escapeXml(log.companyName)}</td>
										<td class="tableControl space">${fn:escapeXml(log.body)}</td>
										<td class="tableControl">${log.money}</td>
										<td class="tableControl"><fmt:formatDate
												value="${log.applyDate}" type="both" /></td>
										<td class="tableControl">${log.sendState==0?'申请中':'已驳回'}</td>
										<td class="tableControl">
										<shiro:hasPermission name="agentsystem:wasInvoiceApplication:lookInform">
											<button type="button" data-toggle="tooltip"
												data-original-title="查看"
												class="btn btn-info btn-circle btn-xs"
												onclick="lookInform('${log.invoiceNo}');">
												<i class="fa fa-search-plus"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:deliver">
											<button type="button" disabled="disabled"
												data-toggle="tooltip" data-original-title="发货"
												class="btn btn-info btn-circle btn-xs"
												onclick="send('${log.invoiceId}',this)">
												<i class="iconf icon-fahuo1"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:rejectSave">
											<button type="button" disabled="disabled"
												data-toggle="tooltip" data-original-title="驳回"
												class="btn btn-info btn-circle btn-xs"
												onclick="rejectAsk('${log.invoiceId}','${log.invoiceNo}',this)">
												<i class="iconf icon-zl_bohui"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentSystem:wasRecordExamine:invoice:delete">
											<button type="button" data-toggle="tooltip"
												data-original-title="删除"
												class="btn btn-danger btn-circle btn-xs "
												onclick="deleteS('${log.invoiceId}','${log.state}')">
												<i class="fa fa-times"></i>
											</button>
											</shiro:hasPermission>
										</td>
									</c:if>
									<c:if test="${log.sendState == 0}">
										<td class="tableControl">${fn:escapeXml(log.companyNameUser)}</td>
										<td class="tableControl">${fn:escapeXml(log.companyName)}</td>
										<td class="tableControl">${fn:escapeXml(log.body)}</td>
										<td class="tableControl">${log.money}</td>
										<td class="tableControl"><fmt:formatDate
												value="${log.applyDate}" type="both" /></td>
										<td class="tableControl">${log.sendState==0?'申请中':'已驳回'}</td>
										<td class="tableControl">
										<shiro:hasPermission name="agentsystem:wasInvoiceApplication:lookInform">
											<button type="button" data-toggle="tooltip"
												data-original-title="查看"
												class="btn btn-info btn-circle btn-xs"
												onclick="lookInform('${log.invoiceNo}');">
												<i class="fa fa-search-plus"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:deliver">
											<button type="button" data-toggle="tooltip"
												data-original-title="发货"
												class="btn btn-info btn-circle btn-xs"
												onclick="send('${log.invoiceId}',this)">
												<i class="iconf icon-fahuo1"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasInvoiceApplication:rejectSave">
											<button type="button" data-toggle="tooltip"
												data-original-title="驳回"
												class="btn btn-info btn-circle btn-xs"
												onclick="rejectAsk('${log.invoiceId}','${log.invoiceNo}',this)">
												<i class="iconf icon-zl_bohui"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentSystem:wasRecordExamine:invoice:delete">
											<button type="button" data-toggle="tooltip"
												data-original-title="删除"
												class="btn btn-danger btn-circle btn-xs "
												onclick="deleteS('${log.invoiceId}','${log.state}')">
												<i class="fa fa-times"></i>
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
	<form  id="lookJump" hidden="hidden" action="${ctx}/agentSystem/wasInvoiceApplication/lookInform" method="post">
		<input name="sendFlag" value="1" />
		<input id="invoiceNoL" name="invoiceNo" value="" />
	</form>
	<!-- 模态框 -->
	<div class="modal fade" id="modalSendOut" data-backdrop="static">
		<div class="modal-dialog">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->				
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size: 14px">发货</span><button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="sendForm">
						<div class="form-group row" hidden="hidden">
							<label for="example-text-input" class="col-3 col-form-label"></label>
							<div class="col-8 controls">
								<input id="sendInvoiceId" value=""  autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">								
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">公司名称：</label>
							<div class="col-8 controls">
								<input id="sendCompanyName" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">								
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">收货人：</label>
							<div class="col-8 controls">
								<input id="sendName" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">联系方式：</label>
							<div class="col-8 controls">
								<input id="sendPhone" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">收货地址：</label>
							<div class="col-8 controls">
								<input id="sendAddress" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color: red">*&nbsp; </span>快递公司：</label>
							<div class="col-8 controls">
								<select class="custom-select height-control col-12" id="sendExpress" name="sendExpress">
									<option value="" selected>选择快递公司</option>
									<!-- <option value="SF">顺丰快递</option> -->
									<option value="HHTT">天天快递</option>
									<option value="HOAU">天地华宇</option>
									<option value="HTKY">百世快递</option>
									<option value="ZTO">中通快递</option>
									<option value="STO">申通快递</option>
									<option value="YTO">圆通快递</option>
									<option value="YD">韵达快递</option>
									<option value="YZPY">邮政平邮</option>
									<option value="EMS">EMS</option>
									<option value="DBL">德邦物流</option>
								</select>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color: red">*&nbsp; </span>快递单号： </label>
							<div class="col-8 controls">
								<input id="sendExpressNumber" name="sendExpressNumber" autocomplete="off" type="text" name="text" maxlength="20" class="form-control height-control">
							</div>
						</div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="save();">保存</button>
				</div>
			</div>
		</div>
	</div>
		<!-- 驳回的模态框 -->
	 <div class="modal fade" id="modalReject" data-backdrop="static">
		<div class="modal-dialog" style="margin-top: 200px;">
			<!-- 宽高、定位 -->
			<div class="modal-content">
				<!-- 对话框头 -->				
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size: 14px">驳回</span><button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!-- 主体部分 -->
				<div class="modal-body">
					<form id="rejectForm">
						<div class="form-group row" hidden="hidden">
							<label for="example-text-input" class="col-3 col-form-label"></label>
							<div class="col-8 controls">
								<input id="rejectInvoiceId" value=""  autocomplete="off" type="text" name="invoiceId" class="form-control height-control" readonly="readonly">								
							</div>
						</div>
						<div class="form-group row" hidden="hidden">
							<label for="example-text-input" class="col-3 col-form-label"></label>
							<div class="col-8 controls">
								<input id="rejectInvoiceNo" value=""  autocomplete="off" type="text" name="invoiceNo" class="form-control height-control" readonly="readonly">								
							</div>
						</div>																	
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color: red">*&nbsp; </span>驳回说明：</label>
							<div class="col-8 controls">
								<textarea id="rejectReason" name="reason" maxlength="100" class="form-control height-control" style="height:65px!important;word-break:break-all;"></textarea>
							</div>
						</div>
					</form>
				</div>
				<!-- 对话框尾 -->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="rejectSave();">保存</button>
				</div>
			</div>
		</div>
	</div> 

	<script type="text/javascript">	
	//点击回车搜索
	$('#keywordOne').bind('keypress', function(event) {
		if (event.keyCode == "13") {
			search();
		}
	});
	
	$(function() {		
		//表单验证
		$("#sendForm").validate({
			rules : {
				sendExpress : {
					required : true,
				},
				sendExpressNumber : {
					required : true,
				},
			},
			messages : {
				sendExpress : {
					required : "请选择快递公司",
				},
				sendExpressNumber : {
					required : "请输入快递单号",
				},
			},
			errorPlacement : function(error, element) {
				error.insertAfter(element);
				}
			});
		//驳回的表单验证
		$("#rejectForm").validate({
			rules :{
				reason:{
					required:true,
					maxlength:100,
					}
			},
			messages:{
				reason:{
					required :"请输入拒绝理由",
					maxlength :"输入的最大长度为100",
				}
			}
		});
		
		});
	
		function lookInform(invoiceNo){		
			$("#invoiceNoL").val(invoiceNo)
			$("#lookJump").submit();
		}		
		//驳回的模态框显示
		function rejectAsk(invoiceId,invoiceNo,obj) {				
			$("#rejectReason").val("");
			$("#rejectReason").removeClass("error");
			$("#rejectReason-error").remove();
			$("#rejectInvoiceId").val(invoiceId);
			$("#rejectInvoiceNo").val(invoiceNo);
			$("#modalReject").modal("show");
			$(obj).blur();
		}
		function rejectSave(){
			var isValid = $("#rejectForm").valid();
			var buttonId = $("#rejectInvoiceId").val();
			if(isValid){
				
				layer.confirm("确认驳回？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
						function(){
							var index = layer.load(1, {shade: [0.1,'#fff']});
							$.ajax({
							    url:'${ctx}/agentSystem/wasInvoiceApplication/rejectSave',
							    type:'POST',
							    data:{
							    	invoiceId:$("#rejectInvoiceId").val(),
							    	reason:$("#rejectReason").val(),
							    	invoiceNo:$("#rejectInvoiceNo").val(),
							    },
							    dataType:'json',
							    success:function(result){
							    	layer.close(index)
							    	if(result > 0){
							    		layer.msg("操作成功！",{icon:1,time:1000},function(){
							    			$("#searchForm").submit();//模拟提交（已拒绝3）						    			
										});	
							    	}
							    },
							    error:function(xhr,textStatus){
							    	layer.close(index);
							    	layer.msg('操作失败！', { icon : 2 });
							    },
							})
						});
			}
		}
		//发货显示模态框
		function send(invoiceId,obj) {	
			var index = layer.load(1, {shade: [0.1,'#fff']});
			 $.ajax({
			    url:'${ctx}/agentSystem/wasInvoiceApplication/deliver',
			    type:'POST',
			    data:{
			    	invoiceId:invoiceId,
			    },
			    dataType:'json',
			    success:function(result){
			    	layer.close(index);
			    	$("#sendInvoiceId").val(invoiceId);			 
			    	$("#sendCompanyName").val(result.companyName);
			    	$("#sendName").val(result.name);
			    	$("#sendPhone").val(result.phone);
			    	$("#sendAddress").val(result.address);
			    				    	
			    	$("#sendExpress").removeClass("error");
			    	$("#sendExpress-error").remove();
			    	$("#sendExpressNumber-error").remove();
			    	$("#sendExpress option:first").prop("selected", 'selected');  
			    	$("#sendExpressNumber").val(""); 
			    	$("#modalSendOut").modal("show");
			    	$(obj).blur();
			    },
			    error:function(xhr,textStatus){
			    	layer.close(index);
			    	layer.msg('查看失败！', { icon : 2 });
			    },
			});				 							
		}
		//发货模态框的保存
		function save(){
			var isValid = $("#sendForm").valid();
			if (isValid) {
						
						layer.confirm("确认发货？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
						function(){
							var index = layer.load(1, {shade: [0.1,'#fff']});
							$.ajax({
							    url:'${ctx}/agentSystem/wasInvoiceApplication/deliverSave',
							    type:'POST',
							    data:{
							    	invoiceId:$("#sendInvoiceId").val(),
							    	expressCompany:$("#sendExpress").find("option:selected").text(),
							    	expressCoding:$('#sendExpress').val(),
							    	expressNumber:$('#sendExpressNumber').val(),
							    },
							    dataType:'json',
							    success:function(result){
							    	layer.close(index);
							    	var countSum = ${page.count};
							    	var countSize = ${page.pageSize};
							    	if(result > 0){
							    		var last = '${isLast}';//$("#isLast").val();
						    			if(last == '1'){
						    				var number = Number(countSum)%Number(countSize);
						    				if(number == 1){
						    					$("#pageNo").val($("#pageNo").val()-1);
						    					$("#pageSize").val($("#pageSize").val());
						    					layer.msg("操作成功！",{icon:1,time:1000},function(){
						    						$("#searchForm").submit();
												});					    				
						    				}else{
						    					layer.msg("操作成功！",{icon:1,time:1000},function(){
						    						$("#searchForm").submit();
												});	
						    				}			    				
						    			}else{
						    				layer.msg("操作成功！",{icon:1,time:1000},function(){
					    						$("#searchForm").submit();
											});	
						    			}	
							    		/* layer.msg("操作成功！",{icon:1,time:1000},function(){
							    			$("#searchForm").submit();//模拟提交（发货状态为1）
										});	 */
							    	}
							    },
							    error:function(xhr,textStatus){
							    	layer.close(index);
							    	layer.msg('操作失败！', { icon : 2 });
							    },
							})
						});
			}
		}
		var menuId = $("#btnId",parent.document).val();
		//删除对应的信息
		function deleteS(invoiceId,state){
			
				layer.confirm("确认删除该订单？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
					function(){
						var index = layer.load(1, {shade: [0.1,'#fff']});
						$.ajax({
						    url:'${ctx}/agentSystem/wasInvoiceApplication/updateState',
						    type:'POST',
						    data:{
						    	invoiceId:invoiceId,
						    	state:state,
						    	menuId:menuId,
						    },
						    dataType:'json',
						    success:function(result){
						    	layer.close(index);
						    	var countSum = ${page.count};
						    	var countSize = ${page.pageSize};
						    	if(result > 0){
						    		var last = '${isLast}';//$("#isLast").val();
					    			if(last == '1'){
					    				var number = Number(countSum)%Number(countSize);
					    				if(number == 1){
					    					$("#pageNo").val($("#pageNo").val()-1);
					    					$("#pageSize").val($("#pageSize").val());
					    					layer.msg("操作成功！",{icon:1,time:1000},function(){
					    						$("#searchForm").submit();
											});					    				
					    				}else{
					    					layer.msg("操作成功！",{icon:1,time:1000},function(){
					    						$("#searchForm").submit();
											});	
					    				}			    				
					    			}else{
					    				layer.msg("操作成功！",{icon:1,time:1000},function(){
				    						$("#searchForm").submit();
										});	
					    			}						    		
						    		/* layer.msg("操作成功！",{icon:1,time:1000},function(){
						    			$("#searchForm").submit();
									});	 */
						    	}
						    },
						    error:function(xhr,textStatus){
						    	layer.close(index);
						    	layer.msg('操作失败！', { icon : 2 });
						    },
						})
					});
			
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
			$("#keyword").val($("#keywordOne").val());
			$("#timeStartOne").val($("#timeStart").val());			
			$("#timeEndOne").val($("#timeEnd").val() +' 23:59:59');
			$("#pageNo").val(0);
			$("#searchForm").submit();
		}
		//checkbox监听
		$('#ischange').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
			$('.check').iCheck('check');
		});
		$('#ischange').on('ifUnchecked', function(event){ //ifUnchecked 事件应该在插件初始化之前绑定 
			$('.check').iCheck('uncheck');
		});		
	</script>

</body>
</html>