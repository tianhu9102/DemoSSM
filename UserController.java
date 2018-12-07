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
import cn.thu.util.SymmetricEncoder;

/**
 * 功能概要: UserController
 * 
 * @author linbingwen
 * @since 2015年9月28日
 */
@Controller
@RequestMapping("/user")
@Scope("prototype")
public class UserController
{
    @Resource(name = "userService")
    private UserService userService;

    @RequestMapping("/")
    public ModelAndView getIndex()
    {
        ModelAndView mav = new ModelAndView("user");
        User user = userService.selectUserById(3);
        mav.addObject("user", user);
        return mav;
    }

    @RequestMapping("/login")
    public String login(User user, HttpServletRequest request)
    {
        // 解密
        SymmetricEncoder se = new SymmetricEncoder();
        String encodeRules = "9837";
        String storePassword = se.AESEncode(encodeRules, user.getUserPassword());

        boolean loginType = userService.login(user.getUserName(), storePassword);
        if (loginType)
        {
            request.setAttribute("loginuser", user);
            return "success";
        }
        else
        {
            request.setAttribute("message", "登录失败，用户名或者密码错误");
            return "error";
        }
    }

    @RequestMapping("/rgister")
    public String register(String userName, String userPassword, String userPasswordConfirm, String userEmail,
                    HttpServletRequest request)
    {
        // private String userName;
        // private String userPassword;

        if (userPassword.equals(userPasswordConfirm))
        {
            // 加密
            SymmetricEncoder se = new SymmetricEncoder();
            String encodeRules = "9837";
            String storePassword = se.AESEncode(encodeRules, userPassword);

            userService.register(userName, storePassword, userEmail);
            request.setAttribute("message", "成功注册！欢迎您" + userName);

            return "tmpOK";
        }
        else
        {
            request.setAttribute("message", "2次密码不一致，注册失败！");

            return "error";
        }

    }

    @RequestMapping("/findUserById")
    @ResponseBody
    public Map<String, Object> findUserById(@RequestParam Map<String, Object> map)
    {
        Integer id = Integer.valueOf((String) map.get("userId"));

        User user = userService.selectUserById(id);

        Map<String, Object> mapResult = new HashMap<String, Object>();
        mapResult.put("User", user);
        System.out.println("返回用户:" + user);
        return mapResult;
    }

    @RequestMapping("/queryUserDataSets")
    @ResponseBody
    public Map<String, Object> queryAllUsers()
    {
        List<User> lists = userService.findAllUsers();
        for (int i = 0; i < lists.size(); i++)
        {
            System.out.println(lists.get(i).getUserName());
        }
        Map<String, Object> resultMap = new HashMap<String, Object>();
        resultMap.put("userList", lists);
        return resultMap;
    }

    @RequestMapping("/updateUser")
    public int updateUser(User user)
    {
        System.out.println("kkk:::" + user);

        return userService.updateUser(user);
    }

    @RequestMapping("/deleteUser")
    public int deleteUser(Integer userId)
    {

        int tmp = userService.deleteUser(userId);

        System.out.println("kkk:::" + userId + ", " + tmp);

        return tmp;
    }

}
