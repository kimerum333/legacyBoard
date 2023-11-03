package com.spring.board.vo;

import java.util.ArrayList;
import java.util.List;

/**
 * @author kimer
 *
 */
public class BoardVo {
	
	private String 	boardType;
	private int 	boardNum;
	private String 	boardTitle;
	private String 	boardComment;
	private String 	creator="";
	private String	modifier;
	private int totalCnt;
	private List<BoardVo> boardVoList;
	private String boardTypeKr;
	private String creatorName;
	
	public BoardVo() {
		
	}
	public BoardVo(String boardTitle, String boardComment) {
		this.boardTitle = boardTitle;
		this.boardComment = boardComment;
	}
	
	public int getTotalCnt() {
		return totalCnt;
	}
	public void setTotalCnt(int totalCnt) {
		this.totalCnt = totalCnt;
	}
	public int getBoardNum() {
		return boardNum;
	}
	public void setBoardNum(int boardNum) {
		this.boardNum = boardNum;
	}
	public String getBoardType() {
		return boardType;
	}
	public void setBoardType(String boardType) {
		this.boardType = boardType;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public String getBoardComment() {
		return boardComment;
	}
	public void setBoardComment(String boardComment) {
		this.boardComment = boardComment;
	}
	public String getCreator() {
		return creator;
	}
	public void setCreator(String creator) {
		this.creator = creator;
	}
	public String getModifier() {
		return modifier;
	}
	public void setModifier(String modifier) {
		this.modifier = modifier;
	}
	public List<BoardVo> getBoardVoList() {
		return boardVoList;
	}
	public void setBoardVoList(List<BoardVo> boardVoList) {
		this.boardVoList = boardVoList;
	}
	public String getBoardTypeKr() {
		return boardTypeKr;
	}
	public void setBoardTypeKr(String boardTypeKr) {
		this.boardTypeKr = boardTypeKr;
	}
	public String getCreatorName() {
		return creatorName;
	}
	public void setCreatorName(String creatorName) {
		this.creatorName = creatorName;
	}
	@Override
	public String toString() {
		return "BoardVo [boardType=" + boardType + ", boardNum=" + boardNum + ", boardTitle=" + boardTitle
				+ ", boardComment=" + boardComment + ", creator=" + creator + ", modifier=" + modifier + ", totalCnt="
				+ totalCnt + ", boardVoList=" + boardVoList + ", boardTypeKr=" + boardTypeKr + ", creatorName="
				+ creatorName + "]";
	}
	
	
	
	
	
}
