package com.zzx.service;

import com.zzx.dao.FavorDao;
import com.zzx.dao.UserDao;
import com.zzx.model.pojo.Blog;
import com.zzx.model.pojo.Favor;
import com.zzx.model.pojo.User;
import com.zzx.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.util.LinkedList;
import java.util.List;

@Service
public class FavorService {

    @Autowired
    private FavorDao favorDao;
    @Autowired
    private UserDao userDao;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;
    @Autowired
    private BlogService blogService;

    /**
     * 获取用户点赞记录
     *
     */
    public List<Favor> getFavor() throws IOException {
        User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
        List<Integer> blogId = favorDao.getFavor(user.getId());
        List<Favor> favors = new LinkedList<>();
        for(int i=0;i<blogId.size();++i){
            Blog blog = blogService.findBlogById(blogId.get(i),false);
            Favor favor = new Favor(i,user.getId(),blog.getId(),blog.getTitle(),blog.getTime());
            favors.add(favor);
        }
        return favors;
    }
}
