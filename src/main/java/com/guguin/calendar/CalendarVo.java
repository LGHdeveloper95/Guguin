package com.guguin.calendar;




public class CalendarVo {
    private String recnum;
    private String rectitle;
    private String comname;
    private String startDate; // 시작일
    private String deadline;  // 마감일
    private int views;        // 조회수
    
    
	public String getComname() {
		return comname;
	}
	public void setComname(String comname) {
		this.comname = comname;
	}
	public String getRecnum() {
		return recnum;
	}
	public void setRecnum(String recnum) {
		this.recnum = recnum;
	}
	public String getRectitle() {
		return rectitle;
	}
	public void setRectitle(String rectitle) {
		this.rectitle = rectitle;
	}
	public String getStartDate() {
		return startDate;
	}
	public void setStartDate(String startDate) {
		this.startDate = startDate;
	}
	public String getDeadline() {
		return deadline;
	}
	public void setDeadline(String deadline) {
		this.deadline = deadline;
	}
	public int getViews() {
		return views;
	}
	public void setViews(int views) {
		this.views = views;
	}
       
    
}