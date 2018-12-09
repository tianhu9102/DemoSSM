package cn.thu.service;

import java.util.List;

import org.springframework.stereotype.Service;

import cn.thu.bean.User;


public interface UserService {
	public User selectUserById(Integer userId);  
	public List<User> findAllUsers();
	public boolean updateUser(User user);
	public Integer deleteUser(Integer userId);
	 
	public boolean login(String userName,String userPassword);
	 
	public Integer register(String userName,String userPassword,String email);
	 
}
