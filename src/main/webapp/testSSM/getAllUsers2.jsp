<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>  
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN" "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">

<html xmlns="http://www.w3.org/1999/xhtml">
<head>
    <title>Pagination 分页表格</title>
    <meta http-equiv="content-type" content="text/html; charset=UTF-8" /><link href="../demo.css" rel="stylesheet" type="text/css" />

    <script src="${pageContext.request.contextPath}/jslib/miniui/boot.js"></script>    
        
</head>

 <body>
		<!--Layout-->
		<div id="layout1" class="mini-layout" style="width:100%;height:100%;">
		    <div title="center" region="center">
	             <div class="mini-toolbar" style="padding:2px;border-bottom:0;">
			        <table style="width:100%;">
			            <tr>
			            <td style="width:100%;">
			                <a name="btnAdd" class="mini-button" iconCls="icon-add"       plain="true">增加</a>
			                <a name="btnEdit" class="mini-button" iconCls="icon-edit"     plain="true">修改</a>
			                <a name="btnDelete" class="mini-button" iconCls="icon-remove" plain="true">删除</a>
			                <span class="separator"></span>
			                <a name="btnRefresh" class="mini-button" iconCls="icon-reload" plain="true">刷新</a>
			            </td>
			            <td style="white-space:nowrap;">
			                <input id="search" class="mini-textbox" emptyText="请输入关键字" width="150"/>
			                <a name="btnSearch" class="mini-button" iconCls="icon-search" plain="true">查询</a>
			                </td>
			            </tr>
			        </table>
			    </div>
				    
			     <!--撑满页面-->
			    <div class="mini-fit" >
			        <div id="userGrid" class="mini-datagrid" style="width:100%;height:100%;" 
			        multiSelect="true" >
			            <div property="columns">
                            <div type="checkcolumn" ></div>
                            <div field="username"   allowSort="true"  width="120" align="center" headerAlign="center">员工号</div>
							<div field="realname"   allowSort="true"  width="120" align="center" headerAlign="center">姓名</div>
							<div field="birthday"    allowSort="true" width="120" align="center" headerAlign="center" dateFormat="yyyy-MM-dd">生日</div>
							<div field="gender"      allowSort="true" width="120" align="center" headerAlign="center" renderer="onGenderRenderer">性别</div>
							<div field="description" allowSort="true" width="120" align="center" headerAlign="center">描述</div>
			            </div>
			        </div> 
			    </div>
		    </div>
		 </div>
		  
        <script type="text/javascript">
       
             mini.parse();
             
             // 变量声明区
             var btnAdd = mini.getbyName("btnAdd"),
                 btnEdit = mini.getbyName("btnEdit"),
                 btnDelete = mini.getbyName("btnDelete"),
                 btnRefresh = mini.getbyName("btnRefresh");
                 btnSearch = mini.getbyName("btnSearch");

             var grid = mini.get("userGrid");
             var search = mini.get("search");
             
             var genders = ${genders};
             
             grid.setUrl("${pageContext.servletContext.contextPath}/samples/crud/user/queryUserDataSet");//分页
             query();
             
             //函数定义区
             /**
              * 渲染性别
              */
             function onGenderRenderer(e) {
                 for (var i = 0, l = genders.length; i < l; i++) {
                     var g = genders[i];
                     if (g.id == e.value) return g.text;
                 }
                 return "";
             }

             /**
              * 查询表格
              */
             function query(){
            	 var key = mini.get("search").getValue(); 
            	 var params = {'username' : key};
            	 grid.load(params,function(){
            		 //success call back;
            		 
            	 });
             }
             
             /**
             * 增加人员弹出窗口
             */
             function add(){
           		 mini.open({
            		 url:"${pageContext.request.contextPath}/samples/crud/add.jsp",
            		 title:"新增人员",width: 600,height: 300,
            		 onload:function(){
            			 var iframe = this.getIFrameEl();
                         var data = { action: "new"};
                         iframe.contentWindow.SetData(data);
            		 },
            		 ondestroy:function(action){
            			 if(action=="save"){
                             mini.alert("添加成功","恭喜你",function(){
                                 grid.reload();
                             });
                         }
            		 }
            	 });
             }
             
             /**
              * 修改人员弹出窗口
              */
             function edit(){
                 var row=grid.getSelected();
            	 if(row){
	            	 mini.open({
	                     url:"${pageContext.request.contextPath}/samples/crud/edit.jsp",
	                     title:"编辑人员",width: 600,height: 300,
	                     onload:function(){
	                    	 var iframe = this.getIFrameEl();
	                         var data = { action: "edit", userid: row.userid};
	                         iframe.contentWindow.SetData(data);
	                     },
	                     ondestroy:function(action){
	                         if(action=="save"){
	                        	 mini.alert("修改成功","恭喜你",function(){
	                        		 grid.reload();
	                        	 });
	                         }
	                     }
	                 });
            	 } else{
            		 mini.alert("请先选择一条记录");
            	 }
             }
             
             /**
              * 批量删除人员
              */
             function remove(){
            	 var rows = grid.getSelecteds();
            	 if(rows.length > 0){
            		 mini.confirm("确定要删除这些记录?","提醒",function(msg){
                         if(msg=='ok'){
                             var ids = [];
                             for(var i = 0; i < rows.length; i++){
                            	 var r = rows[i];
                            	 ids[i] = r.userid;
                             }
                             var userids = ids.join(",");
                             console.log(userids);
                             grid.setUrl("${pageContext.request.contextPath}/samples/crud/user/removeUsers");
                             var params={ 'userids' : userids};
                             grid.load(params,function(){
                                 grid.setUrl('${pageContext.servletContext.contextPath}/samples/crud/user/queryUserDataSet');
                                 grid.load();
                             });
                         }
                     });
            		 
            	 } else{
            		 mini.alert("请先选择要删除的记录");
            	 }
             }
             
             /**
              * 表格刷新
              */
             function refresh(){
            	 grid.reload();
             }
             
             //事件绑定区
             
             // XX按钮 绑定 XXXX操作
             btnAdd.on('click', add);
             btnEdit.on('click', edit);
             btnDelete.on('click', remove);
             btnRefresh.on('click', refresh);
             btnSearch.on('click',query);
             search.on('enter',query);
                       
        </script>
  </body>
  
</html>