package cn.thu.dao;

import cn.thu.bean.User;

public interface UserDao {
	
	public User selectUserById(Integer userId);
	public User selectUserByName(String userName);
}
