<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  String path = request.getContextPath();
  String basePath = request.getScheme()+"://"+request.getServerName()+":"+request.getServerPort()+path+"/";
%>
<html>
<head>
    <title>御品香</title>
</head>
<body>

登入成功!
<br>
您好! ${loginuser.userName}
<br>
<a href="${pageContext.servletContext.contextPath}/testSSM/login.jsp">返回</a>
</body>
</html>