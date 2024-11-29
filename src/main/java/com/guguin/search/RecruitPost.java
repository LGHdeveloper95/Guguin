package com.guguin.search;

public class RecruitPost {
    private String recnum;     // 공고 번호
    private String rectitle;   // 공고 제목
    private String subtitle;   // 공고 부제목
    private String comname;    // 회사명
    private int views;         // 조회수
    private String picture;

    public String getPicture() {
		return picture;
	}

	public void setPicture(String picture) {
		this.picture = picture;
	}

	// Getter와 Setter
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

    public String getSubtitle() {
        return subtitle;
    }

    public void setSubtitle(String subtitle) {
        this.subtitle = subtitle;
    }

    public String getComname() {
        return comname;
    }

    public void setComname(String comname) {
        this.comname = comname;
    }

    public int getViews() {
        return views;
    }

    public void setViews(int views) {
        this.views = views;
    }
}