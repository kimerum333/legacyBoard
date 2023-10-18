package com.spring.user.controller;

import java.util.Locale;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.spring.user.vo.UserVo;

@Controller
@RequestMapping(value="/user")
public class UserController {
	@RequestMapping(method=RequestMethod.POST)
	public String insertUser(Locale locale, UserVo user) {
		
		return null;
	}
}
