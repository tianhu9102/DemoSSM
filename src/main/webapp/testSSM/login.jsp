<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">

<link rel="stylesheet" type="text/css" href="${pageContext.servletContext.contextPath}/css/common.css" >
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/jslib/jquery/jquery-1.8.3-min.js"></script>
<%-- <script type="text/javascript" src="${pageContext.servletContext.contextPath}/jslib/vue/vue.min.js"></script>
 --%>
 <script src="https://cdn.staticfile.org/vue/2.4.2/vue.min.js"></script>
 
</head>


<body>

<div class='miaov_head'>
   <iframe MARGINWIDTH=0 MARGINHEIGHT=0 HSPACE=0 VSPACE=0 FRAMEBORDER=0 SCROLLING=no src="${pageContext.servletContext.contextPath}/testSSM/commfooter.jsp" width="100%"  height="auto">
   </iframe>
</div>

<div>
<form name="formLogin" action="${pageContext.servletContext.contextPath}/user/login" method="post">
	<table width="400" border="1" align="center">
		<tr>
			<td colspan="2"> <center>登录窗口</center></td>
		</tr>
		<tr>
			<td>用户名：</td>
			<td><input type="text" name="userName"> </td>
		</tr>
		<tr>
			<td>密码：</td>
			<td><input type="password" name="userPassword"> </td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" name="submit" value="登录"/>
				<input type="reset" name="reset" value="重置"/>
				<a href="${pageContext.servletContext.contextPath}/testSSM/register.jsp">注册</a>
				<a href="${pageContext.servletContext.contextPath}/user/queryUserDataSets1">所有用户</a>
			</td>
		</tr>
		
	</table>
</form>
</div>

<div id="app"> 
 	<h1> {{site}}</h1>
 	<h2> {{name}}</h2>
</div>

<script type="text/javascript">
	
	/*导入头部和尾部*/
	$(document).ready(function(){
		$("#footer").load("${pageContext.servletContext.contextPath}/testSSM/commfooter.jsp");
	});
	
	new Vue({
		el:"#app",
		data:{
			site:"tttp",
			name:"baidu"
		}
	})
		
</script>

</body>
</html>