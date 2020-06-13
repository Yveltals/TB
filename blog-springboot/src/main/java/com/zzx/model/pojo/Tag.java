package com.zzx.model.pojo;

import lombok.Data;
import lombok.ToString;

import java.io.Serializable;

/**
 * 标签
 */
@Data
@ToString

public class Tag implements Serializable {

    /**
     * tag(36) => 37960(10)
     */
    private static final long serialVersionUID = 37960L;
    private Integer id;//id
    private String name;//标签名
    private Integer blogcnt; //对应博客数量
    private Integer cnt = 0; //推荐算法计数
    public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public Integer getBlogcnt() { return blogcnt; }

    public void setBlogcnt(Integer blogcnt) { this.blogcnt = blogcnt; }
}
