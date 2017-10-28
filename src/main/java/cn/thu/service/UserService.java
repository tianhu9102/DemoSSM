package cn.thu.service;

import cn.thu.bean.User;

public interface UserService {
	 User selectUserById(Integer userId);  
	 
	 public boolean login(String userName,String userPassword);
	 
	 public User register(String userName,String userPassword,String email);
}
