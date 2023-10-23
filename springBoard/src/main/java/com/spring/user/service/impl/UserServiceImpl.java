package com.spring.user.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.spring.user.dao.UserDao;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	
	public UserServiceImpl(){
	}

	
	public UserServiceImpl(UserDao userDao){
		this.userDao = userDao;
	}

	@Override
	public int insertUser(UserVo user) {

		return userDao.insertUser(user);
	}


	@Override
	public int duplicateCheckUser(String userId) {	
		return	userDao.duplicateCheckUser(userId);
	}


	@Override
	public UserVo login(UserVo user) {
		// TODO Auto-generated method stub
		return userDao.selectUser(user);
	}
	
}
