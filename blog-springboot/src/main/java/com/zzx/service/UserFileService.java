package com.zzx.service;

import com.zzx.dao.UserDao;
import com.zzx.dao.UserFileDAO;
import com.zzx.model.pojo.User;
import com.zzx.model.pojo.UserFile;
import com.zzx.utils.JwtTokenUtil;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.servlet.http.HttpServletRequest;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class UserFileService {
    @Autowired
    private UserDao userDao;
    @Autowired
    private UserFileDAO userFileDAO;
    @Autowired
    private HttpServletRequest request;
    @Autowired
    private JwtTokenUtil jwtTokenUtil;


    public List<UserFile> findByUserId() {
        User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
        System.out.println(user.getId());
        return userFileDAO.findByUserId(user.getId());
    }


    public void save(UserFile userFile) {

        // User是通过token中信息获得的，自定义发送axios前必须存入token
        User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
        userFile.setUploadTime(new SimpleDateFormat("yyyy-MM-dd HH:mm:ss").format(new Date())).setUserId(user.getId());
        userFileDAO.save(userFile);

    }


    public UserFile findById(Integer id) {

        return userFileDAO.findById(id);
    }


    public void delete(Integer id) {

        userFileDAO.delete(id);
    }
}
