
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 开票的开票申请 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
	<style type="text/css">
.error {
	color: red;
}

select.error {
	color: #67757c;
}

#companyName-error {
	margin-left: 0px;
}

#address-error {
	margin-left: 0px;
}
table tbody {
		display: block;
		overflow-y: scroll;
	}
	
	table thead, tbody tr {
		display: table;
		width: 100%;
		table-layout: fixed;
		
	}
	
::-webkit-scrollbar {
	width: 4px !important;
	height : 4px !important;
	background-color: white;
}

::-webkit-scrollbar-track {
	/* -webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, 0.3); */
	border-radius: 10px;
	background-color: white;
}
/*定义滑块 内阴影+圆角*/
::-webkit-scrollbar-thumb {
	border-radius: 10px;
	-webkit-box-shadow: inset 0 0 6px rgba(0, 0, 0, .3);
	background-color: #f4f5f9;
}
.form-control {
    color: rgb(73, 80, 87);
    height: 35px;
    display: initial;
    font-size: 14px;
}
.label-contol{
	white-space:nowrap;
}

</style>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h3 class="box-title" style="font-size:14px">开票申请基本信息设置</h3>
					<hr class="m-t-0 m-b-40">
					<form action="#" method="post" style="width: 100%" id="addForm">
						<div class="form-body">
							<div class="row">
								<div class="col-md-6">
									<div class="form-group row">

										<label class="col-3 col-form-label label-contol"><span style="color: red">*&nbsp;</span>订单编号：</label>
										<input type="hidden" class="form-control" placeholder="订单编号" name="orderNumber" id="orderNumber" value="">
						<div class="col-md-9">
						<c:if test="${fn:length(list)== 0}">
							<input type="text"  class="form-control" name="" placeholder="无可选订单" readonly="readonly">
						</c:if>
						<c:if test="${fn:length(list)!= 0}">
						
						<table class="display nowrap table table-hover table-striped table-bordered">
						<thead>
							<tr>
								<th class="tableControl" width="10%"><input type="checkbox" class="check" id="ischange" data-checkbox="icheckbox_square-blue"></th>
								<th class="tableControl" width="27%">订单编号</th>
								<th class="tableControl" width="20%">金额/元</th>
								<th class="tableControl" width="28%">支付日期</th>
								<th class="tableControl" width="15%">消费行为</th>								
							</tr>
						</thead>					
						<tbody id="orderBody" style="max-height:165px;">
							<c:forEach items="${list}" var="log">
								<tr>
									<td class="tableControl" width="10%"><input type="checkbox" class="check" id="square-checkbox-1" data-checkbox="icheckbox_square-blue"></td>
									<td class="tableControl" width="27%">${log.orderNo}</td>
									<td class="tableControl" width="20%">${log.payMoney}</td>
									<td class="tableControl" width="28%"><fmt:formatDate
											value="${log.createDate}" type="both" /></td>
									<td class="tableControl" width="15%">${fn:escapeXml(log.behavior)}</td>									
								</tr>
							</c:forEach>
						</tbody>
					</table>					
					</c:if>
					</div>										
									</div>
									<div class="form-group row">
										<label class="col-form-label col-md-3"><span
											style="color: red">&nbsp;&nbsp;&nbsp;</span>已选金额：</label>
										<div class="col-md-9">
											<input type="text" id="moneyI" class="form-control" name="money" placeholder="0.00" readonly="readonly">
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>发票内容：</label>
										<div class="col-md-9">

											<div class="editable-input" style="position: relative;" >
												<select class="form-control input-sm" name="body" id="body">
													<option value="" selected>请选择</option>
													<c:forEach items="${listContent}" var="body">
														<option value="${fn:escapeXml(body.details)}">${fn:escapeXml(body.details)}</option>
													</c:forEach>
												</select>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>发票类型：</label>
										<div class="col-md-9">

											<div class="editable-input" style="position: relative;">
												<select class="form-control input-sm" name="invoiceType" id="invoiceType">
													<option value="" selected>请选择</option>													
														<option value="专用发票">专用发票</option>
														<option value="普通发票">普通发票</option>													
												</select>
											</div>
										</div>
									</div>


									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>公司名称：</label>
										<div class="col-md-9">
											<input type="text" maxlength="30" class="form-control" placeholder="" name="companyName" autocomplete="off">
										</div>
									</div>
									
									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>收货人：</label>
										<div class="col-md-9">
											<input type="text" maxlength="10" class="form-control form-control-danger" placeholder="" name="name" autocomplete="off">
										</div>
									</div>

								</div>


								<!--/span-->
								<div class="col-md-6">
									
									<div class="form-group has-danger row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>联系方式：</label>
										<div class="col-md-9">
											<input type="text" maxlength="30" class="form-control form-control-danger" placeholder="" name="phone" autocomplete="off">
										</div>
									</div>
									<div class="form-group has-danger row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>收货地址：</label>
										<div class="col-md-9">
											<input type="text" maxlength="50"
												class="form-control form-control-danger" placeholder="" name="address">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span style="color: red">*&nbsp;</span>纳税人识别号：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" maxlength="30"
												placeholder="" name="dutyParagraph" autocomplete="off">
										</div>
									</div>
									
    								<div id="titleAddress" style="display:none">				
									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span style="color: red">*&nbsp;</span>注册地址：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" placeholder="" maxlength="50"
												name="registerAddress" id="registerAddress" autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span style="color: red">*&nbsp;</span>注册电话：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" placeholder="" maxlength="30"
												name="registerPhone" id="registerPhone" autocomplete="off">
										</div>
									</div>
									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>开户行：</label>
										<div class="col-md-9">
											<input maxlength="30" type="text" class="form-control" id="registerBank" name="registerBank" placeholder="" autocomplete="off">
										</div>
									</div>

									<div class="form-group row">
										<label class="col-form-label col-md-3 label-contol"><span
											style="color: red">*&nbsp;</span>银行账号：</label>
										<div class="col-md-9">
											<input type="text" class="form-control" placeholder="" maxlength="21"
												name="account" id="account" autocomplete="off">
										</div>
									</div>
									<input  id="menuId"  type="hidden" name="menuId" value="">
							
								</div>
								
							</div>
						</div>
						</div>
						<div class="form-group row">
							<label class="control-label text-right col-md-3"></label>
							<div class="col-md-9">							
								<div class="text-xs-right" style="text-align: right;">	
								<shiro:hasPermission name="agentsystem:wasInvoiceApplyFor:save">							
									<button type="button" class="btn waves-effect waves-light btn-info" onclick="save()">保存</button>
								</shiro:hasPermission>
								</div> 
							</div>
						</div>
					</form>
				</div>

			</div>
		</div>
	</div>
	<script type="text/javascript">	
	
	//checkbox监听
	var menuId = $("#menuId").val($("#btnId",parent.document).val());	
	$('#ischange').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
		$('.check').iCheck('check');
	});
	$('#ischange').on('ifUnchecked', function(event){ //ifUnchecked 事件应该在插件初始化之前绑定 
		$('.check').iCheck('uncheck');
	});
	//监听改变事件
	$('.check').on('ifChecked', function(event){ //ifCreated 事件应该在插件初始化之前绑定 
	    var money = $(this).parent().parent().parent().children(":eq(2)").text();
		addSum(money,"+");		
	});
	$('.check').on('ifUnchecked', function(event){ //ifUnchecked 事件应该在插件初始化之前绑定 
		var money = $(this).parent().parent().parent().children(":eq(2)").text();		
		addSum(money,"-");
	});
	var sum = 0.00;
	function addSum(money,flag){
		if(money != "金额/元"){
			var moneyI = parseFloat(money); //parseInt(money);
			var moneyF = moneyI.toFixed(2);
			if(flag == "+"){
				sum = sum + moneyI;
				
			}else{
				sum= sum - money;
			}
			
		}		
		if(sum <= 0){			
			sum=0.00;
		} 
		$("#moneyI").val(sum.toFixed(2));
		
	}
	//下拉选 
	$("#invoiceType").change(function(){
		if($(this).val()=="专用发票"){
			$("#titleAddress").css("display","block");
		}else{
			$("#titleAddress").css("display","none");
			$("#registerAddress").val("");
			$("#registerPhone").val("");
			$("#registerBank").val("");
			$("#account").val("");
		}
    });
	
	//表单的验证
	$(function(){
		
		$("#addForm").validate({
			rules : {
				body:{
					required : true,
				},
				invoiceType:{
					required : true,
				},
				companyName:{
					required : true,								
				},
				name:{
					required : true,
					minlength : 2,
				},
				phone:{
					required : true,					
					isPhone : true,
				},
				address:{
					required : true,					
				},
				dutyParagraph:{
					required : true,
					isnumber : true,
					isduty:true,
				},	
				registerAddress:{
					required : true,					
				},
				registerPhone:{
					required : true,					
					Phone : true,
				},
				registerBank:{
					required : true,			
				},
				account:{
					required : true,
					minlength :9,
					creditcard:true,
				},		
			},
			messages : {
				body:{
					required : "请选择开票内容",
				},
				invoiceType:{
					required : "请选择发票类型",
				},
				companyName:{
					required : "请输入公司名称",
				},
				name:{
					required : "请输入收货人名称",
					minlength : "姓名不能少于两个字符",
				},
				phone:{
					required : "请输入联系方式",					
				},
				address:{
					required : "请输入发票的收货地址",
				},
				dutyParagraph:{
					required : "请输入纳税人识别号",
				},	
				registerAddress:{
					required : "请输入注册地址",
					
				},
				registerPhone:{
					required : "请输入注册电话",
				},
				registerBank:{
					required : "请输入开户行",
				},
				account:{
					required : "请输入银行账号",
					minlength : "最少输入9个字符",
					creditcard: "请输入合法的银行账号", 
				},		
			},
			errorPlacement : function(error, element) {
				error.insertAfter(element);
				}
			});
		jQuery.validator.addMethod("isduty", function(value,element) {			
			  var taxpayerId = value;
			   //纳税人识别号校验是否合法 
			   if($.trim(taxpayerId) == ''){
			    //alert("请输入纳税人识别号 ！");
			    return false;
			   }else if($.trim(taxpayerId) != ''){
			     var addressCode = taxpayerId.substring(0,6);
			     // 校验地址码
			     var check = checkAddressCode(addressCode);
			     if(!check) {
			      //alert("请输入正确的纳税人识别号 (地址码)！");
			      return false;
			     }else{
			      // 校验组织机构代码 
			      var orgCode = taxpayerId.substring(6,9);
			      check = orgcodevalidate(orgCode);
			      if(!check){
			       //alert("请输入正确的纳税人识别号(组织机构代码) ！");
			       return false;
			         }else{
			        	return true; 
			         }
			     }
			   }
			// 校验组织机构代码 
			   function orgcodevalidate(value){
			     if(value!=""){ 
			      var part1=value.substring(0,8);
			      var part2=value.substring(value.length-1,1);
			      var ws = [3, 7, 9, 10, 5, 8, 4, 2]; 
			      var str = '0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ'; 
			      var reg = /^([0-9A-Z]){8}$/; 
			      if (!reg.test(part1)) 
			      { 
			       return true
			      } 
			      var sum = 0; 
			      for (var i = 0; i< 8; i++) 
			      { 
			       sum += str.indexOf(part1.charAt(i)) * ws[i]; 
			      } 
			      var C9 = 11 - (sum % 11); 
			      var YC9=part2+'';
			      if (C9 == 11) {
			       C9 = '0'; 
			      } else if (C9 == 10) { 
			       C9 = 'X' ; 
			      } else {
			       C9 = C9+''; 
			      } 
			      return YC9!=C9; 
			    } 
			   }			   
			   // 校验地址码
			   function checkAddressCode(addressCode){
			       var provinceAndCitys={11:"北京",12:"天津",13:"河北",14:"山西",15:"内蒙古",21:"辽宁",22:"吉林",23:"黑龙江",
			        31:"上海",32:"江苏",33:"浙江",34:"安徽",35:"福建",36:"江西",37:"山东",41:"河南",42:"湖北",43:"湖南",44:"广东",
			        45:"广西",46:"海南",50:"重庆",51:"四川",52:"贵州",53:"云南",54:"西藏",61:"陕西",62:"甘肃",63:"青海",64:"宁夏",
			        65:"新疆",71:"台湾",81:"香港",82:"澳门",91:"国外"};
			       var check = /^[1-9]\d{5}$/.test(addressCode);
			       if(!check) return false;
			       if(provinceAndCitys[parseInt(addressCode.substring(0,2))]){
			         return true;
			       }else{
			         return false;
			       }			       
			   }			
		},"请输入正确的纳税人识别号");				
		jQuery.validator.addMethod("isPhone", function (value, element) {  
		    var isphone =  /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9}))$/;   
		    return this.optional(element) || (isphone.test(element.value));  
		    }, $.validator.format("请输入正确的联系方式"));				
		jQuery.validator.addMethod("isnumber", function(value, element) {
            var rightPasswordForm = /^[a-zA-Z0-9]{0,30}$/;
            return (rightPasswordForm.test(value));
        }, "请输入正确的纳税人识别号");
		jQuery.validator.addMethod("Phone", function (value, element) {  
		    var isphone =  /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9}))$/;   
		    return this.optional(element) || (isphone.test(element.value));  
		    }, $.validator.format("请输入正确的注册电话"));
		/* jQuery.validator.addMethod("phone", function(value, element) {
			var tel = /^(0[0-9]{2,3}-)?([2-9][0-9]{6,7})+(-[0-9]{1,4})?$/;
			return this.optional(element) || (tel.test(value));
			}, "注册电话号码格式错误"); */
	})
	//保存提交
	function save(){	
		//订单的值
		var str= "";		
		var orderLength= new Array(); //定义数组 		
		 $("#orderBody tr td .checked").each(function(){			 
			 var order = $(this).parent().next().text();			 			 
			 str += order + ",";
		}); 
		orderLength=str.split(","); //字符分割 		
		if(orderLength.length-1 == 0){
			layer.confirm("请至少选择一个订单信息!", {
				closeBtn: 0, 
				icon : 3 ,
				skin : 'layui-layer-molv',
				btn: ['确认','取消']});			
			return;
		}else{
			$("#orderNumber").val(str);
		}		
		var isValid = $("#addForm").valid();				
		if(isValid){
			
			layer.confirm("确认保存吗？", {closeBtn: 0, icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},
			function(){
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					type : "POST",
					dataType : "json",
					url : "${ctx}/agentSystem/wasInvoiceApplyFor/save",
					data : $('#addForm').serialize(),
					success : function(result) {
						layer.close(index);
						if(result>0){
							layer.msg("操作成功！",{icon:1,time:1000},function(){
								location.href="${ctx}/agentSystem/wasInvoiceApplyForIn/list";
								var btn = window.parent.document.getElementById("9c8131748f484315b8eaa2f37d118e6e")
								btn.click()
				    			//$("#addForm").submit();//模拟提交（发货状态为1）
							});	
						}
					},			
					error : function(xhr, textStatus) {
						layer.close(index);
							layer.msg('操作失败！', {
								icon : 2
							});
						},
						
					});
				
			});
			}
		}
	</script>
</body>
</html>