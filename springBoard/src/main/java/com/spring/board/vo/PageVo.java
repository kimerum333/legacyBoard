package com.spring.board.vo;

import java.util.List;

public class PageVo {
	
	private int pageNo = 0;
	private List<String> searchConditions;
	public int getPageNo() {
		return pageNo;
	}
	public void setPageNo(int pageNo) {
		this.pageNo = pageNo;
	}
	public List<String> getSearchConditions() {
		return searchConditions;
	}
	public void setSearchConditions(List<String> searchConditions) {
		this.searchConditions = searchConditions;
	}
	@Override
	public String toString() {
		return "PageVo [pageNo=" + pageNo + ", searchConditions=" + searchConditions + "]";
	}
	
	
	
}
