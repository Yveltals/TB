package com.zzx.model.pojo;

import lombok.Data;
import lombok.ToString;

import java.util.Date;

/**
 * 点赞
 */
@Data
@ToString
public class Favor {
    private Integer id;
    private Integer userId;
    private Integer blogId;
    private String blogTitle;
    private Date blogTime;

    public Favor(Integer id, Integer userId, Integer blogId, String blogTitle, Date blogTime) {
        this.id = id;
        this.userId = userId;
        this.blogId = blogId;
        this.blogTitle = blogTitle;
        this.blogTime = blogTime;
    }

    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getUserId() {
        return userId;
    }

    public void setUserId(Integer userId) {
        this.userId = userId;
    }

    public Integer getBlogId() {
        return blogId;
    }

    public void setBlogId(Integer blogId) {
        this.blogId = blogId;
    }

    public String getBlogTitle() {
        return blogTitle;
    }

    public void setBlogTitle(String blogTitle) {
        this.blogTitle = blogTitle;
    }

    public Date getBlogTime() {
        return blogTime;
    }

    public void setBlogTime(Date blogTime) {
        this.blogTime = blogTime;
    }
}
