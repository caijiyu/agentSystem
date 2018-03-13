//记住上次打开的页面
$(document).ready(function() {
	if($.cookie('VicmobAgentSystemMenuId') != null && $.cookie('VicmobAgentSystemMenuId') != "null"){
		try {
			var id = $.cookie('VicmobAgentSystemMenuId');
			document.getElementById(id).click();
			$('#'+id).parent().parent().addClass("in");
			$('#'+id).parent().parent().parent().addClass("active");
			$('#'+id).parent().parent().attr("aria-expanded", true);
		} catch (e) {}	
	} else {
		//默认选中第一个
		try {
			$("#sidebarnav").children("li:first-child").addClass("active");
			$("#sidebarnav").children("li:first-child").children("a:first-child").attr("aria-expanded", true);
			if(document.getElementById("sidebarnav").firstChild.nextSibling.lastChild.firstChild.firstChild != null){
				//有下级菜单的点击
				document.getElementById("sidebarnav").firstChild.nextSibling.lastChild.firstChild.firstChild.click();
			} else {
				//没有下级菜单的点击
				document.getElementById("sidebarnav").firstChild.nextSibling.firstChild.firstChild.click();
			}
		} catch (e) {}	
	}
	
});

//有下级菜单的菜单点击方法
function changeState(obj) {
	//存按钮ID
	$("#btnId").val(obj.id);
	//删除cookie
	$.cookie('answereFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/wasAgentAnsweredList'});
	$.cookie('feedFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/FeedBack'});
	$.cookie('recordFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/RecordExamine'});
	
	// 先去除所有的active class
	var mark = $(obj).hasClass("menu-mark");
	if(!mark){
		$.cookie('VicmobAgentSystemMenuId', obj.id); 
		$("li").removeClass("active");
		$("a").removeClass("active");
		// 添加active
		$(obj).addClass("active");
		if ($(obj).parent() != null) {
			if ($(obj).parent().parent() != null) {
				if ($(obj).parent().parent().prev() != null) {
					$(obj).parent().parent().prev().addClass("active");
				}
			}
		}
		if ($(obj).parent() != null) {
			if ($(obj).parent().parent() != null) {
				if ($(obj).parent().parent().parent() != null) {
					$(obj).parent().parent().parent().addClass("active");
					if ($(obj).parent().parent().parent().parent() != null) {
						if ($(obj).parent().parent().parent().parent().prev() != null) {
							$(obj).parent().parent().parent().parent().prev().addClass("active");
						}
					}
				}
			}
		}
	}
	$('.menu-single-mark').parent().removeClass("active");
	//给顶部赋值
	if(!$(obj).hasClass("menu-mark") && !$(obj).hasClass("a-mark")){
		$("#indexTitle").html(obj.innerText);
		var tip = "";
		if($(obj).parent().parent()!= null){
			var objPr = $(obj).parent().parent().prev();
			if(!$(objPr).hasClass("menu-mark")){
				if($(obj).parent().parent().parent().parent() != null){
					var objPar = $(obj).parent().parent().parent().parent().prev();
					tip = tip + '<li class="breadcrumb-item">'+ objPar.text() +'</li>';
				}
			}
		}
		if($(obj).parent().parent()!= null){
			if($(obj).parent().parent().prev() != null){
				var objPar = $(obj).parent().parent().prev();
				tip = tip + '<li class="breadcrumb-item">'+ objPar.text() +'</li>';
			}
		}
		tip = tip + '<li class="breadcrumb-item">'+ obj.innerText +'</li>';
		$("#indexTip").html(tip);
	}
	
}
//没有下级菜单的菜单点击方法
function changeMyState(obj) {
	//存按钮ID
	$("#btnId").val(obj.id);
	//删除cookie
	$.cookie('answereFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/wasAgentAnsweredList'});
	$.cookie('feedFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/FeedBack'});
	$.cookie('recordFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/RecordExamine'});
	
	$.cookie('VicmobAgentSystemMenuId', obj.id); 
	// 先去除所有的active class
	var mark = $(obj).hasClass("menu-mark");
	$("li").removeClass("active");
	$("a").removeClass("active");
	
	$(".in").removeClass("in");
	// 添加active
	$(obj).addClass("active");
	$(obj).parent().addClass("active");
	$("#indexTip").html(obj.innerText);
	$("#indexTitle").html(obj.innerText);
}
//cookie删除方法
function delCookie() {
	$.cookie('VicmobAgentSystemMenuId', null); 
	$.cookie('answereFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/wasAgentAnsweredList'});
	$.cookie('feedFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/FeedBack'});
	$.cookie('recordFlag',null,{path:'/VicmobAgentSystem/a/agentSystem/RecordExamine'});
}

//跳转至终端列表
function jumpTerminalList(){
	$("#d27fba1272a44378910684252a3b6893").click();
}
//跳修改密码页面
function changePassword(loginName) {
	top.layer.open({
		title:'修改密码',
		area: ['400px', '320px'],
		type:1,
		skin: 'layui-layer-lan',
		btn: ['确认','取消'], //按钮
		scrollbar: false,
		content : '<form id="sendForm" style="padding-bottom: 10px;padding-top: 10px;">'+
					'<div class="form-group row" style="margin-right: 0px;margin-left: 0px;"><label for="example-text-input" class="col-3 col-form-label">用户名：</label><div class="col-8 controls"><input  style="white-space: pre-wrap;" autocomplete="off" type="text" name="loginName" readonly="readonly" class="form-control height-control" value="'+loginName+'"></div></div>'+
					'<div class="form-group row" style="margin-right: 0px;margin-left: 0px;"><label for="example-text-input" class="col-3 col-form-label">原密码：</label><div class="col-8 controls"><input  style="white-space: pre-wrap;" autocomplete="off" type="text" name="oldPassword" class="form-control height-control"></div><div id="messageBox"></div></div>'+
					'<div class="form-group row" style="margin-right: 0px;margin-left: 0px;"><label for="example-text-input" class="col-3 col-form-label">新密码：</label><div class="col-8 controls"><input  style="white-space: pre-wrap;" autocomplete="off" type="text" id="changeNewPassword" name="changeNewPassword" class="form-control height-control"></div></div>'+
					'<div class="form-group row" style="margin-right: 0px;margin-left: 0px;"><label for="example-text-input" class="col-3 col-form-label">确认密码：</label><div class="col-8 controls"><input style="white-space: pre-wrap;" autocomplete="off" type="text" id="changeConfirmNewPassword" name="changeConfirmNewPassword" class="form-control height-control"></div></div>'+
					'</form>',
		success: function(layero, index){
			changeVerify();	
		},
		yes:function(){
			var isValid = $("#sendForm").valid(); 
			if(isValid){						  
				   var url = "/VicmobAgentSystem/a/affirmChange";
		           var data = $('#sendForm').serialize();
		           $.post(url,data,function(result){	            	
		               if(result == "OK"){
		                	$("#messageBox").html('<span></span>');
		                	layer.msg("密码修改成功！",{icon:1,time:1500,offset: '40%'},function(){
		                		window.location.href="/VicmobAgentSystem/a";						    			
							});
		               }else if(result == "validateFailure"){	                	
		                    $("#messageBox").html('<span style="color:red;font-size: 13px;margin-left: 120px;">原始密码错误，请核对后重新输入</span>');  
		               }else if(result == "error"){
		                	$("#messageBox").html('<span style="color:red;font-size: 13px;margin-left: 120px;">系统出错，请稍后修改</span>'); 	                    
		               }
		           });
			   }
		},
	});
	$(".layui-layer-title").addClass("layuiLayerTitle");
	$(".layui-layer-btn0").addClass("layuiBtn");
}

//密码校验
function changeVerify(){
	jQuery.validator.addMethod("isRightPasswordForm", function(value, element) {
        var rightPasswordForm = /^[a-zA-Z0-9]{6,20}$/;
        return (rightPasswordForm.test(value));
    }, "密码只能由字母数字组成"); 
    jQuery.validator.addMethod("isRightUserNameForm", function(value, element) {
        var rightUserNameForm = /^[a-zA-Z0-9]{0,20}$/;
        return (rightUserNameForm.test(value));
    }, "用户名只能由字母数字组成，且只能以字母开头"); 
    
    jQuery.validator.addMethod("isTheSame", function(value, element) {
    	var newPassWord = $("#changeConfirmNewPassword").val();
    	var confirePassWord = $("#changeNewPassword").val();
    	if(newPassWord == confirePassWord){
    		return true;
    	} else {
    		return false;
    	}
    }, "请输入一样的"); 
    
	$("#sendForm").validate({
		rules:{
			loginName:{
				required:true,//必填
				maxlength:15,//最多15个字符
				remote: "/VicmobAgentSystem/a/sys/user/validateLoginNameExist",
				isRightUserNameForm:true,
			},
			oldPassword:{
				required:true,
				minlength:6, 
				maxlength:20,
				isRightPasswordForm:true,
			},
			changeNewPassword:{
				required:true,
				minlength:6, 
				maxlength:20,
				isRightPasswordForm:true,
			},
			changeConfirmNewPassword:{
				required:true,
				minlength:6,
				isTheSame:true,
			},
		},
		//错误信息提示
		messages:{
			loginName:{
				required:"用户名不能为空",	    				
				maxlength:"用户名至多为15个字符",
				remote: "请输入正确的用户名",
			},
			oldPassword:{
				required:"密码不能为空",
				minlength:"密码至少为6个字符",
				maxlength:"密码至多为20个字符",
			},
			changeNewPassword:{
				required:"密码不能为空",
				minlength:"密码至少为6个字符",
				maxlength:"密码至多为20个字符",
			},
			changeConfirmNewPassword:{
				required: "请再次输入密码",
				minlength: "确认密码不能少于6个字符",
				isTheSame: "两次输入密码不一致",//与另一个元素相同
			},  		
		},
		
        errorPlacement: function(error, element) {
            error.insertAfter(element);
        } 
	});
}

//iframe的点击监听
var timeHandle;
function setEvent() {
	try {
		window.frames[0].document.body.onclick = function() {
			$("#headLogo").click();
		}
	} catch (e) {}
	timeHandle = setTimeout(setEvent, 200);
}
setEvent();

