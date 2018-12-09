<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  

<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>test LesWebView</title>

<script src="${pageContext.request.contextPath}/jslib/qt/qwebchannel.js"></script>

</head>

	<h2><center>testing LesWebView(Qt and Html communation)</center></h2>

 <body>  
 
 <div class="qtEvent" align="center">
	 <input type="button" value="提交Qt" onclick="sendToQt()">
 </div>

 <div class="userdiv" align="center">
     <table border="1" cellpadding="10" cellspacing="0">  
    	<tr> 
    		<td>序号</td>
    		<td>用户名</td>
    		<td>密码</td>
    		<td>邮箱</td>
    		<td>操作</td>
    	</tr>
	 </table>
 </div>
	
	<script>
	
		<!--  get parameters from qt -->
		function reciveJsonDataFromQt(jsonstr,functionname){
		    if(functionname=="gdp"){//sendArrayToHtmlSignal
		    	alert(functionname);
		        gdpFun(jsonstr)
		    }else{
		    	alert("method dosen't exists!");
		    }
		}

		//.... your action here
		function gdpFun(jsonstr){
				alert(jsonstr);
		}
		
		function reciveArrayDataFromQt(arraystr,functionname){
		       if(functionname=="aarymethod"){
		    	    alert(functionname);
		            aarymethod(arraystr);
		       }
		}

		// define in your way
		function aarymethod(arraystr){
			alert(arraystr);
		}
		
		
		function sendToQt(){		    
		    //object
		    var person = {firstName:"John", lastName:"Doe"};
		    
			new QWebChannel(qt.webChannelTransport,function(channel){
				var be = channel.objects.lesbridge;							
				be.reciveDataFromHtml(person);			
			});
		}
			    
	</script>
	
</body>
	
</html>