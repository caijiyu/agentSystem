
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 代理商下单页面 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
</head>
<body>
	<div class="divControl">
		<div class="card cardControl">
			<!-- Nav tabs -->
			<ul class="nav nav-tabs customtab" role="tablist">
				<li class="nav-item">
					<a class="nav-link active" data-toggle="tab" href="#home" role="tab" onclick="switchover(0)"> 
						<span class="hidden-sm-up"><i class="ti-home"></i></span> 
						<span class="hidden-xs-down">软件下单</span>
					</a>
				</li>
				<li class="nav-item">
					<a class="nav-link" data-toggle="tab" href="#profile" role="tab" onclick="switchover(1)"> 
						<span class="hidden-sm-up"><i class="ti-user"></i></span> 
						<span class="hidden-xs-down">硬件下单</span>
					</a>
				</li>
			</ul>
			<!-- Tab panes -->
			<div class="tab-content">
				<!-- 当前代理商四个账户余额 -->
				<input id="publicAccount" name="publicAccount" type="hidden" value="${agent.publicAccount}">
				<input id="minaAccount" name="minaAccount" type="hidden" value="${agent.minaAccount}">
				<input id="hardwareAccount" name="hardwareAccount" type="hidden" value="${agent.hardwareAccount}">
				<input id="vipAccount" name="vipAccount" type="hidden" value="${agent.vipAccount}">
				<!-- 软件下单 -->
				<div class="tab-pane p-20 active" id="home" role="tabpanel">
					<form class="form" id="bugPolicy">
						<input id="agentLevelId" type="hidden" value="${agent.agentLevelId}">
						<input name="parentId" type="hidden" value="${agent.id}"><!-- 当前代理商ID -->
						<input name="companyParentId" type="hidden" value="${agent.companyParentId}"><!-- 当前代理商上级ID -->
						<input id="listPolicy" name="listPolicy" type="hidden">
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">当前代理商：</label>
							<div class="col-9 controls">
								<input autocomplete="off" type="text" name="text" class="form-control height-control"  readonly value="${fn:escapeXml(agent.companyName)}">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">所属上级：</label>
							<div class="col-9 controls">
								<input autocomplete="off" type="text" name="companyParent" class="form-control height-control" readonly value="${fn:escapeXml(agent.companyParent.companyName)}">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">套餐折扣：</label>
							<div class="col-9 controls input-group">
								<input autocomplete="off" type="text" class="form-control height-control rightAngle" readonly value="<fmt:formatNumber type="number" value="${agent.packageDiscount * 10}" pattern="0.00" maxFractionDigits="1"/>"> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">折</span>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">公众号折扣：</label>
							<div class="col-9 controls input-group">
								<input autocomplete="off" type="text" class="form-control height-control rightAngle" readonly value="<fmt:formatNumber type="number" value="${agent.publicDiscount * 10}" pattern="0.00" maxFractionDigits="1"/>"> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">折</span>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">小程序折扣：</label>
							<div class="col-9 controls input-group">
								<input autocomplete="off" type="text" class="form-control height-control rightAngle" readonly value="<fmt:formatNumber type="number" value="${agent.minaDiscount * 10}" pattern="0.00" maxFractionDigits="1"/> "> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">折</span>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;公司名称：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="companyName" id="companyName" autocomplete="off" type="text" class="form-control height-control" maxlength="30">
                            	</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;负责人：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="name" autocomplete="off" type="text" class="form-control height-control" maxlength="10">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;联系方式：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="phone" autocomplete="off" type="text" class="form-control height-control" maxlength="15">
                            	</div>
							</div>
						</div>
						<div class="form-group row ">
							<label class="col-2 col-form-label"><span
								style="color: red; height: 27px">*</span>&nbsp;地区：</label>
							<div data-toggle="distpicker" class="col-md-9 area">
								<div class="row" style="height: 35px">
									<div class="col-md-4 ">
										<div class="form-group row">
											<div class="col-sm-12 col-xs-12">
												<div>
													<select class="form-control height-control" id="province" name="province"></select>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-sm-12 col-xs-12">
												<div>
													<select class="form-control height-control" id="city" name="city"></select>
												</div>
											</div>
										</div>
									</div>
									<div class="col-md-4">
										<div class="form-group row">
											<div class="col-sm-12 col-xs-12">
												<div>
													<select class="form-control height-control" id="county" name="county"></select>
												</div>
											</div>
										</div>
									</div>
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;详细地址：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="address" autocomplete="off" type="text" class="form-control height-control" maxlength="50">
                            	</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;账号：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="loginName" id="loginName" autocomplete="off" type="text" class="form-control height-control" maxlength="15">
                            	</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;密码：</label>
							<div class="col-9 controls">
								<div>
                            		<input name="password" autocomplete="off" type="text" class="form-control height-control" maxlength="20">
                            	</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;选择产品：</label>
							<div class="col-9 controls" id="policy">
                                <div class="input-group policyOrder" id="policyOrder0">
                                    <span class="input-group-addon height-control rightAngle ">版本</span>
                                    <div>
                                    	<div>
	                                        <select onchange="getPolicyPrice(0)" class="form-control custom-select height-control leftAngle rightAngle" tabindex="1"
	                                            id="selectPolicy0" name="selectPolicy" style="width:100%">
	                                            <option value="">请选择</option>
	                                        </select>
                                    	</div>
                                    </div>
                                        <input type="hidden" id="classify0" name="classify">
                                        <span class="input-group-addon height-control leftAngle rightAngle">数量</span>
                                        <div>
                                        	<div>
                                        		<input id="policyNumber0" name="policyNumber" type="text" style="width:100%" class="form-control height-control leftAngle rightAngle"  onkeyup="countPolicy(0)" maxlength="2">
                                        	</div>
                                        </div>
                                        <span class="input-group-addon height-control leftAngle rightAngle">折扣单价</span>
                                        <input id="policyPrice0" type="text" class="form-control height-control leftAngle rightAngle" readonly>
                                        <input type="hidden" id="year0" name="year">
                                        <input type="hidden" id="totalYear0" name="totalYear">
                                        <input type="hidden" id="singlePrice0" name="singlePrice">
                                        <input type="hidden" id="money0" name="money">
                                        <span class="input-group-addon height-control leftAngle rightAngle">折扣总价</span>
	                					<input id="policyTotal0" name="policyTotal" type="text" class="form-control height-control leftAngle rightAngle" readonly>
	                					<a href="javascript:;" onclick="deletePolicy(0)" class="input-group-addon height-control leftAngle"><i class="fa fa-times-circle"> </i></a>
                                   </div>
							</div>
						</div>
						<div class="form-group row">
						<label for="example-text-input" class="col-2 col-form-label"></label>
							<div class="col-9 controls">
							<a href="javascript:;" onclick="addPolicyOrder()" style="color:#495057"><i class="fa fa-plus-circle"></i> 添加产品</a>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">软件总价：</label>
							<div class="col-9 controls input-group">
								<input id="allPolicyPrice" autocomplete="off" type="text" class="form-control height-control rightAngle" readonly> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;扣款方式：</label>
							<div class="col-9 controls">
								<div class="input-group">
									<input   type="text" id="debitwayPolicy" name="debitway" class="form-control singleGraph height-control rightAngle" value=""  readonly />
									<span class="input-group-btn " >
										<button class="btn waves-effect waves-light btn-info height-control leftAngle" onclick="show(0,this)" type="button" style=" height: 36px;font-size: 12px;">扣款方式</button>
									</span>
								</div>
								<span class="help-block"></span>
							</div>
							<input id="publicExpendPolicy" name="publicExpend" type="hidden">
							<input id="minaExpendPolicy" name="minaExpend" type="hidden">
							<input id="hardwareExpendPolicy" name="hardwareExpend" type="hidden">
							<input id="vipExpendPolicy" name="vipExpend" type="hidden">
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;备注：</label>
							<div class="col-9 controls " >
								<div>
                            		<textarea style="word-break: break-all;" spellcheck="false" name="remarks" class="form-control height-control" maxlength="100"></textarea>
                            	</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-2 col-form-label"></label>
							<div class="col-9">
								<div class="text-xs-right" style="text-align: right;">
									<button type="button" class="btn btn-default" onclick="jump()">返回</button>
									<button type="button" class="btn waves-effect waves-light btn-info" onclick="savePolicy(0)">保存</button>
								</div>
							</div>
						</div>

					</form>	
				</div>
				
				<!-- 硬件下单 -->
				<div class="tab-pane p-20" id="profile" role="tabpanel">
					<form class="form" id="buyHardware">
						<input id="agentId" name="id" type="hidden" value="${agent.id}">
						<input id="listHardware" name="listHardware" type="hidden">
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">当前代理商：</label>
							<div class="col-9 controls">
								<input autocomplete="off" type="text" name="text" class="form-control height-control"  readonly value="${fn:escapeXml(agent.companyName)}">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">所属上级：</label>
							<div class="col-9 controls">
								<input autocomplete="off" type="text" name="companyParent" class="form-control height-control" readonly value="${fn:escapeXml(agent.companyParent.companyName)}">
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;硬件选择：</label>
							<div class="col-9 controls" id="hardware">
                                <div class="input-group hardwareOrder" id="hardwareOrder0" >
                                    <span class="input-group-addon height-control rightAngle ">硬件产品</span>
                                    <div>
                                    	<div>
                                    		<select onchange="getHardwarePrice(0)" class="form-control custom-select height-control leftAngle rightAngle" style="width:100%"
                                              tabindex="1" id="selectHardware0" name="selectHardware">
                                           		<option value="">请选择</option>
                                        	</select>
                                        </div>
                                    </div>
                                        <span class="input-group-addon height-control leftAngle rightAngle">数量</span>
                                        <div>
                                        	<div>
                                        		<input id="hardwareNumber0" name="hardwareNumber" type="text" style="width:100%" class="form-control height-control leftAngle rightAngle" onkeyup="countHardware(0)" maxlength="6">
                                        	</div>
                                        </div>
                                         <span class="input-group-addon height-control leftAngle rightAngle">单价</span>
                                        <input id="hardwarePrice0" type="text" class="form-control height-control leftAngle rightAngle" readonly>
                                        <span class="input-group-addon height-control leftAngle rightAngle">总价</span>
                                        <input id="hardwareTotal0" type="text" name="hardwareTotal" class="form-control height-control leftAngle rightAngle " readonly >
                                        <a href="javascript:;" onclick="deleteHardware(0)" class="input-group-addon height-control leftAngle"><i class="fa fa-times-circle"> </i></a>  
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"></label>
							<div class="col-9 controls input-group">
								<a href="javascript:;" onclick="addHardwareOrder()" style="color:#495057"><i class="fa fa-plus-circle"></i> 添加硬件</a>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label">硬件总价：</label>
							<div class="col-9 controls input-group">
								<input id="allHardwarePrice" autocomplete="off" type="text" class="form-control height-control rightAngle" readonly > 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;扣款方式：</label>
							<div class="col-9 controls">
								<div class="input-group">
									<input type="text" id="debitwayHardware" name="debitway" class="form-control singleGraph height-control rightAngle" value=""  readonly />
									<span class="input-group-btn " >
										<button class="btn waves-effect waves-light btn-info height-control leftAngle" onclick="show(1)" type="button" style=" height: 36px;font-size: 12px;">扣款方式</button>
									</span>
								</div>
								<span class="help-block"></span>
							</div>
							<input id="publicExpendHardware" name="publicExpend" type="hidden">
							<input id="minaExpendHardware" name="minaExpend" type="hidden">
							<input id="hardwareExpendHardware" name="hardwareExpend" type="hidden">
							<input id="vipExpendHardware" name="vipExpend" type="hidden">
						</div>
						<div class="form-group row">
							<label for="example-month-input" class="col-2 col-form-label">收货方式：</label>
							<div class="col-9 controls">
								<input type="hidden" id="deliveryMethod" name="deliveryMethod">
                                <input type="radio" class="check" id="square-radio-one" name="square-radio" data-radio="iradio_square-blue" value="0">
                                <label for="square-radio-1">自提</label>
                                <input type="radio" class="check" id="square-radio-two" name="square-radio" data-radio="iradio_square-blue" checked="checked" value="1">
                                <label for="square-radio-2">快递</label>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;收货人：</label>
							<div class="col-9 controls ">
								<div>
                            		<input autocomplete="off" type="text" name="name" id="consignee" class="form-control height-control" required data-validation-required-message="这是必填项" maxlength="10">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;联系电话：</label>
							<div class="col-9 controls">
								<div>
                            		<input autocomplete="off" type="text" name="phone" id="contactNumber" class="form-control height-control" required data-validation-required-message="这是必填项" maxlength="15">
								</div>
							</div>
						</div>
						<div class="form-group row" id="select">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;收货地址：</label>
							<div class="col-9 controls">
								<div>
                            		<input autocomplete="off" type="text" name="address" id="receivingAddress" class="form-control height-control" required data-validation-required-message="这是必填项" maxlength="50">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label for="example-text-input" class="col-2 col-form-label"><span
								style="color: red">*</span>&nbsp;备注：</label>
							<div class="col-9 controls">
								<div>
                            		<input autocomplete="off" type="text" name="remarks" id="hardwareRemarks" class="form-control height-control" required data-validation-required-message="这是必填项" maxlength="100">
								</div>
							</div>
						</div>
						<div class="form-group row">
							<label class="col-2 col-form-label"></label>
							<div class="col-9">
								<div class="text-xs-right" style="text-align: right;">
									<button type="button" class="btn btn-default" onclick="jump()">返回</button>
									<button type="button" class="btn waves-effect waves-light btn-info" onclick="saveHardware(1)">保存</button>
								</div>
							</div>
						</div>

					</form>				
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
				<div class="modal-header"
					style="float: right; display: block; background-color: #f4f5f9; border-top-left-radius: 5px; border-top-right-radius: 5px;">
					<span id="modal-header-title">扣款方式</span>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<!--主体部分-->
				<div class="modal-body">
					<form id="debitwayForm">
						<input id="difference" name="difference" type="hidden">
						<div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label">公司名称：</label>
                        <div class="col-7">
                            <input type="text" class="form-control" id="agentName"  value="${agent.companyName}" readonly>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label">硬件账户扣款：</label>
                        <div class="col-7">
                        <div>
                            <div class="input-group">
                                <input autocomplete="off" type="text" class="form-control height-control rightAngle ExpendA" id="hardwarerow" name="hardwarerow" maxlength="9"> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
                            </div>
                            <span class="height-control">硬件账户余额为：${agent.hardwareAccount}元</span>
                        </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label">公众号账户扣款：</label>
                        <div class="col-7">
                        	<div>
	                            <div class="input-group">
	                                <input autocomplete="off" type="text" class="form-control height-control rightAngle ExpendA" id="publicrow" name="publicrow" maxlength="9"> 
									<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
	                            </div>
	                            <span class="height-control">公众号账户余额为：${agent.publicAccount}元</span>
                        </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label" >小程序账户扣款：</label>
                        <div class="col-7">
                        	<div>
                            <div class="input-group">
                                <input autocomplete="off" type="text" class="form-control height-control rightAngle ExpendA" id="minarow" name="minarow" maxlength="9"> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
                            </div>
                            <span class="height-control">小程序账户余额为：${agent.minaAccount}元</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
                        <label for="recipient" class="col-4 col-form-label">VIP账户扣款：</label>
                        <div class="col-7">
                       	  <div>
                            <div class="input-group">
                                <input autocomplete="off" type="text" class="form-control height-control rightAngle ExpendA" id="viprow" name="viprow" maxlength="9"> 
								<span class="input-group-addon height-control leftAngle" id="basic-addon1">元</span>
                            </div>
                            <span class="height-control">VIP账户余额为：${agent.vipAccount}元</span>
                            </div>
                        </div>
                    </div>
                    <div class="form-group row">
	                	<div class="col-11" >
	                		<div style="float: right;font-size:13px" >总价格：<span id="totalAccountMoney">0</span>元</div>
	                	</div>
	                </div>
					</form>
				</div>
				<!--对话框尾-->
				<div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
					<button type="button" class="btn btn-info" onclick="saveDebitway()">保存</button>
				</div>
			</div>
		</div>
	</div>
	<div class="modal fade" id="ModalSure" tabindex="-1" role="dialog"
		aria-labelledby="ModalLabela" aria-hidden="true"
		style="display: none; margin-top: 200px; margin-left: 100PX;">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header" style="background-color: #F4F5F9;">
					<p class="modal-title" id="exampleModalLabela"
						style="font-size: 14px;">信息确认</p>
					<button type="button" class="close" data-dismiss="modal"
						aria-hidden="true">×</button>
				</div>
				<div class="modal-body">
				<input id="different" name="different" type="hidden">
					<form id="orderForm" action="" style="font-size: 13px;">
						<table class="table noboder" style="font-size: 13px;">
							<thead id="orderHead">
							</thead>
							<tbody id="order">
							</tbody>
						</table>
						<hr>
						<div  style="margin-left: 10px">
							<div class="form-group row">
			                	<div class="col-6" >
			                		<div>硬件扣款：<span id="totalHMoney"></span>元</div>
			                	</div>
			                	<div class="col-6" >
			                		<div>公众号扣款：<span id="totalPMoney"></span>元</div>
			                	</div>
			                </div>
			                <div class="form-group row">
			                	<div class="col-6" >
			                		<div>小程序扣款：<span id="totalMMoney"></span>元</div>
			                	</div>
			                	<div class="col-6" >
			                		<div>VIP扣款：<span id="totalVMoney"></span>元</div>
			                	</div>
		                	</div>
							<div class="form-group row">
			                	<div class="col-11" >
			                		<div style="float: right">总价格：<span id="totalMoney"></span>元</div>
			                	</div>
		                	</div>
	                	</div>
					</form>
				</div>
				<div class="modal-footer" style="background-color: #F4F5F9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
						<button type="button" class="btn  btn-info" id="sure"  onclick="saveOrder()">确认</button>
				</div>
			</div>
		</div>
	</div>
	<script src="${ctxStatic}/agentSystem/js/distpicker.data.js"></script>
	<script src="${ctxStatic}/agentSystem/js/distpicker.js"></script>
	<script src="${ctxStatic}/agentSystem/js/main.js"></script>
	<script type="text/javascript">
	
	$(document).ready(function(){
		findHardware(0);
		findSalesPolicy(0);
		
		//验证手机和座机
		jQuery.validator.addMethod("isPhone", function (value, element) {  
		    var isphone =  /^((0\d{2,3}-\d{7,8})|(1[3567984]\d{9}))$/;   
		    return this.optional(element) || (isphone.test(element.value));  
		}, $.validator.format("请输入正确的电话号码"));
		//自定义validate验证输入的数字小数点位数不能大于两位
		jQuery.validator.addMethod("minNumber",function(value, element){
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
        },"小数点后最多为两位");
		
		jQuery.validator.addMethod("isRightLoginNameForm", function(value, element) {
            var rightLoginNameForm = /^[a-zA-z][a-zA-Z0-9]{4,14}$/;
            return (rightLoginNameForm.test(value));
        }, "账号只能由字母数字组成，且只能以字母开头"); 
        jQuery.validator.addMethod("isRightPasswordForm", function(value, element) {
            var rightPasswordForm = /^[a-zA-Z0-9]{6,20}$/;
            return (rightPasswordForm.test(value));
        }, "密码只能由字母数字组成"); 
        jQuery.validator.addMethod("validateArea", function(value, element) {
            var str = "";
            return (str != value);
        }, "请选择地区"); 
        
	});
	
	//获取硬件下拉菜单
	function findHardware(Vname){
		$.ajax({
			url : "${ctx}/agency/wasAgentOrder/list",
			dataType : "json",
			type : "post",
			success : function(data) {//control成功了在传回来用的
				$.each(data,function(i,li){
					$("#selectHardware"+Vname).append(new Option(li.name,li.hardwareId+'Ч'+li.name));
				});
            }
		});
	}
	
	//获取硬件单价
	function getHardwarePrice(Vname){
		var id=$("#selectHardware"+Vname).val().split("Ч")[0];
		if(id != ""){
			$.ajax({
				url : "${ctx}/sysdata/wasHardware/get",
				dataType : "json",
				type : "post",
				data : {'hardwareId':id},
				success : function(data) {//control成功了在传回来用的
					$("#hardwarePrice"+Vname).val(data.price.toFixed(2));
					$("#hardwareNumber"+Vname).val(1);
					$("#hardwareTotal"+Vname).val((($("#hardwarePrice"+Vname).val())*($("#hardwareNumber"+Vname).val())).toFixed(2));
					countAllTotalH();
	            }
			});
		}else{
			$("#hardwarePrice"+Vname).val("");
			$("#hardwareNumber"+Vname).val("");
			$("#hardwareTotal"+Vname).val("");
			countAllTotalH();
		}
	}
	
	//获取当前代理商等级下的所有销售方针
	function findSalesPolicy(Vname){
		var agentLevelId=$("#agentLevelId").val();
		$.ajax({
			url : "${ctx}/agency/wasAgentOrder/findPolicy",
			dataType : "json",
			type : "post",
			data : {'agentLevelId':agentLevelId},
			success : function(data) {//control成功了在传回来用的
				 $.each(data,function(i,li){
					$("#selectPolicy"+Vname).append(new Option(li.title,li.salesPolicyId+'Ч'+li.title));
				}); 
            },
		});
	}
	
	//获取方针单价、折扣单价
	function getPolicyPrice(Vname){
		var id=$("#selectPolicy"+Vname).val().split("Ч")[0];
		if(id != ""){
			$.ajax({
				url : "${ctx}/agency/wasAgentOrder/getPolicy",
				dataType : "json",
				type : "post",
				data : {'salesPolicyId':id},
				success : function(data) {//control成功了在传回来用的
					$("#classify"+Vname).val(data.classify);
					if($("#classify"+Vname).val() == 0){//公众号
						var publicDiscount = ${agent.publicDiscount};
						$("#policyPrice"+Vname).val((data.price * publicDiscount).toFixed(2));
					}else if($("#classify"+Vname).val() == 1){//小程序
						var minaDiscount = ${agent.minaDiscount};
						$("#policyPrice"+Vname).val((data.price * minaDiscount).toFixed(2));
					}else if($("#classify"+Vname).val() == 2){//套餐
						var packageDiscount = ${agent.packageDiscount};
						$("#policyPrice"+Vname).val((data.price * packageDiscount).toFixed(2));
					}
					$("#singlePrice"+Vname).val(data.price);
					$("#policyNumber"+Vname).val(1);
					$("#year"+Vname).val(data.dredgeYear+data.giveYear);
					$("#totalYear"+Vname).val((($("#year"+Vname).val())*($("#policyNumber"+Vname).val())));
					$("#money"+Vname).val(data.price*($("#policyNumber"+Vname).val()));
					$("#policyTotal"+Vname).val((($("#policyPrice"+Vname).val())*($("#policyNumber"+Vname).val())).toFixed(2));
					countAllTotalP();
	            }
			});
		}else{
			$("#classify"+Vname).val("");
			$("#policyPrice"+Vname).val("");
			$("#singlePrice"+Vname).val("");
			$("#policyNumber"+Vname).val("");
			$("#year"+Vname).val("");
			$("#totalYear"+Vname).val("");
			$("#money"+Vname).val("");
			$("#policyTotal"+Vname).val("");
			countAllTotalP();
		}
		
	}
	 	var i = 1;
	 	var j = 1;
	 	//添加软件订单
		function addPolicyOrder(){
	 		if($(".policyOrder").length < 6){
				$("#policy").append('<div id="policyOrder'+i+'" class="input-group policyOrder" style="margin-top:5px"><span class="input-group-addon height-control rightAngle ">版本</span>'+
						'<div><div><select onchange="getPolicyPrice('+i+')" class="form-control custom-select height-control leftAngle rightAngle" tabindex="1"'+
							'id="selectPolicy'+i+'" name="selectPolicy'+i+'" style="width:100%"><option value="">请选择</option></select></div></div>'+
							'<input type="hidden" id="classify'+i+'" name="classify">'+
		                    '<span class="input-group-addon height-control leftAngle rightAngle">数量</span>'+
		                    '<div><div><input id="policyNumber'+i+'" name="policyNumber'+i+'" style="width:100%" type="text" class="form-control height-control leftAngle rightAngle" onkeyup="countPolicy('+i+')" maxlength="2"></div></div>'+
		                    '<span class="input-group-addon height-control leftAngle rightAngle">折扣单价</span>'+
		                	'<input id="policyPrice'+i+'" type="text" class="form-control height-control leftAngle rightAngle" readonly>'+
		                	'<input type="hidden" id="year'+i+'" name="year">'+
		                	'<input type="hidden" id="totalYear'+i+'" name="totalYear">'+
		                	'<input type="hidden" id="singlePrice'+i+'" name="singlePrice">'+
		                	'<input type="hidden" id="money'+i+'" name="money">'+
		                    '<span class="input-group-addon height-control leftAngle rightAngle">折扣总价</span>'+
		                	'<input id="policyTotal'+i+'" name="policyTotal" type="text" class="form-control height-control leftAngle rightAngle " readonly>'+
		                	'<a href="javascript:;" onclick="deletePolicy('+i+')" class="input-group-addon height-control leftAngle"><i class="fa fa-times-circle"> </i></a></div>');
				findSalesPolicy(i);
				$("#selectPolicy"+i).rules("add",{required:true,messages:{required:"请选择版本"}});
				$("#policyNumber"+i).rules("add",{required:true,digits:true,min:0.1,max:10,messages:{required : "请输入数量",digits:"请输入大于0且小于等于10的整数",min:"请输入大于0的整数",max:"请输入小于等于10的整数"}});
				i = i + 1;
				
	 		}else{
	 			layer.msg("最多添加6个！",{icon:7,time:1500});
	 		}
		}
	 	//添加硬件订单
		function addHardwareOrder(){
	 		if($(".hardwareOrder").length < 6){
	 			$("#hardware").append('<div id="hardwareOrder'+j+'"  class="input-group hardwareOrder" style="margin-top:5px"><span class="input-group-addon height-control rightAngle ">硬件产品</span>'+
						'<div><div><select onchange="getHardwarePrice('+j+')" name="selectHardware'+j+'" style="width:100%" class="form-control custom-select height-control leftAngle rightAngle"'+
						    'tabindex="1" id="selectHardware'+j+'" ><option value="">请选择</option></select></div></div>'+
		                    '<span class="input-group-addon height-control leftAngle rightAngle">数量</span>'+
		                    '<div><div><input id="hardwareNumber'+j+'" name="hardwareNumber'+j+'" type="text" style="width:100%" class="form-control height-control leftAngle rightAngle" onkeyup="countHardware('+j+')" maxlength="6"></div></div>'+
		                    '<span class="input-group-addon height-control leftAngle rightAngle">单价</span>'+
		                	'<input id="hardwarePrice'+j+'" type="text" class="form-control height-control leftAngle rightAngle" readonly>'+
		                	'<span class="input-group-addon height-control leftAngle rightAngle">总价</span>'+
	                        '<input id="hardwareTotal'+j+'" name="hardwareTotal" type="text" class="form-control height-control leftAngle rightAngle " readonly >'+
	                        '<a href="javascript:;" onclick="deleteHardware('+j+')" class="input-group-addon height-control leftAngle"><i class="fa fa-times-circle"> </i></a></div>');
				findHardware(j);
				$("#selectHardware"+j).rules("add",{required:true,messages:{required:"请选择硬件产品"}});
				$("#hardwareNumber"+j).rules("add",{required:true,digits:true,min:0.1,messages:{required : "请输入数量",digits:"请输入大于零的整数",min:"请输入大于零的整数"}});
				j = j + 1;
	 		}else{
	 			layer.msg("最多添加6个！",{icon:7,time:1500});
	 		}
			
			
		}
		//删除软件订单
		function deletePolicy(Vname){
			var policyLength = document.getElementById("policy").children.length;
			if(policyLength != 1){
				document.getElementById("policy").removeChild(document.getElementById("policyOrder"+Vname));
				$("#selectPolicy"+Vname).rules("remove",{required:true,messages:{required:"请选择版本"}});
				$("#policyNumber"+Vname).rules("remove",{required:true,digits:true,min:0.1,max:10,messages:{required : "请输入数量",digits:"请输入大于0且小于等于10的整数",min:"请输入大于0的整数",max:"请输入小于等于10的整数"}});
				countAllTotalP();
			}else{
				layer.msg("请至少选择一个产品！",{icon:7,time:1500});
			}
			
		}
		//删除硬件订单
		function deleteHardware(Vname){
			var hardwareLength = document.getElementById("hardware").children.length;
			if(hardwareLength != 1){
				document.getElementById("hardware").removeChild(document.getElementById("hardwareOrder"+Vname));
				 $("#selectHardware"+Vname).rules("remove",{required:true,messages:{required:"请选择硬件产品"}});
				 $("#hardwareNumber"+Vname).rules("remove",{required:true,digits:true,min:0.1,messages:{required : "请输入数量",digits:"请输入大于零的整数",min:"请输入大于零的整数"}});
				 countAllTotalH();
			}else{
				layer.msg("请至少选择一个硬件！",{icon:7,time:1500});
			}
			 
		}
		//计算硬件总价onkeyup事件
		function countHardware(Vname){
            var a= $("#hardwareNumber"+Vname).val();
            if(a == ""){
            	$("#hardwareTotal"+Vname).val(0);
            	countAllTotalH();
            }else if(isNaN(a)){
            	$("#hardwareTotal"+Vname).val(0);
            	countAllTotalH();
            }else{
            	$("#hardwareTotal"+Vname).val((a*($("#hardwarePrice"+Vname).val())).toFixed(2));
            	countAllTotalH();
            }
        }
		//计算硬件所有订单的总价
		function countAllTotalH(){
			var input = document.getElementsByName("hardwareTotal"); //返回的是多个input元素的集合
			var total = 0;
			for(var i =0;i < input.length;i++){
			    if(input[i].value != null && input[i].value != ""){
			    	total += parseFloat(input[i].value);
			    } 
			}
			$("#allHardwarePrice").val(total.toFixed(2));
		}
		//计算方针总价onkeyup事件
		function countPolicy(Vname){
            var a= $("#policyNumber"+Vname).val();
            if(a == ""){
            	$("#policyTotal"+Vname).val(0);
            	$("#money"+Vname).val(0);
            	$("#totalYear"+Vname).val(0);
            	countAllTotalP();
            }else if(isNaN(a)){
            	$("#policyTotal"+Vname).val(0);
            	$("#money"+Vname).val(0);
            	$("#totalYear"+Vname).val(0);
            	countAllTotalP();
            }else{
            	$("#policyTotal"+Vname).val((a*($("#policyPrice"+Vname).val())).toFixed(2));
            	$("#money"+Vname).val((a*($("#singlePrice"+Vname).val())).toFixed(2));
            	$("#totalYear"+Vname).val(a*($("#year"+Vname).val()));
            	countAllTotalP();
            }
        }
		//计算方针所有订单的总价
		function countAllTotalP(){
			var input = document.getElementsByName("policyTotal"); //返回的是多个input元素的集合
			var total = 0;
			for(var i =0;i < input.length;i++){
			    if(input[i].value != null && input[i].value != ""){
			    	total += parseFloat(input[i].value);
			    } 
			}
			$("#allPolicyPrice").val(total.toFixed(2));
		}
		//扣款弹框显示
		function show(a,obj) {
			$(obj).blur();
			$("#debitwayForm").data("validator").resetForm();
			$("#hardwarerow").val("");
			$("#publicrow").val("");
			$("#minarow").val("");
			$("#viprow").val("");
			$("#totalAccountMoney").text("0");
			$("#difference").val(a);
			var Total = parseFloat($("#publicAccount").val())+parseFloat($("#minaAccount").val())+parseFloat($("#hardwareAccount").val())+parseFloat($("#vipAccount").val());
			if(a == 1){
				var allHardwarePrice = $("#allHardwarePrice").val();
				if(Total > allHardwarePrice){
					$("#modal").modal("show");
				}else{
					layer.msg("账户余额不足！",{icon:7,time:1500});
				}
			}else if(a == 0){
				var allPolicyPrice = $("#allPolicyPrice").val();
				if(Total > allPolicyPrice){
					$("#modal").modal("show");
				}else{
					layer.msg("账户余额不足！",{icon:7,time:1500});
				}
			}
		}
		
		//form表单验证
		$("#buyHardware").validate({
			rules : {
				selectHardware : {required : true,},
				hardwareNumber : {required : true,digits:true,min:0.1,},
				debitway : {required : true,},
				name : {required : true,maxlength: 10,
				},
				phone : {required : true,isPhone : true,},
				address : {required : true,},
				remarks : {required : true,maxlength : 100,},
			},
			messages : {
				selectHardware : {required : "请选择硬件产品",},
				hardwareNumber : {required : "请输入数量",digits:"请输入大于零的整数",min:"请输入大于零的整数",},
				debitway : {required : "请选择扣款方式",},
				name : {required : "请输入收货人",maxlength : "最多输入10个字符"},
				phone : {required : "请输入联系电话",},
				address : {required : "请输入收货地址",},
				remarks : {required : "请输入备注",maxlength : "最多输入100个字符"},
			},
			errorPlacement : function(error, element) {
				if(element.attr("id")=="hardwarerow"||element.attr("id")=="publicrow"||element.attr("id")=="minarow"||element.attr("id")=="viprow"){
					error.insertAfter(element.parent().parent());
            	}else{
				error.insertAfter(element.parent());
				}
			}
		});
		
		$("#bugPolicy").validate({
			rules:{
    			companyName:{required:true,minlength:2, maxlength:30,},
    			name:{required:true,minlength:2, maxlength:10,},
    			phone:{required:true,isPhone:true,},
    			province:{validateArea:true,},
    			address:{required:true,minlength:2,maxlength:50,},
    			loginName:{required:true,minlength:5, maxlength:15,isRightLoginNameForm:true,
        			remote:{
					    type:"POST",
					    url:"${ctx}/agentSystem/terminal/wasTerminalUser/validateLoginName",           
						data:{
							loginName:function(){return $("#loginName").val();},
					      }
						}
    			},
    			password:{required:true,minlength:6, maxlength:20,isRightPasswordForm:true,},
    			selectPolicy:{required : true,},
    			policyNumber:{required : true,digits:true,min:0.1,max:10},
    			debitway : {required : true,},
				remarks : {required : true,},
    		},
    		messages:{
    			companyName:{required:"请输入公司名称",minlength:"公司名称至少为2个字符",maxlength:"公司名称最多为30个字符",},
    			name:{required:"请输入负责人名字",minlength:"负责人名字至少为2个字符",maxlength:"负责人名字最多为10个字符"},
    			phone:{required: "请输入联系方式",},
    			address:{required:"请输入详细地址",minlength:"地址至少为2个字符",maxlength:"地址最多为50个字符"},
    			loginName:{required:"请输入账号",minlength:"账号至少5个字符",maxlength:"账号最多15个字符",remote:"此账号已经注册过"},    
    			password:{required:"请输入密码",minlength:"密码至少6个字符",maxlength:"密码最多20个字符"}, 
    			selectPolicy:{required : "请选择版本",},
    			policyNumber:{required : "请输入数量",digits:"请输入大于0且小于等于10的整数",min:"请输入大于0的整数",max:"请输入小于等于10的整数"},
    			debitway : {required : "请选择扣款方式"},
    			remarks : {required : "请输入备注"},
    		},
    		 errorPlacement: function(error, element) {
              	if(element.attr("id")=="province"){
             		$(".area").append(error);
             	}else if(element.attr("id")=="hardwarerow"||element.attr("id")=="publicrow"||element.attr("id")=="minarow"||element.attr("id")=="viprow"){
             		error.insertAfter(element.parent().parent());
             	}else{
                 	error.insertAfter(element.parent());
             	}          	
             }
		});
		
		$("#debitwayForm").validate({
			rules : {
				hardwarerow : {
					number : true,
					range : [0,'${agent.hardwareAccount}'],
					minNumber: true
				},
				publicrow : {
					number : true,
					range : [0,'${agent.publicAccount}'],
					minNumber: true
				},
				minarow : {
					number : true,
					range : [0,'${agent.minaAccount}'],
					minNumber: true
				},
				viprow : {
					number : true,
					range : [0,'${agent.vipAccount}'],
					minNumber: true
				},
			},
			messages : {
				hardwarerow : {
					number : "请正确输入金额",
					range: "请输入0-"+'${agent.hardwareAccount}'+"以内的金额"
				},
				publicrow : {
					number : "请正确输入金额",
					range : "请输入0-"+'${agent.publicAccount}'+"以内的金额"
				},
				minarow : {
					number : "请正确输入金额", 
					range : "请输入0-"+'${agent.minaAccount}'+"以内的金额"
				},
				viprow : {
					number : "请正确输入金额",
					range: "请输入0-"+'${agent.vipAccount}'+"以内的金额"
				},
			},
			errorPlacement : function(error, element) {
				error.insertAfter(element.parent().parent());
			}
		});
		
		//计算总金额
		$('.ExpendA').bind('input propertychange', function() {
			var total=0;
			$('.ExpendA').each(
				function(){
					if(!isNaN(this.value)){
						total+=Number(this.value);
					}
			});
			$('#totalAccountMoney').html(total.toFixed(2));
		});
		
		//保存扣款方式
		function saveDebitway(){
			var isValid = $("#debitwayForm").valid();
			if (isValid) {
				if($("#hardwarerow").val() == "" || $("#hardwarerow").val() == null){
					$("#hardwarerow").val(0);
				}
				if($("#publicrow").val() == "" || $("#publicrow").val() == null){
					$("#publicrow").val(0);
				}
				if($("#minarow").val() == "" || $("#minarow").val() == null){
					$("#minarow").val(0);
				}
				if($("#viprow").val() == "" || $("#viprow").val() == null){
					$("#viprow").val(0);
				}
				var totalDebitway = Number($("#hardwarerow").val())+Number($("#publicrow").val())+Number($("#minarow").val())+Number($("#viprow").val());
				var allHardwarePrice = $("#allHardwarePrice").val();
				var allPolicyPrice = $("#allPolicyPrice").val();
				if($("#difference").val()==1){
					if(Number(totalDebitway).toFixed(2) == Number(allHardwarePrice)){
						var str = '硬件扣款：'+Number($("#hardwarerow").val()).toFixed(2)+'元；公众号扣款：'+Number($("#publicrow").val()).toFixed(2)+'元；小程序扣款：'+Number($("#minarow").val()).toFixed(2)+'元；VIP扣款：'+Number($("#viprow").val()).toFixed(2)+'元；';
						$("#publicExpendHardware").val($("#publicrow").val());
						$("#minaExpendHardware").val($("#minarow").val());
						$("#hardwareExpendHardware").val($("#hardwarerow").val());
						$("#vipExpendHardware").val($("#viprow").val());
						$("#debitwayHardware").val(str);
						$("#debitwayHardware-error").css({display:'none'});
						$("#modal").modal("hide");
					}else{
						layer.msg("扣款总金额与硬件总价不等！",{icon:7,time:1500});
					}
				}else if($("#difference").val()==0){
					if(Number(totalDebitway).toFixed(2) == Number(allPolicyPrice)){
						var str = '硬件扣款：'+Number($("#hardwarerow").val()).toFixed(2)+'元；公众号扣款：'+Number($("#publicrow").val()).toFixed(2)+'元；小程序扣款：'+Number($("#minarow").val()).toFixed(2)+'元；VIP扣款：'+Number($("#viprow").val()).toFixed(2)+'元；';
						$("#publicExpendPolicy").val($("#publicrow").val());
						$("#minaExpendPolicy").val($("#minarow").val());
						$("#hardwareExpendPolicy").val($("#hardwarerow").val());
						$("#vipExpendPolicy").val($("#viprow").val());
						$("#debitwayPolicy").val(str);
						$("#debitwayPolicy-error").css({display:'none'});
						$("#modal").modal("hide");
					}else{
						layer.msg("扣款总金额与软件总价不等！",{icon:7,time:1500});
					}
				}
				
			}
		}
		//展示方针信息确认
		function savePolicy(a){
			$("#order").empty();
			$("#orderHead").empty();
			var isValid = $("#bugPolicy").valid();
			if (isValid) {
				var pay = Number($("#hardwareExpendPolicy").val()) + Number($("#publicExpendPolicy").val()) + Number($("#minaExpendPolicy").val()) + Number($("#vipExpendPolicy").val());
				if($("#allPolicyPrice").val() == Number(pay).toFixed(2)){
					var list = [];
					$("#policy :input").each(function(){
						if($(this).val() != "" && $(this).val() != null){
							list = list + $(this).val()+"Ч";
						}
					}); 
					$("#listPolicy").val(list);
					var string = list.split("Ч");
					var orderHead = "";
					orderHead="<tr><th width='30%'>名称</th><th width='15%'>数量</th><th width='15%'>年限/年</th><th width='20%'>单价/元</th><th width='20%'>总价/元</th></tr>";
					$("#orderHead").append(orderHead);
					for(var i = 0; i < string.length-1; i+=10){
						var str = "";
						var name = string[i+1];
						var number = string[i+3];
						var year = string[i+6];
						var unitPrice =string[i+4];
						var price = string[i+9];
						str ='<tr><td id="name'+i+'"></td><td>'+number+'</td><td>'+year+'</td><td>'+unitPrice+'</td><td>'+price+'</td></tr>';
						$("#order").append(str);
						$('#'+'name'+i).text(name);
					}
					
					$("#totalMoney").html($("#allPolicyPrice").val());
					$("#totalHMoney").html(Number($("#hardwareExpendPolicy").val()).toFixed(2));
					$("#totalPMoney").html(Number($("#publicExpendPolicy").val()).toFixed(2));
					$("#totalMMoney").html(Number($("#minaExpendPolicy").val()).toFixed(2));
					$("#totalVMoney").html(Number($("#vipExpendPolicy").val()).toFixed(2));
					$("#different").val(a);
					$("#ModalSure").modal("show");
				}else{
					layer.msg("扣款总金额与软件总价不等！",{icon:7,time:1500});
				}
			}
		}
		//展示硬件信息确认
		function saveHardware(a){
			$("#order").empty();
			$("#orderHead").empty();
			var isValid = $("#buyHardware").valid();
			if (isValid) {
				var pay = Number($("#hardwareExpendHardware").val()) + Number($("#publicExpendHardware").val()) + Number($("#minaExpendHardware").val()) + Number($("#vipExpendHardware").val());
				if($("#allHardwarePrice").val() == Number(pay).toFixed(2)){
					var list = [];
					$("#hardware :input").each(function(){
						if($(this).val() != "" && $(this).val() != null){
							list = list + $(this).val()+"Ч";
						}
					}); 
					$("#listHardware").val(list);
					var string = list.split("Ч");
					var orderHead = "";
					orderHead="<tr><th>名称</th><th>数量</th><th>单价/元</th><th>总价/元</th></tr>";
					$("#orderHead").append(orderHead);
					for(var i = 0; i < string.length-1; i+=5){
						var str = "";
						var name = string[i+1];
						var number = string[i+2];
						var unitPrice =string[i+3];
						var price = string[i+4];
						str ='<tr><td id="name'+i+'"></td><td>'+number+'</td><td>'+unitPrice+'</td><td>'+price+'</td></tr>';
						$("#order").append(str);
						$('#'+'name'+i).text(name);
					}
					$("#totalMoney").html($("#allHardwarePrice").val());
					$("#totalHMoney").html(Number($("#hardwareExpendHardware").val()).toFixed(2));
					$("#totalPMoney").html(Number($("#publicExpendHardware").val()).toFixed(2));
					$("#totalMMoney").html(Number($("#minaExpendHardware").val()).toFixed(2));
					$("#totalVMoney").html(Number($("#vipExpendHardware").val()).toFixed(2));
					$("#different").val(a);
					$("#ModalSure").modal("show");
				}else{
					layer.msg("扣款总金额与硬件总价不等！",{icon:7,time:1500});
				}
			}
		}
		
		//保存订单
		function saveOrder(){
			if($("#different").val() == 0){//保存方针订单
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					url : "${ctx}/agency/wasAgentOrder/insertPolicy",
					dataType : "json",
					type : "post",
					data : $('#bugPolicy').serialize(),//通过ajax传过去
					success : function(result) {//control成功了在传回来用的
						if (result == 1) {
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("购买成功", {
								time : 1500,
								icon : 1,
							}, function(data) {
								window.location.href = "${ctx}/agentSystem/SysUser/list";
							});
						}else if(result == 2){
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("终端添加失败", {
								time : 1500,
								icon : 2,
							}, function(data) {
								window.location.href = "${ctx}/agentSystem/SysUser/list";
							});
						}else if(result == 3){
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("选择方针中只可含一个旧版公众号", {
								time : 1500,
								icon : 2,
							}, function(data) {
								
							});
						}else{
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("购买失败", {
								time : 1500,
								icon : 2,
							}, function(data) {
								window.location.href = "${ctx}/agentSystem/SysUser/list";
							});
						}
					}
				});
			}else if($("#different").val() == 1){//保存硬件订单
				$("#deliveryMethod").val($(":radio:checked").val());
				if($("#deliveryMethod").val() == 0){
					$("#receivingAddress").val("");
				}
				var index = layer.load(1, {shade: [0.1,'#fff']});
				$.ajax({
					url : "${ctx}/agency/wasAgentOrder/insertHardware",
					dataType : "json",
					type : "post",
					data : $('#buyHardware').serialize(),//通过ajax传过去
					success : function(result) {//control成功了在传回来用的
						if (result > 0) {
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("购买成功", {
								time : 1000,
								icon : 1,
							}, function(data) {
								window.location.href = "${ctx}/agentSystem/SysUser/list";
							});
						}else{
							layer.close(index);
							$("#ModalSure").modal("hide");
							layer.msg("购买失败", {
								time : 1000,
								icon : 2,
							}, function(data) {
								window.location.href = "${ctx}/agentSystem/SysUser/list";
							});
						}
					}
				});
			}
			
		}
		//返回
		function jump() {
			layer.confirm('确认放弃本次操作？', { icon : 3 ,closeBtn : 0,
				 skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
					 window.location.href = "${ctx}/agentSystem/SysUser/list";
				 });
		}
		
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
			$("#searchForm").submit();
		}
		//checkbox监听
		$('#square-radio-one').on('ifChecked', function(event) { //ifCreated 事件应该在插件初始化之前绑定 (ifUnchecked)
			document.getElementById("select").style.display="none";    
		});
		$('#square-radio-two').on('ifChecked', function(event) { //ifCreated 事件应该在插件初始化之前绑定 (ifUnchecked)
			document.getElementById("select").style.display="";    
		});
		//针对tab切换会出现其他的问题
		function switchover(state){
			if(state == '0') {
				$('#profile').removeClass("active");
				$('#profile').attr("aria-expanded", false);
			}else {
				$('#home').removeClass("active");
				$('#home').attr("aria-expanded", false);
			}
		}
	</script>

</body>
</html>