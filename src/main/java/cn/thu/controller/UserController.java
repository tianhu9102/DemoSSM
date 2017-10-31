package cn.thu.controller;

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
  
/** 
 * 功能概要: UserController 
 *  
 * @author linbingwen 
 * @since  2015年9月28日
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
    	boolean loginType = userService.login(user.getUserName(), user.getUserPassword());
    	if (loginType) {
			request.setAttribute("loginuser", user);
			return "success";
		}else {
			request.setAttribute("message", "用户名或者密码错误");
			return "error";
		}
    }
    
    @RequestMapping("/rgister")
    public String register(User user,HttpServletRequest request){
    	userService.register(user.getUserName(), user.getUserPassword(),user.getUserEmail());
		request.setAttribute("message", "成功注册！欢迎您"+user.getUserName());
		return "tmpOK";
    }
    
    @RequestMapping("/findUserById")
    @ResponseBody
    public Map<String,Object> findUserById(@RequestParam Map<String, Object> map){
    	Integer id =   Integer.valueOf( (String) map.get("userId") );
    	
    	User user = userService.selectUserById(id);
 	
         Map<String,Object> mapResult = new HashMap<String,Object>();
         mapResult.put("username", user.getUserName());
         System.out.print("kkk:::"+user.getUserName());
         return mapResult;
    }

}  
