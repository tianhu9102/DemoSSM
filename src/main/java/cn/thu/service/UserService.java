package cn.thu.service;

import java.util.List;

import cn.thu.bean.User;

public interface UserService {
	public User selectUserById(Integer userId);  
	public List<User> findAllUsers();
	public int updateUser(User user);
	public int deleteUser(Integer userId);
	 
	 public boolean login(String userName,String userPassword);
	 
	 public User register(String userName,String userPassword,String email);
	 
}
