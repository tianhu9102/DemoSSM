<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>双列布局(常见布局2)</title>

<%--     <link rel="stylesheet" href="${pageContext.request.contextPath}/jslib/bootstrap/css/bootstrap.min.css">
 --%>
 
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
		height:100%;
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
        height:95%;         
     }
     .content_left{
        background: orchid; 
        height:100%;     
        width:20%;  
        float:left;  
     }
     .content_right{
        background: yellowgreen; 
        height:100%;    
        width:80%;   
        float:right;    
     }
     .content_footer{
         position: relative;
         height:6%;
         background: orangered;
         width:100%; 
     }
</style>

</head>



<body>

	<div class="container">
		<div class="box">
			<div class="header">header</div>
			<div class="content">
				<div class="content_body">
					<div class="content_left">left </div>
					<div class="content_right">right </div>
				</div>
				<div class="content_footer">footer </div>
			</div>
		</div>
	</div>

</body>
</html>