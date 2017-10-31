package cn.thu.service;

import java.util.List;

import cn.thu.bean.User;

public interface UserService {
	 User selectUserById(Integer userId);  
	 
	 public boolean login(String userName,String userPassword);
	 
	 public User register(String userName,String userPassword,String email);
	 
	 public List<User> findAllUsers();
}
