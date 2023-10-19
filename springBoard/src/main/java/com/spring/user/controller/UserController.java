package com.spring.user.controller;

import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.board.HomeController;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	private final UserService userService;
	
	UserController(UserService userService){
		this.userService = userService;
	}
	
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception{
		logger.info("userJoin worked");
		return "user/userJoin";
	}
	
	
	@RequestMapping(value="insertUser.do", method=RequestMethod.POST)
	public String insertUser(Locale locale, UserVo user) throws Exception{
		logger.info("신규가입회원정보"+user.toString());
		return null;
	}
}
