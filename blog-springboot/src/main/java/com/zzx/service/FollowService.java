package com.zzx.service;


import com.zzx.dao.FollowDao;
import com.zzx.dao.UserDao;
import com.zzx.model.pojo.Follow;
import com.zzx.model.pojo.User;
import com.zzx.utils.DateUtil;
import com.zzx.utils.JwtTokenUtil;
import org.assertj.core.util.Lists;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class FollowService {

	@Autowired
	private UserDao userDao;

	@Autowired
	private FollowDao followDao;

	@Autowired
    private DateUtil dateUtil;

	@Autowired
    private JwtTokenUtil jwtTokenUtil;

	@Autowired
    private HttpServletRequest request;

	/**
	 *  新增关注用户
	 *  @param followingId
	 */
	public void addFollowing(Integer followingId) {
		String username = jwtTokenUtil.getUsernameFromRequest(request);
		User user = userDao.findUserByName(username);

		if(followDao.findConnection(user.getId(),followingId) != null) {
			throw new RuntimeException("关注重复");
		}

		followDao.addConnection(user.getId(),followingId,dateUtil.getCurrentDate());
	}

	/**
	 *  移除关注用户
	 *  @param followingId
	 */
	public void removeFollowing(Integer followingId) {
		String username = jwtTokenUtil.getUsernameFromRequest(request);
		User user = userDao.findUserByName(username);

		if(followDao.findConnection(user.getId(),followingId) == null) {
			throw new RuntimeException("尚未关注");
		}
		followDao.removeConnection(user.getId(),followingId);
	}
	/**
	 * 移除粉丝
	 * @param followerId
	 */
	public void removeFollower(Integer followerId) {
		String username = jwtTokenUtil.getUsernameFromRequest(request);
		User user = userDao.findUserByName(username);

		followDao.removeConnection(user.getId(),followerId);
	}

	/**
	 * 查询用户 x 的所有关注者
	 * 即粉丝中有 x 的所有用户
	 * @return
	 */
	public List<User> findUserByFollower(){
		User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
		List<Integer> ids = followDao.findAllFollowingByUserId(user.getId());
		List<User> users = new ArrayList<User>();
		for(Integer i:ids) {
			users.add(userDao.findUserById(i));
		}
		return users;
	}

	/**
	 * 查询用户 x 的所有粉丝
	 * 即关注了 x 的所有用户
	 * @return
	 */
	public List<User> findUserByFollowing(){
		User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));

		List<Integer> ids = followDao.findAllFollowerByUserId(user.getId());
		List<User> users = new ArrayList<User>();
		for(Integer i:ids) {
			users.add(userDao.findUserById(i));
		}
		return users;
	}

	/**
	 * 查询当前用户关注数量
	 * @return
	 */
	public Long getFollowingCountbyId() {

		User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
		return followDao.getFollowingCountbyId(user.getId());
	}

	/**
	 * 查询当前用户粉丝数量
	 * @return
	 */
	public Long getFollowerCountbyId() {

		User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
		return followDao.getFollowerCountbyId(user.getId());
	}

	/**
	 * 查询用户的关注数量
	 * @param id 用户id
	 * @return
	 * @throws RuntimeException
	 */
	public Long getFollowingCountById(Integer id) throws RuntimeException {
		if(userDao.findUserById(id) == null)
			throw new RuntimeException("用户不存在");
		return followDao.getFollowingCountbyId(id);
	}

	/**
	 * 查询用户粉丝数量
	 * @param id 用户id
	 * @return
	 * @throws RuntimeException
	 */
	public Long getFollowerCountById(Integer id) throws RuntimeException {
		if(userDao.findUserById(id) == null)
			throw new RuntimeException("用户不存在");
		return followDao.getFollowerCountbyId(id);
	}

	/**
	 * 查询关注列表 返回Follow实体的List
	 * @return
	 */
	public List<Follow> getAllFollowing(){
		User user = userDao.findUserByName(jwtTokenUtil.getUsernameFromRequest(request));
		List<Integer> following = followDao.findAllFollowingByUserId(user.getId());
		List<Follow> res = Lists.newArrayList();
		for(Integer i:following) {
			Date time = followDao.findConnection(user.getId(),i);
			res.add(new Follow(time,i,user.getId()));
		}
		return res;
	}
}
