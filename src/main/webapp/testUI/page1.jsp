<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>单列布局(常见布局1)</title>

<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/bootstrap/css/bootstrap.min.css">   --%>
<!-- 参考 https://blog.csdn.net/wang839305939/article/details/76178966 -->
 
<style>
	html,
	body{
		margin: 0;
        padding: 0;
        width: 100%;
        height: 100%;
	}
	
	.container{
		width:100%;
		height: 100%;
		margin:0 auto;
	}
	.box{
		width:100%;
		height:100%;
		text-align: center;
	}
	.header{
		width:100%;
		height:5%;
		background:orange;
	}
	.content{
		position:relative;
		width:80%;	
		height:95%;	
		margin:0 auto;
	}
	 .content_body{
        position: relative;
        background: olive; 
        height:92%;         
     }
     .content_footer{
         position: relative;
         height:6%;
         background: orangered;
     }
</style>

</head>



<body>

	<div class="container">
		<div class="box">
			<div class="header">header</div>
			<div class="content">
				<div class="content_body">body</div>
				<div class="content_footer">footer </div>
			</div>
		</div>
	</div>

</body>
</html>