
<%@ page contentType="text/html;charset=UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<html>
<head>
    <!-- 终端产品列表 -->
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
                    <form action="${ctx}/agentSystem/terminal/wasTerminalProduct/productList" method="post" style="width: 100%" id="searchForm">
                        <input name="parentId" type="hidden" value="1" />
                        <input id="pageNo" name="pageNo" type="hidden" value="${page.pageNo}" />
                        <input id="pageSize" name="pageSize" type="hidden" value="${page.pageSize}" />
                        <input id="companyNameA" name="companyName" type="hidden"  value="${fn:escapeXml(wasTerminalUser.companyName)}"  />
                        <input id="beginDateA" name="beginDate" type="hidden"  value="<fmt:formatDate value="${wasTerminalUser.beginDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                        <input id="endDateA" name="endDate" type="hidden"  value="<fmt:formatDate value="${wasTerminalUser.endDate}" pattern="yyyy-MM-dd HH:mm:ss"/>" />
                        <button type="button" class="btn waves-effect waves-light btn-info" onclick="search()" style="float: right; margin-left: 15px">搜索</button>
                        <input id="companyNameB" autocomplete="off" type="text" class="form-control height-control col-3" placeholder="请输入公司名称" value="${fn:escapeXml(wasTerminalUser.companyName)}" style="float: right;">
                        <div class="form-group col-6" style="margin-bottom: 0px; float: right;">
                            <div class=" input-group input-daterange" id="date-range">
                                <div style="display:inline-block;padding-top: 8px;">开户时间范围：&nbsp;&nbsp;</div>
                                <input id="beginDateB" value="<fmt:formatDate value="${wasTerminalUser.beginDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control rightAngle" placeholder="开始时间" style="text-align: left;" />
                                <span class="input-group-addon bg-info b-0 text-white height-control addCentreControl  leftAngle rightAngle">至</span>
                                <input id="endDateB" value="<fmt:formatDate value="${wasTerminalUser.endDate}" pattern="yyyy-MM-dd"/>" type="text" class="form-control height-control leftAngle" placeholder="结束时间" style="text-align: left;" />
                            </div>
                        </div>
                    </form>
                </div>
                <table id="contentTable" class="display nowrap table table-hover table-striped table-bordered" cellspacing="0" width="100%">
                    <thead>
                    <tr>
                        <th class="tableControl">公司名称</th>
                        <th class="tableControl">终端状态</th>
                        <th class="tableControl">用户名</th>
                        <th class="tableControl">开户时间</th>
                        <th class="tableControl">所属代理商</th>
                        <th class="tableControl">代理商状态</th>
                        <th class="tableControl">操作</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${page.list}" var="wasTerminalUser">
                        <tr>
                            <td hidden><input value="${wasTerminalUser.terminalUserId}" ></td>
                            <td class="tableControl" style="max-width:200px;white-space: pre-wrap;word-wrap: break-word;">${fn:escapeXml(wasTerminalUser.companyName)}</td>
                            <td class="tableControl">${(wasTerminalUser.state eq "1")?"冻结":"正常"}</td>
                            <td class="tableControl">${fn:escapeXml(wasTerminalUser.loginName)}</td>
                            <td class="tableControl"><fmt:formatDate value="${wasTerminalUser.createDate}" pattern="yyyy-MM-dd"/></td>
                            <td class="tableControl">${fn:escapeXml(wasTerminalUser.parentId)}</td>
                            <%-- <td class="tableControl">${(wasTerminalUser.isNewRecord)?"正常":"冻结"}</td> --%>
                            <td class="tableControl" style="${(wasTerminalUser.agentValid)?'':'color:red'}">${(wasTerminalUser.agentValid)?((wasTerminalUser.agentState)?"正常":"冻结"):"过期"}</td>
                            <td class="tableControl">
                                <shiro:hasPermission name="terminal:wasTerminalProduct:look">
                                    <button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="查看" class="btn btn-info btn-circle btn-xs show">
                                        <i class="fa fa-search-plus"></i>
                                    </button>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="terminal:wasTerminalProduct:toAddProductList">
                                    <button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="添加" class="btn btn-info btn-circle btn-xs addProduct" ${(wasTerminalUser.state eq "1")||(!wasTerminalUser.agentState)||(!wasTerminalUser.agentValid)?"disabled":""}>
                                    <i style="font-size:15px;color:white;" class="iconfont icon-tianjia"></i>
                                    </button>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="terminal:wasTerminalProduct:toWasRechargeList">
                                    <button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="续费" class="btn btn-info btn-circle btn-xs recharge" ${(wasTerminalUser.state eq "1")||(!wasTerminalUser.agentState)||(!wasTerminalUser.agentValid)?"disabled":""}>
                                    <i class="iconfont icon-xuqian"></i>
                                    </button>
                                </shiro:hasPermission>
                                <shiro:hasPermission name="terminal:wasTerminalProduct:change">
                                    <button type="button" data-toggle="tooltip" style="padding:0px" data-original-title="变更" class="btn btn-info btn-circle btn-xs changeProduct" ${(wasTerminalUser.state eq "1")||(!wasTerminalUser.agentState)||(!wasTerminalUser.agentValid)?"disabled":""}>
                                    <i class="mdi mdi-apple-keyboard-caps"></i>
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


<!-- 查看 -->
<div class="modal fade" id="productsDetails" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1"
     aria-hidden="true" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top:170px">
            <div class="modal-header" style="background-color: #F4F5F9;">
                <h4 class="modal-title" id="exampleModalLabel01" style="font-size:14px">产品详情</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body" style="font-size:13px">
                <div class="row" >
                    <label class="col-sm-3">企业名称:</label>
                    <label class="col-sm-9"></label>
                </div>
                <div class="row" >
                    <label class="col-sm-3">所属代理商:</label>
                    <label class="col-sm-9"></label>
                </div>
                <div class="" style="border-top: 1px solid silver;">
                    <table class="table" style="font-size:13px">
                        <thead>
                        <tr>
                            <th style="width:33%">
                                版本名称
                            </th>
                            <th style="width:33%">
                                类型
                            </th>
                            <th style="width:33%">
                                到期时间
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
        </div>
    </div>
</div>
<!-- 变更 -->
<div class="modal fade" id="changeProduct" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel1"
     aria-hidden="true" style="display: none;">
    <div class="modal-dialog" role="document">
        <div class="modal-content" style="margin-top:170px">
            <div class="modal-header" style="background-color: #F4F5F9;">
                <h4 class="modal-title" id="exampleModalLabel01" style="font-size:14px">产品更换</h4>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">×</span>
                </button>
            </div>
            <div class="modal-body" style="font-size:13px">
                <div class="row" >
                    <label class="col-sm-3">企业名称:</label>
                    <label class="col-sm-9"></label>
                </div>
                <div class="row" >
                    <label class="col-sm-3">所属代理商:</label>
                    <label class="col-sm-9"></label>
                    <input name="terminalUserId" hidden/>
                </div>
                <div class="" style="border-top: 1px solid silver;">
                    <table class="table" style="font-size:13px">
                        <thead>
                        <tr>
                            <th style="width:25%">
                                版本名称
                            </th>
                            <th style="width:20%">
                                类型
                            </th>
                            <th style="width:35%">
                                变更版本
                            </th>
                            <th style="width:20%">
                                价格
                            </th>
                        </tr>
                        </thead>
                        <tbody>
                        </tbody>
                    </table>
                </div>
            </div>
            <!--对话框尾-->
            <div class="modal-footer" style="text-align: right; background-color: #f4f5f9; border-bottom-left-radius: 5px; border-bottom-right-radius: 5px;">
                <button type="button" class="btn btn-info" onclick="save()">保存</button>
            </div>
        </div>
    </div>
</div>
<script type="text/javascript">

    //下来选监听事件
    function select(){
        if($(event.target).val()=="default"){
            $(event.target).parent().parent().removeAttr('style').removeClass('checked')
        }else{
            $(event.target).parent().parent().css('background-color','#f3f1f1').addClass('checked')
        }
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
    function search(){
        $("#pageNo").val(0);
        $("#companyNameA").val($("#companyNameB").val());
        $("#beginDateA").val($("#beginDateB").val());
        $("#endDateA").val($("#endDateB").val() +" 23:59:59");
        $("#searchForm").submit();
    }
    //监听回车
    $('#companyNameB').bind('keypress', function(event) {
        if (event.keyCode == "13") {
            $("#pageNo").val(0);
            $("#companyNameA").val($("#companyNameB").val());
            $("#beginDateA").val($("#beginDateB").val());
            $("#endDateA").val($("#endDateB").val() +" 23:59:59");
            search();
        }
    });
    var pubA = 0.0;
    var minaA = 0.0;
    var vipA = 0.0;
    //终端所属代理商代理的所有软件
    var allSofts;
    //变更所需金额
    var moneies;
    $(document).ready(function(){
        //查看
        $(".show").click(function(){
            $("#productsDetails tbody").empty();
            var terminalUserId = $(this).parent().parent().find("input").val();
            var companyName = $(this).parent().parent().children(":eq(1)").text();
            var agent = $(this).parent().parent().children(":eq(5)").text();
            $("#productsDetails label:eq(1)").text(companyName);
            $("#productsDetails label:eq(3)").text(agent);
            $.post("${ctx}/agentSystem/terminal/wasTerminalProduct/showProducts",{"terminalUserId":terminalUserId},function(data,status){
                if(data.length==0){
                    layer.alert('当前用户没有产品', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
                    return;
                }
                var str = "";
                $(data).each(function(index,item){
                	//str += '<tr><td>' + item.id + '</td><td>' + ((item.isNewRecord==false)?"公众号":"小程序") + '</td><td>' + item.endDate.substring(0,10)  + '</td></tr>'
                	str = '<tr><td id=product' + index + '></td><td>' + ((item.isNewRecord==false)?"公众号":"小程序") + '</td><td>' + item.endDate.substring(0,10)  + '</td></tr>'
					$("#productsDetails tbody").append(str)
					$("#product" + index).text(item.id)
                })
                //$("#productsDetails tbody").append(str)
                $("#productsDetails").modal("show");
            })
        })
        //续费
        $(".recharge").click(function(){
            var terminalUserId = $(this).parent().parent().find("input").val();
            $.post("${ctx}/agentSystem/terminal/wasRecharge/terminalUserNumber",{"terminalUserId":terminalUserId},function(data,status){
                if(data==0){
                    layer.alert('当前用户没有产品', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
                }else{
                    window.location.href="${ctx}/agentSystem/terminal/wasRecharge/toWasRechargeList?terminalUserId="+terminalUserId;
                }
            })
        })
        //添加
        $(".addProduct").click(function(){
            var terminalUserId = $(this).parent().parent().find("input").val();
            window.location.href="${ctx}/agentSystem/terminal/wasRecharge/toAddProductList?terminalUserId="+terminalUserId;
        })
        //变更
        $(".changeProduct").click(function(){
            $("#changeProduct input").val($(this).parent().parent().find("input").val());
            $("#changeProduct tbody").empty();
            var terminalUserId = $(this).parent().parent().find("input").val();
            var companyName = $(this).parent().parent().children(":eq(1)").text();
            var agent = $(this).parent().parent().children(":eq(5)").text();
            $("#changeProduct label:eq(1)").text(companyName);
            $("#changeProduct label:eq(3)").text(agent);
            //请求所属代理商代理的软件
            $.ajax({
                url : "${ctx}/agentSystem/terminal/wasTerminalProduct/findAllSofts",type : "post",dataType : "json",async:false,data : {"terminalUserId":terminalUserId},success : function(result){
                    allSofts=result;
                }
            });
            //判断当前用户是否拥有软件
            $.post("${ctx}/agentSystem/terminal/wasTerminalProduct/showProducts",{"terminalUserId":terminalUserId},function(data,status){
                var str = ""
                if(data.length==0){
                    layer.alert('当前用户没有产品，请购买', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
                    return
                }
                $(data).each(function(index,item){
                    if(getMoney(item.isNewRecord)!=undefined && getMoney(item.isNewRecord)!="" && !isNaN(getMoney(item.isNewRecord))){
                        //str += '<tr><td hidden>'+item.softwareId+'</td><td>'+item.id+'</td><td>'+ ((item.isNewRecord==false)?"公众号":"小程序") +'</td><td>'+getSoft(item.isNewRecord,item.id,data)+'</td><td>'+ getMoney(item.isNewRecord) + '</td><td hidden>' + item.isNewRecord +'</td></tr>';
                        str = '<tr><td hidden>'+item.softwareId+'</td><td id=change'+ index +'></td><td>'+ ((item.isNewRecord==false)?"公众号":"小程序") +'</td><td>'+getSoft(item.isNewRecord,item.id,data,item.newVersion)+'</td><td>'+ getMoney(item.isNewRecord) + '</td><td hidden>' + item.isNewRecord +'</td></tr>';
						$("#changeProduct tbody").append(str)
    					$("#change" + index).text(item.id) 
                    }
                })
                //$("#changeProduct tbody").append(str)
                $("#changeProduct").modal("show");
            })
            //所属代理商账户余额
            $.post("${ctx}/agentSystem/terminal/wasTerminalProduct/agent",{"terminalUserId":terminalUserId},function(data,status){
                pubA = data.publicAccount;
                minaA = data.minaAccount;
                vipA = data.vipAccount;
            })
            //软件变更所需金额
            $.ajax({
                url : "${ctx}/agentSystem/terminal/wasTerminalProduct/findChangeMoney",type : "post",dataType : "json",async:false,success : function(result) {
                    moneies = result;
                }
            });
        });
    })
    //产品变更  保存方法
    function save(){
        var selectedOptions = $("#changeProduct tbody tr.checked option:selected")
        var temp = new Array();
        $(selectedOptions).each(function(index,element){
            if($(element).attr("value")!="default"){
                temp.push($(element).attr("value"))
            }
        })
        var sortTemp = temp.sort();
        for(var i=0;i<temp.length;i++){
            if (sortTemp[i]==sortTemp[i+1]){
                layer.alert('变更方针有重复，请重新选择', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
                return
            }
        }
        //三种产品每种产品花费金额变量
        var publicMoney = 0.00;
        var minaMoney  =0.00;
        var ele = $("#changeProduct tbody tr.checked")
        $(ele).each(function(index,item){
            var classify = $(item).children(":eq(5)").text();
            //true 是小程序 false 是公众号
            if('true' == classify){
                minaMoney += parseFloat($(item).children(":eq(4)").text());
            }else{
                publicMoney += parseFloat($(item).children(":eq(4)").text());
            }
        })
        //判断是否选择产品
        if(ele.length==0){
            layer.alert('请选择变更产品', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
            return;
        }
        //生成结果信息
        var resultInfo = accountMoney(publicMoney,minaMoney,pubA,minaA,vipA);
        if(resultInfo==""){
            layer.alert('余额不足，请重新选择', {skin: 'layui-layer-molv',closeBtn: 0,anim: 4});
            return;
        }
        var locked = false;
        if(!locked){
            layer.confirm(resultInfo + '确认变更当前产品？', {closeBtn : 0,icon : 3 ,skin : 'layui-layer-molv',btn: ['确认','取消']},function(){
                locked=true
                var terminalUserId = $("#changeProduct input").val();
                var trs = $("#changeProduct tbody tr.checked")
                var elements = $("#changeProduct tbody tr.checked")
                var length=elements.length;
                $(elements).each(function(index,item){
                    var oldSoftWareId = $(item).children(":eq(0)").text()
                    var newSoftWareId = $(item).find("option:selected").val()
                    var money = $(item).children(":eq(4)").text()
                    var index1 = layer.load(1, {shade: [0.1,'#fff']});
                    $.ajax({
                        url : "${ctx}/agentSystem/terminal/wasTerminalProduct/changeProduct",type : "post",dataType : "text",async:false,
                        data : {"terminalUserId":terminalUserId,"oldSoftWareId":oldSoftWareId,"newSoftWareId":newSoftWareId,"money":money},
                        success : function(result) {
                            if("success"==result){
                                if((length==(index+1))){
                                    layer.close(index1);
                                    locked=false;
                                    layer.msg("保存成功",{icon:1,time:1000},function(){
                                        $("#changeProduct").modal("hide")
                                    });
                                }
                            }else{
                                if((length==(index+1))){
                                    layer.close(index1);
                                    locked=false;
                					layer.msg("保存失败",{icon:2,time:1000},function(){
                						return;  
                					}); 
                                }
            			}
                        },
                        error : function(result){
	                            if((length==(index+1))){
		                       		layer.close(index);
		            				locked = false;
		            				layer.msg("保存失败",{icon:2,time:1000},function(){
		            					return;  
		            				}); 
	                            }
                        }
                    });
                })
            })
        }
    }
    //组装可变更软件
    function getSoft(type,name,data,newVersion){
        var str = "<option value='default'>请选择</option>";
        //代理商代理软件中的一类，小程序或公众号
        var tempArr = new Array(0);
        //第一层过滤，过滤类型
        for(var k=0;k<allSofts.length;k++){
            if(String(allSofts[k].classify)==String(type)&&String(allSofts[k].newVersion)==String(newVersion)){
                tempArr.push(allSofts[k]);
            }
        }
        //在tempArr基础上过滤终端已有软件
        var tempArr2 = tempArr.concat();
        //第二层过滤，过滤已有软件
        for(var i=0;i<tempArr.length;i++) {
            for(var j=0;j<data.length;j++){
                var temp = tempArr[i]
                /* var aa = temp.name.replace(/(^\s*)|(\s*$)/g, "");
                if(aa == data[j].id){
                    removeByValue(tempArr2, tempArr[i]);
                } */
                var aa = temp.softwareId;
                if(aa == data[j].softwareId){
                    removeByValue(tempArr2, tempArr[i]);
                }
            }
        };
        $.each(tempArr2,function(i,item){
            str+="<option value=\""+ item.softwareId +"\">" + item.name + "</option>"
        })
        return "<select name='softwareId' class='form-control input-sm selectChange height-control valid'   onchange='select()'>" + str + "</select>";

    }
    //组装变更金额select
    function getMoney(type){
        var pri;
        $(moneies).each(function(index,item){
            if(item.classify == type){
                pri =  item.price;
            }
        })
        return parseFloat(pri).toFixed(2)
    }
    //删除数组中指定元素
    function removeByValue(arr, val) {
        for(var i=0; i<arr.length; i++) {
            if(arr[i] == val) {
                arr.splice(i, 1);
                break;
            }
        }
    }
    //生成购买价格信息，消费总额参数与账户余额信息
    function accountMoney(pubMoney,minaMoney,pubA,minaA,vipA){
        var str = "";
        var pubExtend = 0.00;
        var minaExtend = 0.00;
        var vipExtend =0.00;
        if(pubMoney>0){
	        	if(pubMoney<=pubA){
		            pubExtend += pubMoney
		            pubA -= pubMoney
		        }else if(pubMoney<=(pubA+vipA)){
		            pubExtend += pubA;
		            vipExtend += (pubMoney - pubA)
		            vipA = vipA - (pubMoney - pubA)
		            pubA = 0.00;
		        }else{
		            return str;
		        }
        }
        if(minaMoney>0){
	        	if(minaMoney<=minaA){
		            minaExtend += minaMoney
		            minaA -= minaMoney
		        }else if(minaMoney<=(minaA+vipA)){
		            minaExtend += minaA;
		            vipExtend += (minaMoney - minaA)
		            vipA = vipA - (minaMoney - minaA)
		            minaA = 0.00;
		        }else{
		            return str;
		        }
        }
        str =  "<p style='margin-bottom: 0px;'>公众号扣款：" + pubExtend.toFixed(2)  + "元</p>"+"<p style='margin-bottom: 0px;'>小程序扣款：" + minaExtend.toFixed(2)  + "元</p>"+"<p style='margin-bottom: 0px;'>VIP扣款：" + vipExtend.toFixed(2) + "元</p>"
        return str;
    }
</script>

</body>
</html>