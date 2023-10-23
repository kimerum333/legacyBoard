package com.spring.user.service;

import com.spring.user.vo.UserVo;

public interface UserService {
	public int insertUser(UserVo user);

	public int duplicateCheckUser(String userId);

	public UserVo login(UserVo user);
}
