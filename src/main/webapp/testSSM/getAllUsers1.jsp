<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>    
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>DemoSSM</title>
</head>

<!-- http://blog.csdn.net/zhangrongchao_/article/details/45918137 -->
<h2><center>${message}</center></h2>

 <body>  
 <div class="userdiv" align="center">
     <table border="1" cellpadding="10" cellspacing="0">  
    	<tr> 
    		<td>序号</td>
    		<td>用户名</td>
    		<td>密码</td>
    		<td>邮箱</td>
    		<td>操作</td>
    	</tr>
	    <c:forEach items="${mapping}" var="node">
			<tr>
				<td><c:out value="${node.value.userId}"></c:out> </td>
				<td><c:out value="${node.value.userName}"></c:out> </td>
				<td><c:out value="${node.value.userPassword}"></c:out> </td>
				<td><c:out value="${node.value.userEmail}"></c:out> </td>
				<td>
				    <a href="${pageContext.servletContext.contextPath}/testSSM/alterUser.jsp">修改</href></a> 
				    <a href="${pageContext.servletContext.contextPath}/user/deleteUser?id=${node.value.userId}">删除</href></a> 
				</td>
			</tr>
		</c:forEach>
		</table>
	</div>
	
</body>
</html>