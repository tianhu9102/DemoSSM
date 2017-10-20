package cn.thu.controller;

import javax.annotation.Resource;  

import org.springframework.stereotype.Controller;  
import org.springframework.web.bind.annotation.RequestMapping;  
import org.springframework.web.servlet.ModelAndView;

import cn.thu.bean.User;
import cn.thu.service.UserService;  
  
/** 
 * 功能概要：UserController 
 *  
 * @author linbingwen 
 * @since  2015年9月28日  
 */  
@Controller  
public class UserController {  
    @Resource  
    private UserService userService;  
      
    @RequestMapping("/")    
    public ModelAndView getIndex(){      
        ModelAndView mav = new ModelAndView("user");   
        User user = userService.selectUserById(3);  
        mav.addObject("user", user);   
        return mav;    
    }    
}  
