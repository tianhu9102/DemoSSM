package cn.thu.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import cn.thu.bean.User;

public interface UserDao {
	//根据userId查询用户信息
	public User selectUserById(Integer userId);
	
	//查询所有用户信息
	public List<User> findAllUsers();
	
	//更新客户信息
	boolean updateUser(User user);
	
	//删除客户信息
	Integer  deleteUser( int userId);
	
	public User selectUserByName(String userName);
	
	public Integer insertUser(@Param("userName")String userName,@Param("userPassword")String userPassword,@Param("userEmail")String userEmail);
	
}
