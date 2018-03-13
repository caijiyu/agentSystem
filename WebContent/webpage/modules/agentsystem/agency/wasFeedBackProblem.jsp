<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 问题反馈页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style>
	input.error{
		color:#67757c
	}
	#feedBackErea-error{
    margin-left: -15px;
    line-height: 35px;
    overflow:hidden;
    margin-bottom:0px;
	}
	#phone-error{
	margin-left: 75px;
	line-height: 35px;
    overflow:hidden;
    margin-bottom:0px;
	}
	
</style>
</head>
<body>
	<div class="divControl" hidden="hidden" id="hiddenDiv">
		<div class="card cardControl">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs customtab" role="tablist">
				<li class="nav-item"><a class="nav-link active" id="problemAct"
					href="#" onclick="switchover(0)">
						<span class="hidden-sm-up"><i class="ti-home"></i></span> <span
						class="hidden-xs-down">问题提交</span>
				</a></li>
				<li class="nav-item"><a class="nav-link" id="feedAct"
					href="#" onclick="switchover(1)"> <span
						class="hidden-sm-up"><i class="ti-user"></i></span> <span
						class="hidden-xs-down">我的反馈</span>
				</a></li>

			</ul>
			<!-- 问题提交 -->
			<div class="tab-content">
				<div class="tab-pane p-20 active" id="present" role="tabpanel">
					<div class="tab-pane p-20 active" id="home" role="tabpanel" aria-expanded="true">
						<form method="post" id="feedbackForm">
							<div class="form-group">
								<div class="row" style="margin-bottom: 15px;">
									<div class="col-md-6 row">
										<label for="recipient-name" class="control-label" style="width:10% !important;;line-height: 35px;overflow:hidden;margin-bottom:0px;white-space:pre-wrap;text-align: left;">问题类型：</label>
											<select class="custom-select height-control" name="type" style="width:90% !important;">
												<option value="1">公众号</option>
												<option value="2">小程序</option>
												<option value="3">硬件</option>
												<option value="4">售后</option>
												<option value="5">文档</option>
											</select>
									</div>
									<input name="quizBy" type="hidden" value="${quizBy }" />
									<input type="text" style="display:none" /> 
									<div class="col-md-6 row" style="margin-left: 43px;">
										<label for="recipient-name" class="control-label" style="width:10% !important;line-height: 35px;overflow:hidden;margin-bottom:0px;white-space:pre-wrap;text-align: left;">联系方式：</label> 
										<input type="text" name="phone" class="form-control height-control" placeholder="请输入联系电话" style="width:90% !important;">
									</div>
								</div>
								<div class="row">
									<textarea class="form-control valid" maxlength="200" rows="15" placeholder="请输入问题描述……" id="feedBackErea"
									spellcheck="false" name="description"	style="width: 100%;word-break: break-all;"></textarea>
								</div>
								<div class="dataTables_wrapper">
									<div class="dataTables_paginate ">
									<shiro:hasPermission name="agency:wasFeedBackProblem:submit">
										<button type="button"style="margin-right: -15px;height: 35px;" class="btn btn-info" onclick="submitSave()">提交</button>
									</shiro:hasPermission>	
									</div>
								</div>
							</div>
						</form>
					</div>
				</div>
				<!-- 我的反馈 -->
				<div class="tab-pane p-20" id="retroaction" role="tabpanel">
					<div class="row col-9" style="float: right;">
							<form action="${ctx}/agentSystem/FeedBack/list" method="post" style="width: 100%" id="searchForm">
								 <button type="button" class="btn waves-effect waves-light btn-info" onclick="feedBackSearch()" style="float: right;margin-left: 15px;height:35px;">搜索</button>
								<input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" /> 
								<input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
								
								<input id="startTime" name="beginDate" type="hidden" value="<fmt:formatDate value="${wasFeedBack.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								<input id="endTime" name="endDate" type="hidden" value="<fmt:formatDate value="${wasFeedBack.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
								
								<div class="form-group col-6" style="margin-bottom: 0px; float: right;padding-left:0px;padding-right:0px;">
									<div class=" input-group input-daterange" id="date-range">
										<div style="display:inline-block;padding-top:8px;">反馈时间范围：&nbsp;&nbsp;</div>
										<input value="<fmt:formatDate value="${wasFeedBack.beginDate}" pattern="yyyy-MM-dd"/>" autocomplete="off"
										type="text" class="form-control height-control rightAngle" placeholder="开始时间" id="beginDate"
										style="text-align: left;" /> 
										<span class="input-group-addon bg-info b-0 text-white height-control addCentreControl">至</span>
										<input value="<fmt:formatDate value="${wasFeedBack.endDate}" pattern="yyyy-MM-dd"/>"autocomplete="off"
										type="text" class="form-control height-control" placeholder="结束时间" id="endDate"
										style="text-align: left;" />
									</div>
								</div>
							</form> 
						</div>
						
					<table class="display nowrap table table-hover table-striped table-bordered" style="font-size: 13px;">
						<thead>

							<tr>
								<th class="tableControl">问题类型</th>
								<th class="tableControl">反馈时间</th>
								<th class="tableControl">问题描述</th>
								<th class="tableControl">问题回复</th>
								<th class="tableControl">操作</th>
							</tr>
						</thead>
						<tbody id="feedBackBody">
						<c:forEach items="${page.list}" var="feedBack">
							<tr>
								<td  class="tableControl">
								<c:if test="${feedBack.type eq 1 }">
								   公众号
								</c:if>
								<c:if test="${feedBack.type eq 2 }">
								   小程序
								</c:if>
								<c:if test="${feedBack.type eq 3 }">
								   硬件
								</c:if>
								<c:if test="${feedBack.type eq 4 }">
								   售后
								</c:if>
								<c:if test="${feedBack.type eq 5 }">
								  文档
								</c:if><!-- style="white-space: pre-wrap;" -->
								</td>
								<td class="tableControl"><fmt:formatDate value="${feedBack.quizDate}" type="BOTH"/></td>
								<td class="tableControl" style="max-width:300px;min-width:200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;">${fn:escapeXml(feedBack.description)}</td>
								<td class="tableControl" style="max-width:300px;min-width:200px;overflow: hidden;white-space: nowrap;text-overflow: ellipsis;"><c:choose><c:when test="${feedBack.reply ne null}">${fn:escapeXml(feedBack.reply)}</c:when><c:otherwise>尚未回复</c:otherwise></c:choose></td>
								<td class="tableControl">
									<shiro:hasPermission name="agency:wasFeedBackProblem:look">
										<button type="button" data-toggle="tooltip" onclick="feedBackLook('${feedBack.feedbackId}',this)" data-original-title="查看" class="btn btn-info btn-circle btn-xs">
											<i class="fa fa-search-plus"></i>
										</button>
									</shiro:hasPermission>
								</td>
							</tr>
							</c:forEach> 
						</tbody>

					</table>
					<c:if test="${page.count gt 10}">
						<!-- 分页代码 -->
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
				<div class="modal-header" style="background-color: #f4f5f9;">
					<h5 class="modal-title">查看</h5>
					<button type="button" class="close" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">×</span>
					</button>
				</div>
				<!--主体部分-->
				<div class="modal-body" id="feedModal">
						<form style="font-size: 14px;">
							<div class="form-group row">
								<label  class="col-3 col-form-label" style="text-align: right;">问题类型：</label>
								
								<div class="col-9 divMiddle">
									<p style="white-space:pre-wrap;" class="divFont"></p>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-3 col-form-label" style="text-align: right;">问题时间：</label>
								<div class="col-9 divMiddle">
									<p style="white-space:pre-wrap;" class="divFont"></p>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-3 col-form-label" style="text-align: right;">问题描述：</label>
								<div class="col-9 divMiddle">
									<p style="word-break: break-word;white-space:pre-wrap;word-wrap:break-word;" class="divFont"></p>
								</div>
							</div>
							<div class="form-group row">
								<label class="col-3 col-form-label" style="text-align: right;">问题回复：</label>
								<div class="col-9 divMiddle">
									<p style="word-break: break-word;white-space:pre-wrap;word-wrap:break-word;" class="divFont"></p>
								</div>
							</div>
						</form>
					</div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
	
	$("document").ready(function (){
		
		//判断处在哪个tab
		var feedFlag = $.cookie("feedFlag");
		if (feedFlag == 0) {

		} else if (feedFlag == 1) {
			document.getElementById("feedAct").click();
		} 
		$("#hiddenDiv").removeAttr("hidden");
		//表单验证
		$("#feedbackForm").validate({
			rules : {
				phone : {isphone:true},
				description : {required : true,maxlength:200}
				
			},
			messages : {
				
				description : {required : "请输入问题描述",maxlength:"地址最多为200个字符"}
				
			},
			errorPlacement : function(error, element) {
				if("description"==$(element).attr("name")){
					error.insertAfter(element.parent());
				}else{
					error.insertAfter(element);
				}
			}
		});	
		
		jQuery.validator.addMethod("isphone", function (value, element) {  
		    var isphone =  /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9}))$/;  
		    return this.optional(element) || (isphone.test(value));  
		}, $.validator.format(" 请输入正确的电话号码"));
	});
	
		//弹框显示
		function show() {
			$("#modal").modal("show");
		}
		//查询方法
		function feedBackSearch() {//查询，页码清零
		$("#pageNo").val(0);
		$("#startTime").val($("#beginDate").val());
		$("#endTime").val($("#endDate").val()+" 23:59:59");
			$("#searchForm").submit();
		}
		//分页方法
		function page(n, s) {
			$("#pageNo").val(n);
			$("#pageSize").val(s);
			$("#searchForm").submit();
			$("span.page-size").text(s);
		}
		
		//日期范围选择
		jQuery('#date-range').datepicker({
			toggleActive : true,
			autoclose : true,
			format : "yyyy-mm-dd"
		});
		
		//针对tab切换会出现其他的问题
		function switchover(feedFlag) {
			$.cookie("feedFlag", feedFlag);
			if (feedFlag == 0) {
				$("#problemAct").addClass("active");
				$("#feedAct").removeClass("active");
				$('#present').show();
				$('#retroaction').hide();
			} else if (feedFlag == 1) {
				$("#problemAct").removeClass("active");
				$("#feedAct").addClass("active");
				$('#present').hide();
				$('#retroaction').show();
			}
			
			
			
		}
		
		//提交保存
		function submitSave(){
        	if($("#feedbackForm").valid()){
    			layer.confirm("确认提交吗？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},
    					function(){
    						$.ajax({
    							url : "${ctx}/agentSystem/FeedBack/insertFeedBack",
    							type : "POST",
    							dataType : "JSON",
    							async : false,
    							data : $('#feedbackForm').serialize(),
    							success : function(data) {
    								if(data==1){
    									layer.msg("提交成功！",{icon:1,time:1000});
    									document.getElementById("feedbackForm").reset();
    									location.reload(true);
    								}
    								
    								},error : function(e){
    									layer.msg('提交失败！', { icon : 2 });
    								}
    						});
    					});
    			}
        	}
			//查看
			function feedBackLook(feedbackId,obj){
				$(obj).blur();
				$.ajax({
					url : "${ctx}/agentSystem/FeedBack/feedBackLook",
					type : "POST",
					dataType : "JSON",
					async : false,
					data : {"feedbackId":feedbackId},
					success : function(data) {
						
						switch(data.type){
			            case 1:
			            	$("#feedModal p:eq(0)").text("公众号");
			            break;
			            case 2:
			            	$("#feedModal p:eq(0)").text("小程序");
			            break;
			            case 3:
			            	$("#feedModal p:eq(0)").text("硬件");
			            break;
			            case 4:
			            	$("#feedModal p:eq(0)").text("售后");
			            break;
			            case 5:
			            	$("#feedModal p:eq(0)").text("文档");
				        break;
			            
			        }
						$("#feedModal p:eq(1)").text(data.quizDate);
						$("#feedModal p:eq(2)").text(data.description);
						if(data.reply != null){
							$("#feedModal p:eq(3)").text(data.reply);
						}else{
							$("#feedModal p:eq(3)").text("尚未回复");
						}
						
						show();
					}
				});
			}
		
		
	</script>
</body>
</html>