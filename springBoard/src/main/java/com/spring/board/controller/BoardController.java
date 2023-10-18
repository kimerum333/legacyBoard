package com.spring.board.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.spring.board.HomeController;
import com.spring.board.service.boardService;
import com.spring.board.vo.BoardVo;
import com.spring.board.vo.CodeVo;
import com.spring.board.vo.PageVo;
import com.spring.common.CommonUtil;

@Controller
public class BoardController {

	@Autowired
	boardService boardService;

	private static final Logger logger = LoggerFactory.getLogger(HomeController.class);

	//목록보기
	@RequestMapping(value = "/board/boardList.do", method = RequestMethod.GET)
	public String boardList(Locale locale, Model model,PageVo pageVo) throws Exception{
		

		//System.out.println(pageVo);
		//담을 리스트 사전 생성
		List<BoardVo> boardList = new ArrayList<>();
		List<CodeVo> codeList = new ArrayList<>();

		//Page상태를 알기 위한VO세팅

		int page = 1;
		int totalCnt = 0;

		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		//리스트 뽑는다
		boardList = boardService.SelectBoardList(pageVo);
		//토탈 뽑는다
		totalCnt = boardService.selectBoardCnt();
		//코드 뽑는다
		codeList = boardService.selectCode("menu");
		

		//모델에 전달
		model.addAttribute("boardList", boardList);
		model.addAttribute("totalCnt", totalCnt);
		model.addAttribute("pageNo", page);
		model.addAttribute("codeList", codeList);

		return "board/boardList";
	}
	
	@RequestMapping(value = "/board/anotherBoardList.do", method = RequestMethod.GET)
	@ResponseBody
	public Map<String,Object> anotherBoardList(Locale locale, PageVo pageVo) throws Exception{
		
		Map<String,Object> map = new HashMap<>();
		//담을 리스트 사전 생성
		List<BoardVo> boardList = new ArrayList<>();
		List<CodeVo> codeList = new ArrayList<>();

		//Page상태를 알기 위한VO세팅

		int page = 1;
		int totalCnt = 0;

		if(pageVo.getPageNo() == 0){
			pageVo.setPageNo(page);
		}
		//리스트 뽑는다
		boardList = boardService.SelectBoardList(pageVo);
		//토탈 뽑는다
		totalCnt = boardService.selectBoardCnt();
		//코드 뽑는다
		codeList = boardService.selectCode("menu");
		
		map.put("boardList", boardList);
		map.put("totalCnt", totalCnt);
		map.put("codeList", codeList);

		
		//모델에 전달
		return map;

	}
	

	//상세보기
	@RequestMapping(value = "/board/{boardType}/{boardNum}/boardView.do", method = RequestMethod.GET)
	public String boardView(Locale locale, Model model
			,@PathVariable("boardType")String boardType
			,@PathVariable("boardNum")int boardNum) throws Exception{

		BoardVo boardVo = new BoardVo();


		boardVo = boardService.selectBoard(boardType,boardNum);

		model.addAttribute("boardType", boardType);
		model.addAttribute("boardNum", boardNum);
		model.addAttribute("board", boardVo);

		return "board/boardView";
	}

	//작성창띄우기
	@RequestMapping(value = "/board/boardWrite.do", method = RequestMethod.GET)
	public String boardWrite(Locale locale, Model model) throws Exception{
		
		List<CodeVo> codeList = new ArrayList<>();
		codeList=boardService.selectCode("menu");
		model.addAttribute("codeList",codeList);
		return "board/boardWrite";
	}

	//실제 insert
	@RequestMapping(value = "/board/boardWriteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardWriteAction(Locale locale, BoardVo boardVo) throws Exception{
		
		
		HashMap<String, String> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = 0;
		//기본 1건
		resultCnt+=boardService.boardInsert(boardVo);
		
		//행추가로 들어오는 것들
		List<BoardVo> boardList = boardVo.getBoardVoList();
		if(boardList!=null) {
			for(BoardVo board:boardList) {
				//삭제되거나 빠진 넘버를 가진 추가행들 넘기기
				if(board.getBoardTitle()!=null) {
					resultCnt+=boardService.boardInsert(board);
				}
			}
		}
		String msg = String.format("\n%d boards registered",resultCnt);
		result.put("success", (resultCnt > 0)?msg:"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);

		return callbackMsg;
	}

	@RequestMapping(value = "/board/boardUpdateAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardUpdateAction(Locale locale,BoardVo boardVo) throws Exception{

		HashMap<String, String> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardUpdate(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);

		return callbackMsg;

	}

	@RequestMapping(value = "/board/boardDeleteAction.do", method = RequestMethod.POST)
	@ResponseBody
	public String boardDeleteAction(Locale locale,BoardVo boardVo) throws Exception{

		HashMap<String, String> result = new HashMap<>();
		CommonUtil commonUtil = new CommonUtil();

		int resultCnt = boardService.boardDelete(boardVo);

		result.put("success", (resultCnt > 0)?"Y":"N");
		String callbackMsg = CommonUtil.getJsonCallBackString(" ",result);

		System.out.println("callbackMsg::"+callbackMsg);

		return callbackMsg;

	}


}
