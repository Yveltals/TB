package com.zzx.model.pojo;

import java.util.Date;

import lombok.Data;
import lombok.ToString;

/**
 * 
 * 关注
 *
 */

@Data
@ToString
public class Follow{
	/**
	 * 关注时间
	 */
	private Date time;
	
	/**
	 * 关注的人 id
	 */
	private Integer followingId;
	
	/**
	 * 谁关注的 id
	 */
	private Integer followerId;
	
	public Follow(Date time,Integer followingId,Integer followerId) {
		this.time = time;
		this.followerId = followerId;
		this.followingId = followingId;
	}
	
}
