package cn.thu.service;

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

}
