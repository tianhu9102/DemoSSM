package cn.thu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import cn.thu.bean.User;
import cn.thu.dao.UserDao;

@Service(value="userService")
public class UserServiceImpl implements UserService{
	@Autowired
	private UserDao userDao;
	
	public User selectUserById(Integer userId) {
		return userDao.selectUserById(userId);
	}

	public boolean login(String username, String userpassword) {
		User user = userDao.selectUserByName(username);
		if (user!=null) {
			if (user.getUserName().equals(username)&&
					user.getUserPassword().equals(userpassword)) {
				return true;
			}
		}
		return false;
	}

	public User register(String userName, String userPassword, String email) {
		return userDao.insertUser(userName, userPassword, email);
	}

	public List<User> findAllUsers() {
		List<User> lists = userDao.findAllUsers();
		
		return lists;
	}

	public int updateUser(User user) {
		return userDao.updateUser(user);
	}

	public int deleteUser(Integer userId) {
		return userDao.deleteUser(userId);
	}

}
