<%@ tag language="java" pageEncoding="UTF-8"%>
<%@ include file="/webpage/include/taglib.jsp"%>
<%@ attribute name="name" type="java.lang.String" required="true" description="验证码输入框名称"%>
<%@ attribute name="inputCssStyle" type="java.lang.String" required="false" description="验证框样式"%>
<%@ attribute name="imageCssStyle" type="java.lang.String" required="false" description="验证码图片样式"%>
<%@ attribute name="buttonCssStyle" type="java.lang.String" required="false" description="看不清按钮样式"%>
<input type="text" placeholder="验证码" id="${name}" name="${name}" maxlength="5" class="txt required" style="padding-left:10px;width:45px;${inputCssStyle}"/>
<img src="${pageContext.request.contextPath}/servlet/validateCodeServlet" onclick="$('.${name}Refresh').click();" class="mid ${name}" style="${imageCssStyle}"/>
<a href="javascript:" onclick="$('.${name}').attr('src','${pageContext.request.contextPath}/servlet/validateCodeServlet?'+new Date().getTime());" class="mid ${name}Refresh" style="${buttonCssStyle}">看不清</a>