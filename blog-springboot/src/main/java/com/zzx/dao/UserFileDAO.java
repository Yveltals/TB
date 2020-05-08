package com.zzx.dao;

import com.zzx.model.pojo.UserFile;
import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface UserFileDAO {

    //根据id查询
    List<UserFile> findByUserId(Integer id);

    //保存文件记录
    void save(UserFile userFile);

    //根据id获取文件信息
    UserFile findById(Integer id);

    //根据id删除文件
    void delete(Integer id);
}
