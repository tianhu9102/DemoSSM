<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<html>  
<body>  
<h2><center>Hello DemoSSM </center></h2>

<form method="post" align="center">
	<input id="search" type="text">
	<input value="查询" type="submit">
</form>
 
     <table width="90%" border="1" align="center">  
        <thead>  
           <tr>  
                <td colspan="10"  align="center">  用户信息管理</td>  
           </tr>        
        </thead>   
        <tr align="center">  
            <td>用户序号</td>
			<td>用户姓名</td>
			<td>用户密码</td>
			<td>用户邮箱</td> 
        </tr>  
        
        <c:forEach items="${clients}" var="c">  
	       <tr>  
	         <td> ${c.id}  </td>  
	         <td> ${c.username} </td>  
	         <td> ${c.client_certificate_no} </td>  
	         <td> ${c.born_date} </td>  
	         <td> ${c.family_register_address} </td>  
	         <td> ${c.now_address} </td>  
	         <td> ${c.contact_mode} </td>  
	         <td> ${c.urgency_contact_mode} </td>  
	         <td> ${c.create_date} </td>  
	         <td><a href="">查看</a></td>  
	       </tr>  
	     </c:forEach>  
	  </tbody>  
 
</body>  

<script type="text/javascript">
	
</script>

</html> 