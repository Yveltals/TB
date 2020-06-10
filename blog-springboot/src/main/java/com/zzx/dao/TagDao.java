package com.zzx.dao;


import com.zzx.model.pojo.Tag;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
@Mapper
public interface TagDao {

    /**
     * 新增标签
     * @param tag
     */
    void saveTag(Tag tag);

    /**
     * 根据tag id更改标签
     * @param tag
     */
    void updateTagName(Tag tag);

    /**
     *根据tag id删除标签
     * @param id
     */
    void deleteTag(Integer id);
    void deleteBlogTag(Integer tagId);

    /**
     * 根据id查询标签
     * @param tagId
     * @return
     */
    Tag findTagById(Integer tagId);

    /**
     * 查询博文的所有标签
     * @param blogId
     * @return
     */
    List<Tag> findTagByBlogId(Integer blogId);

    /**
     * 根据博文id删除标签
     * @param blogId
     */
    void deleteTagByBlogId(Integer blogId);

    /**
     * 根据tagId删除blog_tag 的记录
     * @param tagId
     */
    void deleteTagByTagId(Integer tagId);

    /**
     * 根据标签名查询标签
     * @return
     */
    Tag findTagByTagName(String tagName);

    /**
     * 查询全部标签
     * @return
     */
    List<Tag> findTagAll();

    /**
     * 查询该tag下博客数量
     * @param id
     * @return
     */
    Integer findBlogCntByTag(Integer id);

    /**
     * 标签总数
     * @return
     */
    Long getTagCnt();

    /**分页查询标签
     * @param start
     * @param showCount
     * @return
     */
    List<Tag> findTagAllByPage(@Param("start") Integer start, @Param("showCount") Integer showCount);

    /**
     * 为无标签博文指定默认标签 ‘资料’
     */
    void addDefaultTag(Integer blogId,Integer tagId);
}
