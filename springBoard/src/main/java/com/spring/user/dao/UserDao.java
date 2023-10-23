package com.spring.user.dao;

import com.spring.user.vo.UserVo;

public interface UserDao {
	public int insertUser(UserVo user);

	public int duplicateCheckUser(String userId);

	public UserVo selectUser(UserVo user);
}
