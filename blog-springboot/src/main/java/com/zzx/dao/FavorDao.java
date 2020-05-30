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
}
