package com.zzx.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * 点赞dao
 */
@Repository
@Mapper
public interface FavorDao {

    List<Integer> getFavor(Integer userId);

    /**
     * 根据id获取博文点赞数量
     * @return
     */
    Integer getFavorCount(Integer blogId);

    /**
     * 根据blogId删除点赞
     * @param blogId
     */
    void deleteFavorByBlogId(Integer blogId);
}
