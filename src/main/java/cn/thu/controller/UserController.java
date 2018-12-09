package cn.thu.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import cn.thu.bean.User;
import cn.thu.service.UserService;
import cn.thu.util.SymmetricEncoder;  
  
/** 
 * 功能概要: UserController 
 *  
 * @author tianhu
 * @since  2017年11月20日
 */  
@Controller  
@RequestMapping("/user")
@Scope("prototype")
public class UserController {  
    @Resource(name="userService")
    private UserService userService;  
      
    @RequestMapping("/")    
    public ModelAndView getIndex(){      
        ModelAndView mav = new ModelAndView("user");   
        User user = userService.selectUserById(3);  
        mav.addObject("user", user);   
        return mav;    
    }  
    
    @RequestMapping("/login")
    public String login(User user,HttpServletRequest request){
    	
    	SymmetricEncoder symEndoer = new SymmetricEncoder();
    	String password = symEndoer.AESEncode("6825", user.getUserPassword());
    	System.out.println("6666 "+password);
    	boolean loginType = userService.login(user.getUserName(),password);
    	if (loginType) {
			request.setAttribute("loginuser", user);
			return "success";
		}else {
			request.setAttribute("message", "用户名或者密码错误");
			return "error";
		}
    }
    
    @RequestMapping("/rgister")
    public String register(HttpServletRequest request){
    	if(request.getParameter("userName")!="" &&
    	   request.getParameter("userPassword")!="" &&
    	   request.getParameter("userEmail")!=""){
    		
    		SymmetricEncoder symEndoer = new SymmetricEncoder();
    		String password = symEndoer.AESEncode("6825", request.getParameter("userPassword"));
    		
    		System.out.println("password???   "+password);
    		userService.register(request.getParameter("userName"), password,request.getParameter("userEmail"));
    		request.setAttribute("message", "成功注册！欢迎您"+request.getParameter("userName"));
    	}else{
    		request.setAttribute("message", "注册失败！姓名、密码、邮箱不能为空！");
    	}
		return "tmpOK";
    }
    
    @RequestMapping("/findUserById")
    @ResponseBody
    public Map<String,Object> findUserById(@RequestParam Map<String, Object> map){
    	 Integer id = Integer.valueOf( (String) map.get("userId") );
    	 User user = userService.selectUserById(id);
         Map<String,Object> mapResult = new HashMap<String,Object>();
         mapResult.put("User", user);
         System.out.println("返回用户:"+user);
         return mapResult;
    }
    
    @RequestMapping("/queryUserDataSets")
    @ResponseBody
    public ModelAndView queryAllUsers(@RequestParam Map<String,Object> map){
    	ModelAndView mav = new ModelAndView();  
    	mav.setViewName("getAllUsers");
    	mav.addObject("message", "用户列表--List实现形式");
    	
    	List<User> lists = userService.findAllUsers();
    	for(int i=0;i<lists.size();i++){
    		System.out.println(lists.get(i).getUserName());
    	}
        mav.addObject("userlists", lists);   
    	return mav; //getAllUsers.jsp
    }
    
    @RequestMapping("/queryUserDataSets1")
    @ResponseBody
    public ModelAndView queryAllUsers1(@RequestParam Map<String,Object> map){
    	ModelAndView mav = new ModelAndView();  
    	mav.setViewName("getAllUsers1");
    	mav.addObject("message", "用户列表1--Map实现形式");
    	
    	List<User> lists = userService.findAllUsers();
    	for(int i=0;i<lists.size();i++){
    		System.out.println(lists.get(i).getUserName());
    		map.put(String.valueOf(i), lists.get(i));
    	}
    	mav.addObject("mapping", map);
    	return mav; //getAllUsers1.jsp
    }
    
    @RequestMapping("/queryUserDataSets2")
    @ResponseBody
    public List<User> queryAllUsers2(@RequestParam Map<String,Object> map){
    	
    	List<User> lists = userService.findAllUsers();
    	return lists; //getAllUsers1.jsp	
    }
    
    @RequestMapping("/updateUser")
    public boolean updateUser(User user) {
    	System.out.println("kkk:::"+user);
    	
		return userService.updateUser(user);
	}
    
    @RequestMapping("/deleteUser")
    @ResponseBody
	public Integer deleteUser(@RequestParam(value="id") Integer userId) {
    	System.out.println("userId: "+userId);
    	Integer tmp = userService.deleteUser(userId);
    	
    	if(null==tmp){
    		System.out.println("delete not ok....");
    	}else{
    		System.out.println("delete ok...."+tmp);
    	}
    	
		return tmp;
	}

}  
