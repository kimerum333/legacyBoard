package com.spring.user.controller;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.CodeVo;
import com.spring.common.CommonUtil;
import com.spring.user.service.UserService;
import com.spring.user.vo.UserVo;

@Controller
@RequestMapping(value="/user")
public class UserController {
	
	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	@Autowired
	private UserService userService;
	@Autowired
	private BoardService boardService;
	
	public UserController(){
	}


	
	public UserController(UserService userService){
		this.userService = userService;
	}
	
	@RequestMapping(value="/join.do", method=RequestMethod.GET)
	public String userJoin(Locale locale, Model model) throws Exception{
		logger.info("userJoin worked");
		List<CodeVo> codeList=boardService.selectCode("phone");
		
		model.addAttribute("codeList", codeList);
		return "user/userJoin";
	}
	
	
	@RequestMapping(value="/insertUser.do", method=RequestMethod.POST)
	@ResponseBody
	public String insertUser(Locale locale, UserVo user) throws Exception{
		
		Map<String,String> result = new HashMap<>();
		
		logger.info("신규가입회원정보"+user.toString());
		int resultCnt = userService.insertUser(user);
		result.put("success", (resultCnt > 0)?"Y":"N");
		result.put("userName", (user.getUserName() != null)? user.getUserName():"익명");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);

		return callbackMsg;
	}
	
	@RequestMapping(value="/{userId}/duplicateCheck.do",method=RequestMethod.GET)
	@ResponseBody
	public String duplicateCheckUser(Locale locale, @PathVariable("userId") String userId) throws IOException {
		
		Map<String,String> result = new HashMap<>();
		
		logger.info("ID 중복확인시도"+userId);
		
		Integer ok = userService.duplicateCheckUser(userId);
		logger.info("ID 중복확인결과"+ok);

		result.put("success", (ok == 0)?"Y":"N"); // success라는 제목으로 String된 JSON을 넣는다.
		if(ok==0) {
			result.put("userId", userId);
		}
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		//IO Exception = Json변환과정에서 에러 가능성

		logger.info("callbackMsg::"+callbackMsg);

		return callbackMsg;
	}
	
	@RequestMapping(value="/login.do", method=RequestMethod.GET)
	public String login(Locale locale) {
		return "user/userLogin";
	}

	
	
	@RequestMapping(value="/login.do", method=RequestMethod.POST)
	@ResponseBody
	public String loginAction(UserVo user, HttpServletRequest request) throws IOException {
		logger.info("로그인 시도 :"+user.toString());
		
		Map<String,String> result = new HashMap<>();
		
		UserVo loginUser = userService.login(user);
		if(loginUser==null) {
			logger.info("존재하지 않는 아이디로 로그인 시도, 시도 아이디:"+user.getUserId());
			result.put("success","wrongId");
		}else if(!user.getUserPw().equals(loginUser.getUserPw())){
			logger.warn("비밀번호 입력오류, 시도 아이디:"+user.getUserId());
			result.put("success","wrongPw");
		}else {
			logger.info("로그인 성공, 시도 아이디: "+user.getUserId());
			result.put("success","loged in");
			HttpSession session = request.getSession();
			session.setAttribute("loginUser", loginUser);
		}
		
		String callbackMsg = CommonUtil.getJsonCallBackString(" ", result);
		
		return callbackMsg;
	}
	@RequestMapping(value="/logout.do", method=RequestMethod.GET)
	public String logout(Locale locale, HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
		return "redirect:/board/boardList.do";
	}
}
