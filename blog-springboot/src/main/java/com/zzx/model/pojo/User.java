package com.zzx.model.pojo;


import com.fasterxml.jackson.annotation.JsonIgnore;
import io.swagger.annotations.ApiModel;
import io.swagger.annotations.ApiModelProperty;
import lombok.Data;
import lombok.ToString;

import java.io.Serializable;
import java.util.List;

/**
 * 用户
 */
@Data
@ToString
@ApiModel("用户")
public class User implements Serializable {

    /**
     * user(36) => 1436499(10)
     */
    private static final long serialVersionUID = 1436499L;


    @ApiModelProperty(value = "用户id", dataType = "Integer")  //注解说明、重新定义...
    private Integer id;

    @ApiModelProperty(value = "用户名", dataType = "String")
    private String name;

    @ApiModelProperty(value = "密码", dataType = "String")
    private String password;

    @ApiModelProperty(value = "邮箱", dataType = "String")
    private String mail;

    @ApiModelProperty(value = "用户状态", dataType = "Integer")
    private Integer state;

    @ApiModelProperty(value = "性别", dataType = "String")
    private String gender;
    @ApiModelProperty(value = "生日", dataType = "Date")
    private String birth;
    @ApiModelProperty(value = "qq", dataType = "String")
    private String qq;
    @ApiModelProperty(value = "工作", dataType = "String")
    private String job;
    @ApiModelProperty(value = "简介", dataType = "String")
    private String summary;

    @ApiModelProperty(hidden = true)
    @JsonIgnore
    private List<Role> roles;

    private Login login;

    public String getGender() {
        return gender;
    }

    public void setGender(String gender) {
        this.gender = gender;
    }

    public String getBirth() {
        return birth;
    }

    public void setBirth(String birth) {
        this.birth = birth;
    }

    public String getQq() {
        return qq;
    }

    public void setQq(String qq) {
        this.qq = qq;
    }

    public String getJob() {
        return job;
    }

    public void setJob(String job) {
        this.job = job;
    }

    public String getSummary() {
        return summary;
    }

    public void setSummary(String summary) {
        this.summary = summary;
    }

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

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    public Integer getState() {
        return state;
    }

    public void setState(Integer state) {
        this.state = state;
    }

    public List<Role> getRoles() {
        return roles;
    }

    public void setRoles(List<Role> roles) {
        this.roles = roles;
    }

    public Login getLogin() {
        return login;
    }

    public void setLogin(Login login) {
        this.login = login;
    }
}
