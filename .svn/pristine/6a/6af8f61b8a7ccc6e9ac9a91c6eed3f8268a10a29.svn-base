
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
<!-- 销售方针查看 -->
<%@ include file="/webpage/modules/agentsystem/include/head.jsp"%>
<style type="text/css">
.a{
white-space:pre-wrap;
/* word-break:break-all; */
}
</style>
</head>
<body>
	<div class="row divControl">
		<div class="col-md-12">
			<div class="card">
				<div class="card-body">
					<h6 style="height:30px"  class="cardTitle">销售方针详情</h6>
					<hr class="m-t-0 m-b-40">
					<form action="#" method="post"
						style="width: 100%" id="addForm">
						<div class="form-body">
 							<div class="row">
                                  <div class="col-md-6">
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">所选产品：</label>
                                          <label class="control-label col-9 a" style="text-align: left;">${WasSalesPolicy.softwareIds}</label> 
                                      </div>

                                      <div class="form-group row">
                                      <label class="control-label col-3" style="text-align: right;">开通年限：</label>
                                      <label class="control-label col-9" style="text-align: left;">${WasSalesPolicy.dredgeYear}年</label>

                                  </div>
                                      <div class="form-group row">
                                      <label class="control-label col-3" style="text-align: right;">开始时间：</label>
                                      <label class="control-label col-9" style="text-align: left;">
                                      <fmt:formatDate value="${WasSalesPolicy.startDate}" pattern="yyyy-MM-dd"/>
                                      </label>

                                  </div>
                                  <div class="form-group row" >

										<label class="control-label col-3" style="text-align: right;">价格：</label>
										<label class="control-label col-9" style="text-align: left;">${WasSalesPolicy.price}元</label>

									</div>
                                  
									<div class="form-group row" >

										<label class="control-label col-3" style="text-align: right;">排序：</label>
										<label class="control-label col-9" style="text-align: left;">${WasSalesPolicy.sort}</label>

									</div>
									<div class="form-group row" >

										<label class="control-label col-3" style="text-align: right;">备注：</label>
										<label class="control-label col-9 a" style="text-align: left;">${fn:escapeXml(WasSalesPolicy.remarks)=='' ? '--':fn:escapeXml(WasSalesPolicy.remarks)}</label>

									</div> 
                                

                                  </div>
                                  <!--/span-->
                                  <div class="col-md-6">
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">套餐名：</label>
                                          <label class="control-label col-9 a" style="text-align: left;">${fn:escapeXml(WasSalesPolicy.title)}</label>

                                      </div>

                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">赠送年限：</label>
                                          <label class="control-label col-9" style="text-align: left;">${WasSalesPolicy.giveYear == null  ? "--":WasSalesPolicy.giveYear}年</label>
                                      </div>

                                      <div class="form-group row" id="principal">
                                          <label class="control-label col-3" style="text-align: right;">结束时间：</label>
                                          <label class="control-label col-9" style="text-align: left;">
                                          <fmt:formatDate value="${WasSalesPolicy.endDate}" pattern="yyyy-MM-dd"/>
                                          </label>
                                      </div>
                                      
                                      <div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">续费折扣：</label>
                                          <label class="control-label col-9" style="text-align: left;"><fmt:formatNumber value="${WasSalesPolicy.renewDiscount*10}" type="currency" pattern="#0.0"/>折</label>

                                      </div>
                                      

									<div class="form-group row">
                                          <label class="control-label col-3" style="text-align: right;">方针分类：</label>
                                          <c:if test="${WasSalesPolicy.classify == 0}">
												<label class="control-label col-9" style="text-align: left;">公众号</label>
											</c:if>
                                               <c:if test="${WasSalesPolicy.classify == 1}">
												<label class="control-label col-9" style="text-align: left;">小程序</label>
											</c:if>
											<c:if test="${WasSalesPolicy.classify == 2}">
												<label class="control-label col-9" style="text-align: left;">混合套餐</label>
											</c:if>
                                      </div>
                                  </div>
                              </div>

						</div>
						<div class="form-group row">
							<div class="col-12">
								<div class="text-xs-right" style="text-align: right;">
									<button type="button" onclick="goBack()" class="btn btn-default">返回</button>
								</div>
							</div>
						</div>
					</form>
				</div>
              <form action="${ctx}/agentsystem/wasSalesPolicy/list"  method="post" id="lookaForm">
              <input name="pageNo" type="hidden" value="${pageNo}" /> 
              <input name="pageSize" type="hidden" value="${pageSize}" />
              </form>
			</div>
		</div>
	</div>
	<script type="text/javascript">
	function goBack(){
		$("#lookaForm").submit();
	}
	</script>
</body>
</html>