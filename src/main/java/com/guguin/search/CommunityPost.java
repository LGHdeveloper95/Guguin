package com.guguin.search;

public class CommunityPost {
    private String conum;      // 게시글 번호
    private String notTitle;   // 게시글 제목
    private String notContent; // 게시글 내용
    private String userid;     // 작성자 아이디
    private int views;         // 조회수

    // Getter와 Setter
    public String getConum() {
        return conum;
    }

    public void setConum(String conum) {
        this.conum = conum;
    }

    public String getNotTitle() {
        return notTitle;
    }

    public void setNotTitle(String notTitle) {
        this.notTitle = notTitle;
    }

    public String getNotContent() {
        return notContent;
    }

    public void setNotContent(String notContent) {
        this.notContent = notContent;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }
}