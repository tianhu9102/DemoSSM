<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>御品香</title>
</head>
<body>
<h2>用户名集合：</h2>
<br>
<br>
<script type="text/javascript" src="${pageContext.servletContext.contextPath}/jslib/jquery/jquery-1.8.3-min.js"></script>
    
    <script type="text/javascript">
      $(document).ready(function() {
    	  $.ajax({
              type:"GET",
              url:"${pageContext.servletContext.contextPath}/user/findUserById",
              dataType:"json",
              contentType:"application/json;charset=UTF-8",
              data:{"userId":"66"},
              
              success:function(mapResult){
                  alert('欢迎你，'+mapResult.username);
              },
              error:function(){
                  alert("方法执行不成功!");
              }  
      	})
      	
      });

    </script>

</body>
</html>