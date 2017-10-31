package cn.thu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.thu.bean.User;

public interface UserDao {
	
	public User selectUserById(Integer userId);
	public User selectUserByName(String userName);
	public User insertUser(@Param("userName")String userName,@Param("userPassword")String userPassword,@Param("userEmail")String userEmail);
	public List<User> findAllUsers();

}
