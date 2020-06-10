package com.zzx.controller;

import com.zzx.model.entity.PageResult;
import com.zzx.model.entity.Result;
import com.zzx.model.entity.StatusCode;
import com.zzx.model.pojo.User;
import com.zzx.service.FollowService;
import com.zzx.service.UserService;
import com.zzx.utils.FormatUtil;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/follow")
public class FollowController {

	@Autowired
	private FollowService followService;
	@Autowired
	private UserService userService;
	@Autowired
	private FormatUtil formatUtil;

	/**
	 * 关注用户
	 * @param userName
	 * @return
	 */
	@ApiOperation(value = "关注", notes = "用户id")
	@PreAuthorize("hasAuthority('USER')")
	@PostMapping("/new/{userName}")
	public Result newFollow(@PathVariable String userName) {
		Integer followingId  = userService.findUserByName(userName).getId();
		if (!formatUtil.checkPositive(followingId)) {
			return Result.create(StatusCode.ERROR, "参数错误");
		}
		try {
			followService.addFollowing(followingId);
			return Result.create(StatusCode.OK, "关注成功");
		} catch (RuntimeException e) {
			return Result.create(StatusCode.ERROR, e.getMessage());
		}
	}

	/**
	 * 移除关注
	 * @param userName
	 * @return
	 */
	@ApiOperation(value = "移除关注", notes = "用户id")
    @PreAuthorize("hasAuthority('USER')")
    @DeleteMapping("/remove/{userName}")
	public Result removeFollow(@PathVariable String userName) {
		Integer followingId  = userService.findUserByName(userName).getId();
		if(!formatUtil.checkPositive(followingId)) {
			return Result.create(StatusCode.ERROR, "参数错误");
		}
		try{
			followService.removeFollower(followingId);
			return Result.create(StatusCode.OK, "移除成功");
		}catch (RuntimeException e) {
			return Result.create(StatusCode.ERROR, e.getMessage());
		}
	}

	/**
	 * 关注用户列表查询
	 * @return
	 */
	@ApiOperation(value = "查询所有关注用户")
	@PreAuthorize("hasAuthority('USER')")
    @GetMapping("/myfollowing")
	public Result findFollowingByUser() {

		List<User> res = followService.findUserByFollower();
		PageResult<User> result = new PageResult<>(1L*res.size(),res);

		return Result.create(StatusCode.OK, "查询成功", result);
	}

	/**
	 * 粉丝列表查询
	 * @return
	 */
	@ApiOperation(value = "查询关注我的用户")
	@PreAuthorize("hasAuthority('USER')")
    @GetMapping("/myfollower")
	public Result findFollowerByUser() {

		List<User> res = followService.findUserByFollowing();
		PageResult<User> result = new PageResult<>(1L*res.size(),res);

		return Result.create(StatusCode.OK, "查询成功", result);
	}

	/**
	 * 是否关注此Name用户
	 */
	@GetMapping("/isfollow/{userName}")
	public Result isFollow(@PathVariable String userName){
		List<User> res = followService.findUserByFollower();
		for(User user: res){
			if(user.getName().equals(userName))
				return Result.create(StatusCode.OK, "查询成功", true);
		}
		return Result.create(StatusCode.OK, "查询成功", false);
	}
	/**
	 * 查询用户粉丝数
	 */
	@GetMapping("/followingNum/{userName}")
	public Result followingNum(@PathVariable String userName){
		Integer userId = userService.findUserByName(userName).getId();
		Long num =  followService.getFollowingCountById(userId);
		return Result.create(StatusCode.OK, "查询成功", num);
	}

	/**
	 * 查询用户关注数
	 */
	@GetMapping("/followerNum/{userName}")
	public Result followerNum(@PathVariable String userName){
		Integer userId = userService.findUserByName(userName).getId();
		Long num =  followService.getFollowerCountById(userId);
		return Result.create(StatusCode.OK, "查询成功", num);
	}
}
