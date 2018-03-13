
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 反馈已回复和未回复的列表 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<style>
.trInstall{
   max-width: 150px;
}
.trSpace{
	white-space:pre-wrap;
}
.label-left{
 text-align: left;
}
.label-right{
text-align: right;
}
.MHover{
    border:1px solid #ccc;
   	white-space:nowrap; 
    text-overflow:ellipsis;
    overflow:hidden;
}
.space{
	white-space: pre-wrap;
	word-break: break-word;
	word-wrap:break-word;
}

</style>
<body>
<div class="divControl" hidden="hidden" id="hiddenDiv">
	
		<div class="card cardControl">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs customtab" role="tablist">
				<li class="nav-item">
					<a id="notAnswere" class="nav-link active" href="#" onclick="switchover(0)"> 
						<span class="hidden-sm-up"><i class="ti-home"></i></span> 
						<span class="hidden-xs-down">未回复</span>
					</a>
				</li>
				<li class="nav-item">
					<a id="allAnswere" class="nav-link" href="#" onclick="switchover(1)"> 
						<span class="hidden-sm-up"><i class="ti-user"></i></span> 
						<span class="hidden-xs-down">已回复</span>
					</a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="homeTwo" role="tabpanel">					
					<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/wasAgentAnsweredList/listA" method="post" style="width: 100%" id="searchForm">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px;">搜索</button>
								<input autocomplete="off" type="text" class="form-control height-control col-3" id="keywordOne" placeholder="请输入公司名称关键字" autocomplete="off" value="${companyName}" style="float: right;"/> 
								<input type="hidden" id="keyword" value="${companyName}"  name="companyName" />							
								<input id="timeStartOne" value="<fmt:formatDate value="${wasFeedBack.beginDate}" pattern="yyyy-MM-dd  HH:mm:ss"/>" type="hidden" name="beginDate"/>
								<input id="timeEndOne" value="<fmt:formatDate value="${wasFeedBack.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="hidden" name="endDate"/>
								<input id="isLast"  type="hidden"  value="${isLast}" /> 
								<input id="pageNo" name="pageNo" type="hidden"  value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
								<input id="pageNoN" name="pageNoA" type="hidden" value="" /> 
								<input id="pageSizeS" name="pageSizeA" type="hidden" value="" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-range">
									<div style="display:inline-block;padding-top: 8px;">反馈时间范围：&nbsp;&nbsp;</div>
									<input id="timeStart" value="<fmt:formatDate value="${wasFeedBack.beginDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" autocomplete="off" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
									<input id="timeEnd" value="<fmt:formatDate value="${wasFeedBack.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" autocomplete="off" style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								
								<th class="tableControl">公司名称</th>
								<th class="tableControl">代理商等级</th>
								<th class="tableControl">问题类型</th>
								<th class="tableControl">反馈时间</th>
								<th class="tableControl">问题描述</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="tbodyA">					
							<c:forEach items="${page.list}" var="log">
									<c:if test="${log.replyState == 0}">
								<tr>
																
									<td class="tableControl space">${fn:escapeXml(log.companyName)}</td>
									<td class="tableControl space">${fn:escapeXml(log.name)}</td>
									<c:if test="${log.type == 1}">
									<td class="tableControl">公众号</td>
									</c:if>
									<c:if test="${log.type == 2}">
									<td class="tableControl">小程序</td>
									</c:if>
									<c:if test="${log.type == 3}">
									<td class="tableControl">硬件</td>
									</c:if>
									<c:if test="${log.type == 4}">
									<td class="tableControl">售后</td>
									</c:if>
									<c:if test="${log.type == 5}">
									<td class="tableControl">文档</td>
									</c:if>
									<td class="tableControl"><fmt:formatDate value="${log.quizDate}" type="both" /></td>									
									<td class="tableControl trInstall MHover">${fn:escapeXml(log.description)}</td>
									<td class="tableControl">
									<shiro:hasPermission name="agentsystem:wasAgentAnswered:lookReply">
									<button type="button" data-toggle="tooltip" 
												data-original-title="回复"
												class="btn btn-info btn-circle btn-xs"
												onclick="reply('${log.feedbackId}',this);">
												<i class="iconf icon-huifu"></i>
											</button>	
									</shiro:hasPermission>																		
									</td>
								
								</tr>
								</c:if>
							</c:forEach>
						</tbody>
					</table>
					<!-- 分页代码 -->
					<div id="pageTable">
					<c:if test="${page.count gt 10}">
						<table:page page="${page}"></table:page>
					</c:if>
					</div>
				</div>
				<!-- 已回复对应的列表 -->
				<div class="tab-pane p-20" id="profileTwo" role="tabpanel">
									<div class="row col-9" style="float: right;">
						<form action="${ctx}/agentSystem/wasAgentAnsweredList/listA" method="post" style="width: 100%" id="searchFormA">
							<button type="button" class="btn waves-effect waves-light btn-info" onclick="searchA()" style="float: right;margin-left: 15px;">搜索</button>	
								<input type="text" class="form-control height-control col-3" id="keywordOneA" placeholder="请输入公司名称关键字" autocomplete="off" value="${companyNameA}" style="float: right;"/> 
								<input type="hidden" id="keywordA" value="${companyNameA}"  name="companyNameA" />					
								<input id="timeStartTwo" value="<fmt:formatDate value="${wasFeedBackA.beginDateA}" pattern="yyyy-MM-dd  HH:mm:ss"/>" type="hidden" name="beginDateA"/>
								<input id="timeEndTwo" value="<fmt:formatDate value="${wasFeedBackA.endDateA}" pattern="yyyy-MM-dd HH:mm:ss"/>" type="hidden" name="endDateA"/>
								<input id="pageNoA" name="pageNoA" type="hidden" value="${pageA.pageNo}" /> 
								<input id="pageSizeA" name="pageSizeA" type="hidden" value="${pageA.pageSize}" />
								<input id="pageNoAN" name="pageNo" type="hidden" value="" /> 
								<input id="pageSizeAS" name="pageSize" type="hidden" value="" />
							<div class="form-group col-6" style="margin-bottom: 0px; float: right;">
								<div class=" input-group input-daterange" id="date-rangeA">
									<div style="display:inline-block;padding-top: 8px;">回复时间范围：&nbsp;&nbsp;</div>
									<input id="timeStartThree" value="<fmt:formatDate value="${wasFeedBackA.beginDateA}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" autocomplete="off" style="text-align: left;" />
									<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
									<input id="timeEndThree" value="<fmt:formatDate value="${wasFeedBackA.endDateA}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" autocomplete="off" style="text-align: left;" />
								</div>
							</div>
						</form>
					</div>
					<table id="contentTable" class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								
								<th class="tableControl">公司名称</th>
								<th class="tableControl">代理商等级</th>
								<th class="tableControl">问题类型</th>
								<th class="tableControl">回复时间</th>
								<th class="tableControl">问题描述</th>
								<th class="tableControl">问题回复</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody>
						
							<c:forEach items="${pageA.list}" var="log">
								<c:if test="${log.replyState == 1}">
								<tr>									 								
									<td class="tableControl">${fn:escapeXml(log.companyName)}</td>
									<td class="tableControl">${fn:escapeXml(log.name)}</td>
									<c:if test="${log.type == 1}">
									<td class="tableControl">公众号</td>
									</c:if>
									<c:if test="${log.type == 2}">
									<td class="tableControl">小程序</td>
									</c:if>
									<c:if test="${log.type == 3}">
									<td class="tableControl">硬件</td>
									</c:if>
									<c:if test="${log.type == 4}">
									<td class="tableControl">售后</td>
									</c:if>
									<c:if test="${log.type == 5}">
									<td class="tableControl">文档</td>
									</c:if>
									<td class="tableControl"><fmt:formatDate value="${log.replyDate}" type="both" /></td>									
									<td class="tableControl trInstall MHover">${fn:escapeXml(log.description)}</td>
									<td class="tableControl trInstall MHover">${fn:escapeXml(log.reply)}</td>
									<td class="tableControl">										
											<shiro:hasPermission name="agentsystem:wasAgentAnswered:look">
											<button type="button" data-toggle="tooltip"
												data-original-title="查看"
												class="btn btn-info btn-circle btn-xs"
												onclick="lookInform('${log.feedbackId}',this);">
												<i class="fa fa-search-plus"></i>
											</button>
											</shiro:hasPermission>
											<shiro:hasPermission name="agentsystem:wasAgentAnswered:delete">
											<button title="删除" type="button" data-toggle="tooltip" data-original-title="删除" class="btn btn-danger btn-circle btn-xs " 
											onclick="deleteAll('${log.feedbackId}');">
												<i class="fa fa-times"></i>
											</button>
											</shiro:hasPermission>
									</td>									 
								</tr>
								</c:if> 
							</c:forEach> 
						</tbody> 
					</table>
					<!-- 分页代码 -->
					<div id="pageATable">
					<c:if test="${pageA.count gt 10}">
						<table:page page="${pageA}"></table:page>
					</c:if>	
					</div>		
				</div>				
			</div>
	</div>	
	<!-- 回复的模态框 -->
	<div class="modal fade" id="modalReply" data-backdrop="static">
		<div class="modal-dialog" style="margin-top: 100px;">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->				
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size:14px">回复</span><button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="reply">
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">公司名称：</label>
							<div class="col-8 controls">
								<input id="companyNameReply" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">代理等级：</label>
							<div class="col-8 controls">
								<input id="nameReply" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">问题类型：</label>
							<div class="col-8 controls">
								<input id="typeReply" autocomplete="off" type="text" name="text" class="form-control height-control" readonly="readonly">	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label">问题描述：</label>
							<div class="col-8 controls">
								<textarea id="descriptionReply"  name="text" class="form-control height-control space" style="height:65px!important" readonly="readonly"></textarea>	
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label"><span style="color: red">*&nbsp;</span>问题回复：</label>
							<div class="col-8 controls" >
								<textarea id="replyReply" name="reply" maxlength="200" class="form-control height-control space" style="height:65px!important;"></textarea>								
							</div>
						</div>
						<input name="feedbackId" value="" id="feedbackIdReply" hidden="hidden">
					</form>
				</div>	
				<!-- 对话框尾 -->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="replySave();">保存</button>
				</div>				
			</div>
		</div>
	</div>
	<!-- 查看的模态框 -->
	<div class="modal fade" id="modal" data-backdrop="static">
		<div class="modal-dialog" style="margin-top: 100px;">
			<!--宽高、定位-->
			<div class="modal-content">
				<!--对话框头-->
				
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span style="font-size:14px">查看</span><button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label label-right">公司名称：</label>
							<label for="example-text-input" class="col-8 col-form-label label-left" id="companyName"></label>						
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label label-right">代理等级：</label>
							<label for="example-text-input" class="col-8 col-form-label label-left" id="name"></label>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label label-right">问题类型：</label>
							<label for="example-text-input" class="col-8 col-form-label label-left" id="type"></label>
						</div>
						<div class="form-group row">						
							<label for="example-text-input" class="col-3 col-form-label label-right">问题描述：</label>							
							<label for="example-text-input" style="word-break: break-word;" class="col-8 col-form-label label-left space" id="description"></label>						
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-3 col-form-label label-right ">问题回复：</label>
							<label for="example-text-input" style="word-break: break-word;" class="col-8 col-form-label label-left space" id="replyImport"></label>
							
						</div>
					</form>
				</div>
							
			</div>
		</div>
	</div>
</div>
	<script type="text/javascript">
	//查看的实现
	function lookInform(feedbackId,obj){
		var index = layer.load(1, {shade: [0.1,'#fff']});		
		$.ajax({
		    url:'${ctx}/agentSystem/wasAgentAnsweredList/look',
		    type:'POST',
		    data:{
		    	feedbackId : feedbackId,
		    },
		    dataType:'json',
		    success:function(result){
		    	layer.close(index);		    	
		    	$("#companyName").text(result.list[0].companyName);		    	
		    	if(result.list[0].name == null){
		    		$("#name").text("--");
		    	}else{
		    		$("#name").text(result.list[0].name);
		    	}
		    	if(result.list[0].type == 1){
		    		$("#type").text("公众号");
		    	}
		    	if(result.list[0].type == 2){
		    		$("#type").text("小程序");
		    	}
		    	if(result.list[0].type == 3){
		    		$("#type").text("硬件");
		    	}
		    	if(result.list[0].type == 4){
		    		$("#type").text("售后");
		    	}
		    	if(result.list[0].type == 4){
		    		$("#type").text("文档");
		    	}
		    	$("#description").text(result.list[0].description);
		    	$("#replyImport").text(result.list[0].reply);
		    	$("#modal").modal("show");
		    	$(obj).blur();
		    },
		    error:function(xhr,textStatus){
		    	layer.close(index);
		    	layer.msg('操作失败！', { icon : 2 });
		    },
		});		
	}
	var menuId = $("#btnId",parent.document).val();
	//删除的实现
	function deleteAll(feedbackId){
		
		layer.confirm("确认删除？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
				function(){	
					var index = layer.load(1, {shade: [0.1,'#fff']});
					$.ajax({
					    url:'${ctx}/agentSystem/wasAgentAnsweredList/delete',
					    type:'POST',
					    data:{
					    	feedbackId:feedbackId,
					    	menuId:menuId,
					    },
					    dataType:'json',
					    success:function(result){
					    	layer.close(index);
					    	var countSum = ${page.count};
					    	var countSize = ${page.pageSize};
					    	if(result > 0){
					    		var last = '${isLastA}';//$("#isLast").val();
				    			if(last == '1'){
				    				var number = Number(countSum)%Number(countSize);
				    				if(number == 1){
				    					$("#pageNoA").val($("#pageNoA").val()-1);
				    					$("#pageSizeA").val($("#pageSizeA").val());
				    					layer.msg("操作成功！",{icon:1,time:1000},function(){
				    						$("#searchFormA").submit();
										});					    				
				    				}else{
				    					layer.msg("操作成功！",{icon:1,time:1000},function(){
				    						$("#searchFormA").submit();
										});	
				    				}			    				
				    			}else{
				    				layer.msg("操作成功！",{icon:1,time:1000},function(){
			    						$("#searchFormA").submit();
									});	
				    			}
					    		/* layer.msg("操作成功！",{icon:1,time:1000},function(){
					    			$("#searchFormA").submit();
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
	//回复的实现
	function reply(feedbackId,obj){
		//去掉无用的值
		$("#replyReply").val("");
		$("#replyReply").removeClass("error");
    	$("#replyReply-error").remove();		
		$("#feedbackIdReply").val(feedbackId);
		var index = layer.load(1, {shade: [0.1,'#fff']});
		$.ajax({
		    url:'${ctx}/agentSystem/wasAgentAnsweredList/lookReply',
		    type:'POST',
		    data:{
		    	feedbackId : feedbackId,
		    },
		    dataType:'json',
		    success:function(result){
		    	layer.close(index);
		    	$("#companyNameReply").val(result.list[0].companyName);		    	
		    	if(result.list[0].name == null){
		    		$("#nameReply").val("--");
		    	}else{
		    		$("#nameReply").val(result.list[0].name);
		    	}	
		    	if(result.list[0].type == 1){
		    		$("#typeReply").val("公众号");
		    	}
		    	if(result.list[0].type == 2){
		    		$("#typeReply").val("小程序");
		    	}
		    	if(result.list[0].type == 3){
		    		$("#typeReply").val("硬件");
		    	}
		    	if(result.list[0].type == 4){
		    		$("#typeReply").val("售后");		    		
		    	}
		    	if(result.list[0].type == 4){
		    		$("#typeReply").val("文档");
		    	}
		    	
		    	$("#descriptionReply").val(result.list[0].description);		    	
		    	$("#modalReply").modal("show");
		    	$(obj).blur();
		    },
		    error:function(xhr,textStatus){
		    	layer.close(index);
		    	layer.msg('操作失败！', { icon : 2 });
		    },
		});		
	}
	//回复保存	
	function replySave(){
		var isValid =  $("#reply").valid();
		if(isValid){
			layer.confirm("确认保存？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']}, 
					function(){
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
				    url:'${ctx}/agentSystem/wasAgentAnsweredList/replySave',
				    type:'POST',
				    data:$("#reply").serialize(),
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
				    	}
				    },
				    error:function(xhr,textStatus){
				    	layer.close(index);
				    	layer.msg('操作失败！', { icon : 2 });
				    },
				});
				
			});
		}
	}
	//cookie记住页面的跳转
	$("document").ready(function(){		
		//$("#pageTable .pagination-outline li").eq(pn+1).addClass("active");		
		var flag = $.cookie("answereFlag");
		if(flag == "1"){
			$("#allAnswere").trigger("click");						
		}	
		$("#hiddenDiv").removeAttr("hidden");		
		//表单验证
		$("#reply").validate({
			rules : {
				reply : {
					required : true,
				},
			},
			messages : {
				reply : {
					required : "请填写回复",
				},				
			},
			errorPlacement : function(error, element) {
				error.insertAfter(element);
				}
			});
	});
	//针对tab切换会出现其他的问题
	function switchover(answereFlag){		
		$.cookie("answereFlag",answereFlag);		
		if(answereFlag == 0){
			$('#notAnswere').addClass("active");
			$('#allAnswere').removeClass("active");
			$('#homeTwo').show();
			$('#profileTwo').hide();
			
		}else{	
			$('#allAnswere').addClass("active");
			$('#notAnswere').removeClass("active");
			$('#profileTwo').show();
			$('#homeTwo').hide();
			
		}				
	}	
	//日期范围选择
	jQuery('#date-range').datepicker({
		toggleActive : true,
		autoclose: true,
		format : "yyyy-mm-dd"
	});
	//日期范围选择
	jQuery('#date-rangeA').datepicker({
		toggleActive : true,
		autoclose: true,
		format : "yyyy-mm-dd"
	});
	var pn = ${page.pageNo};
	var ps = ${page.pageSize};
	var pAn= ${pageA.pageNo};
	var pAs= ${pageA.pageSize};	
	//未回复分页方法
	function page(n,s) {
		$("#pageNo").val(n);		
		$("#pageSize").val(s);
		//pageA
		
		$("#pageNoN").val(pAn);		
		$("#pageSizeS").val(pAs);
		//page
		pn = n;
		ps = s;		
		$("#searchForm").submit();
		$("span.page-size").text(s);
	}	
	//已回复的分页方法
	function pageA(n,s) {		
		$("#pageNoA").val(n);
		$("#pageSizeA").val(s);
		//page		
		$("#pageNoAN").val(pn);		
		$("#pageSizeAS").val(ps);
		//pageA
		pAn =  n;
		pAs =  s;
		$("#searchFormA").submit();
		$("span.page-size").text(s);
	}
	//回车搜索
	$('#keywordOne').bind('keypress', function(event) {
		if (event.keyCode == "13") {
			search();
		}
	});
	$('#keywordOneA').bind('keypress', function(event) {
		if (event.keyCode == "13") {
			searchA();
		}
	});	
	//查询方法
	function search(){//查询，页码清零
		$("#keyword").val($("#keywordOne").val());
		$("#timeStartOne").val($("#timeStart").val());			
		$("#timeEndOne").val($("#timeEnd").val()+' 23:59:59');
		$("#pageNo").val(0);
		$("#searchForm").submit();
	}
	function searchA(){//查询，页码清零
		$("#keywordA").val($("#keywordOneA").val());
		$("#timeStartTwo").val($("#timeStartThree").val());			
		$("#timeEndTwo").val($("#timeEndThree").val()+' 23:59:59');
		$("#pageNoA").val(0);
		$("#searchFormA").submit();
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