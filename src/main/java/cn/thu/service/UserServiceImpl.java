package cn.thu.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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

	@Transactional
	public Integer  register(String userName, String userPassword, String email) {
		Integer  temp  = userDao.insertUser(userName, userPassword, email);
		if(temp==null){
			System.out.println("not insert user ...");
		}else{
			System.out.println("insert user ..."+ temp);
		}
		return temp;
	}

	public List<User> findAllUsers() {
		List<User> lists = userDao.findAllUsers();
		
		return lists;
	}

	public boolean updateUser(User user) {
		return userDao.updateUser(user);
	}

	@Transactional
	public Integer deleteUser(Integer userId) {
		return userDao.deleteUser(userId);
	}

}
