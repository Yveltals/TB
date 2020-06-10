package com.zzx.dao;

import org.apache.ibatis.annotations.Mapper;
import org.springframework.stereotype.Repository;

import java.util.Date;
import java.util.List;

@Repository
@Mapper
public interface FollowDao {

	/**
	 *  关注列表 id
	 *  @param id
	 *  @return id
	 */
	List<Integer> findAllFollowingByUserId(Integer id);
	List<Integer> findAllFollowingAll();

	/**
	 * Follower 列表 id
	 * @param id
	 * @return id
	 */
	List<Integer> findAllFollowerByUserId(Integer id);

	/**
	 * 查询是否已关注
	 * @param followerid
	 * @param followingid
	 * @return
	 */
	Date findConnection(Integer followerid,Integer followingid);


	/**
	 *  新增关注
	 * @param followerid
	 * @param followingid
	 * @param time
	 */
	void addConnection(Integer followerid,Integer followingid, Date time);

	/**
	 * 移除关注
	 * @param followerid
	 * @param followingid
	 */
	void removeConnection(Integer followerid,Integer followingid);

	/**
	 * 关注数量
	 * @param followerid
	 * @return
	 */
	Long getFollowingCountbyId(Integer followerId);

	/**
	 * 粉丝数量
	 * @param followingId
	 * @return
	 */
	Long getFollowerCountbyId(Integer followingId);
}
