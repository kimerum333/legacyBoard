package com.spring.user.dao.impl;

import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.spring.user.dao.UserDao;
import com.spring.user.vo.UserVo;

@Repository
public class UserDaoImpl implements UserDao {
	@Autowired
	private SqlSession sqlSession;
	
	

	@Override
	public int insertUser(UserVo user) {
		
		return sqlSession.insert("user.userInsert", user);
	}

	@Override
	public int duplicateCheckUser(String userId) {
		return sqlSession.selectOne("user.userDuplicateCheck",userId);
	}

	@Override
	public UserVo selectUser(UserVo user) {
		// TODO Auto-generated method stub
		return sqlSession.selectOne("user.selectUser",user);
	}
	
	

}