<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>DemoSSM</title>
</head>
<body>

<br>
<br>
<br>
<br>
<form name="formLogin" action="${pageContext.servletContext.contextPath}/user/rgister" method="post">
	<table width="400" border="1" align="center">
	
		<tr>
			<td>用户名：</td>
			<td><input type="text" name="userName"> </td>
		</tr>
		<tr>
			<td>密码：</td>
			<td><input type="text" name="userPassword"> </td>
		</tr>
		<tr>
			<td>确认密码：</td>
			<td><input type="text" name="userPasswordConfirm"> </td>
		</tr>
		<tr>
			<td>邮箱：</td>
			<td><input type="text" name="userEmail"> </td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" name="submit" value="提交"/>
				<input type="reset" name="reset" value="重填"/>
			</td>
		</tr>
		
	</table>
</form>


</body>
</html>