<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>DemoSSM</title>
</head>
<body>
${message}
<br>
<br>
<a href="${pageContext.servletContext.contextPath}/testSSM/login.jsp">返回</a>
</body>
</html>