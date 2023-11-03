package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.BoardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.common.CommonUtil;

@Controller
@RequestMapping(value = "mbti/")
public class MbtiController {

	@Autowired
	BoardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);
	
	@RequestMapping(value="write.do", method = RequestMethod.GET)
	public String mbtiWrite(Locale locale,Model model) throws Exception {
		
		List<CodeVo> codeList = new ArrayList<>();
		codeList=boardService.selectCode("mbti");
		model.addAttribute("codeList",codeList);
		return "mbti/mbtiWrite";
	}
	
	@RequestMapping(value="writeAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String mbtiWriteAction(Locale locale,BoardVo boardVo) throws Exception {
		
		HashMap<String, String> result = new HashMap<>();
		
		boardVo.setBoardTitle("MBTI TITLE");
		logger.info("mbtiWrite worked:"+boardVo.toString());
		
		
		int resultCnt = boardService.boardInsert(boardVo);
		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);
		
		
		return callbackMsg;
	}
	
}
