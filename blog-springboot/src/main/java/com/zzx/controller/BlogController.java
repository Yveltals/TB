package com.zzx.controller;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.zzx.config.RedisConfig;
import com.zzx.model.entity.PageResult;
import com.zzx.model.entity.Result;
import com.zzx.model.entity.StatusCode;
import com.zzx.model.pojo.Blog;
import com.zzx.service.BlogService;
import com.zzx.utils.FormatUtil;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.IOException;

@Api(tags = "博文api", description = "博文api", basePath = "/blog")
@CrossOrigin
@RestController
@RequestMapping("/blog")
public class BlogController {

    private static final String IMAGE_JPG = ".jpg";

    private static final String IMAGE_PNG = ".png";

    @Autowired
    private BlogService blogService;

    @Autowired
    private FormatUtil formatUtil;

    @RequestMapping("/thumbUp/{blogId}")
    public Result thumbUp(@PathVariable Integer blogId){
        String message;
        if(blogService.thumbUpBlog(blogId)) message="点赞成功";
        else message="取消点赞";
        return Result.create(StatusCode.OK, message);
    }

    @ApiOperation(value = "上传图片", notes = "图片")
    @PreAuthorize("hasAuthority('USER')")
    @PostMapping("/uploadImg")
    public Result uploadImg(MultipartFile file) {
        if (!formatUtil.checkObjectNull(file)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        String fileFormat = formatUtil.getFileFormat(file.getOriginalFilename());

        if (null == fileFormat) {
            return Result.create(StatusCode.ERROR, "图片缺少格式");
        }

        if (!IMAGE_JPG.equals(fileFormat.toLowerCase()) && !IMAGE_PNG.equals(fileFormat.toLowerCase())) {
            return Result.create(StatusCode.ERROR, "图片格式错误");
        }
        try {
            String url = blogService.saveImg(file);
            return Result.create(StatusCode.OK, "上传成功", url);
        } catch (IOException ioe) {
            return Result.create(StatusCode.ERROR, "上传失败" + ioe.getMessage());
        }
    }


    /**
     * 保存博文，博文内容由前端md编辑器生成
     *
     * @param blogBody
     * @param blogTitle
     * @return
     */
    @ApiOperation(value = "发布博文", notes = "博文标题+博文内容+博文标签")
    @PreAuthorize("hasAuthority('USER')")
    @PostMapping
    public Result newBlog(String blogTitle, String blogBody, Integer[] tagId) {
        if (!formatUtil.checkStringNull(blogTitle, blogBody) || !formatUtil.checkPositive(tagId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        try {
            blogService.saveBlog(blogTitle, blogBody, tagId);
            return Result.create(StatusCode.OK, "发布成功");
        } catch (IOException e) {
            return Result.create(StatusCode.ERROR, "非法操作");
        }
    }


    @ApiOperation(value = "根据id查询博文", notes = "博文id")
    @GetMapping("/{blogId}/{isHistory}")
    public Result findBlogById(@PathVariable Integer blogId, @PathVariable boolean isHistory) {
        if (!formatUtil.checkObjectNull(blogId, isHistory)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        try {
            return Result.create(StatusCode.OK, "查询成功", blogService.findBlogById(blogId, isHistory));
        } catch (RuntimeException e) {
            return Result.create(StatusCode.NOTFOUND, "此博客不存在");
        } catch (IOException e) {
            return Result.create(StatusCode.ERROR, "此博客不存在");
        }

    }

    /**
     * 根据用户分页查询博文
     *
     * @param page      页数
     * @param showCount 显示条数
     * @return
     */
    @ApiOperation(value = "根据用户分页查询博文", notes = "页数+显示数量")
    @PreAuthorize("hasAuthority('USER')")
    @GetMapping("/myblog/{page}/{showCount}")
    public Result findBlogByUser(@PathVariable Integer page, @PathVariable Integer showCount) {

        if (!formatUtil.checkPositive(page, showCount)) {
            return Result.create(StatusCode.OK, "参数错误");
        }

        PageResult<Blog> pageResult =
                new PageResult<>(blogService.getBlogCountByUser(), blogService.findBlogByUser(page, showCount));

        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }

    @ApiOperation(value = "根据其他用户名分页查询博文", notes = "页数+显示数量")
    @GetMapping("/userblog/{userName}/{page}/{showCount}")
    public Result findBlogByUserName(@PathVariable String userName, @PathVariable Integer page, @PathVariable Integer showCount) {

        PageResult<Blog> pageResult =
                new PageResult<>(blogService.getBlogCountByUserName(userName), blogService.findBlogByUserName(userName,page,showCount));

        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }


    /**
     * 首页分页查询
     * 查询的范围在 最近10条博客 内
     *
     * @param page      页码
     * @param showCount 显示条数
     * @return
     */
    @ApiOperation(value = "首页分页查询博文", notes = "页数+显示数量")
    @GetMapping("/home/{page}/{showCount}")
    public Result homeBlog(@PathVariable Integer page, @PathVariable Integer showCount) {
        if (!formatUtil.checkPositive(page, showCount) || showCount > RedisConfig.REDIS_NEW_BLOG_COUNT) {
            return Result.create(StatusCode.OK, "参数错误");
        }

        try {
            PageResult<Blog> pageResult = new PageResult<>(blogService.getHomeBlogCount(), blogService.findHomeBlog(page, showCount));
            return Result.create(StatusCode.OK, "查询成功", pageResult);
        } catch (IOException e) {
            e.printStackTrace();
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }


    }

    /**
     * 首页recommendFirst
     * 查询的范围在 最近10条博客 内
     * @param page      页码
     * @param showCount 显示条数
     * @return
     */
    @ApiOperation(value = "首页分页查询博文", notes = "页数+显示数量")
    @GetMapping("/recommendFirst/{page}/{showCount}")
    public Result blogRecommendFirst(@PathVariable Integer page, @PathVariable Integer showCount) {
        if (!formatUtil.checkPositive(page, showCount) || showCount > RedisConfig.REDIS_NEW_BLOG_COUNT) {
            return Result.create(StatusCode.OK, "参数错误");
        }
        try {
            PageResult<Blog> pageResult = new PageResult<>(blogService.getHomeBlogCount(), blogService.findBlogOrderByFavor(page, showCount));
            return Result.create(StatusCode.OK, "查询成功", pageResult);
        } catch (IOException e) {
            e.printStackTrace();
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }


    }
    /**
     * 热门博文
     * 正常状态
     *
     * @return
     */
    @ApiOperation(value = "首页热门博文", notes = "首页热门博文")
    @GetMapping("/hotBlog")
    public Result hotBlog() {
        try {
            return Result.create(StatusCode.OK, "查询成功", blogService.findHotBlog());
        } catch (IOException e) {
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }
    }
    /**
     * 查询置顶博文
     */
    @ApiOperation(value = "首页置顶博文", notes = "首页置顶博文")
    @GetMapping("/topBlog")
    public Result topBlog() {
        try {
            return Result.create(StatusCode.OK, "查询成功", blogService.findTopBlog());
        } catch (Exception e) {
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }
    }


    /**
     * 博文搜索
     * 全文匹配
     *
     * @param search
     * @param page
     * @param showCount
     * @return
     */
    @ApiOperation(value = "分页全文匹配搜索博文", notes = "搜索内容+页码+显示条数")
    @GetMapping("/searchBlog/{page}/{showCount}")
    public Result searchBlog(String search,
                             @PathVariable Integer page,
                             @PathVariable Integer showCount) {
        if (!formatUtil.checkPositive(page, showCount) || showCount > RedisConfig.REDIS_NEW_BLOG_COUNT) {
            return Result.create(StatusCode.OK, "参数错误");
        }

        if (!formatUtil.checkStringNull(search)) {
            return Result.create(StatusCode.OK, "参数错误");
        }

        PageResult<Blog> pageResult = new PageResult<>(blogService.getSearchBlogCount(search),
                blogService.searchBlog(search, page, showCount));
        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }
    /**
     * 博文搜索
     * 按关键字(标签)
     *
     * @param search
     * @param page
     * @param showCount
     * @return
     */
    @ApiOperation(value = "分页关键字搜索博文", notes = "搜索内容+页码+显示条数")
    @GetMapping("/searchBlogTag/{page}/{showCount}")
    public Result searchBlogTag(String search,
                             @PathVariable Integer page,
                             @PathVariable Integer showCount) {
        if (!formatUtil.checkPositive(page, showCount) || showCount > RedisConfig.REDIS_NEW_BLOG_COUNT) {
            return Result.create(StatusCode.OK, "参数错误");
        }
        if (!formatUtil.checkStringNull(search)) {
            return Result.create(StatusCode.OK, "参数错误");
        }
        PageResult<Blog> pageResult = new PageResult<>(blogService.getSearchBlogCount(search),
                blogService.searchBlogTag(search, page, showCount));

        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }

    /**
     * 查询该标签博客数目
     * @param search
     * @return
     */
    @GetMapping("/searchBlogTag/{search}")
    public Result BlogTagCount(@PathVariable String search){
        Integer total = blogService.searchBlogTagCount(search);
        return Result.create(StatusCode.OK,"查询成功",total);
    }


    /**
     * 查询所有博客，包括删除状态
     *
     * @return
     */
    @ApiOperation(value = "管理员查询博文", notes = "管理员查询博文")
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/AllBlog/{page}/{showCount}")
    public Result findAllBlog(@PathVariable Integer page, @PathVariable Integer showCount) {
        if (!formatUtil.checkPositive(page, showCount)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        PageResult<Blog> pageResult = new PageResult<>(blogService.getAllBlogCount(), blogService.findAllBlog(page, showCount));

        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }

    @ApiOperation(value = "修改博文", notes = "博文id+博文标题+博文内容+博文标签")
    @PreAuthorize("hasAuthority('USER')")
    @PutMapping("/{blogId}")
    public Result updateBlog(@PathVariable Integer blogId, String blogTitle, String blogBody, Integer[] tagId) {

        if (!formatUtil.checkStringNull(blogTitle, blogBody)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }

        if (!formatUtil.checkPositive(tagId) || !formatUtil.checkPositive(blogId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }

        try {
            blogService.updateBlog(blogId, blogTitle, blogBody, tagId);
            return Result.create(StatusCode.OK, "修改成功");
        } catch (RuntimeException e) {
            return Result.create(StatusCode.ERROR, "修改失败" + e.getMessage());
        } catch (JsonProcessingException e) {
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }
    }


    @ApiOperation(value = "用户删除博文", notes = "博文id")
    @PreAuthorize("hasAuthority('USER')")
    @DeleteMapping("/{blogId}")
    public Result deleteBlog(@PathVariable Integer blogId) {
        if (!formatUtil.checkPositive(blogId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        try {
            blogService.deleteBlog(blogId);
            return Result.create(StatusCode.OK, "删除成功");
        } catch (RuntimeException e) {
            return Result.create(StatusCode.ERROR, "删除失败" + e.getMessage());
        } catch (JsonProcessingException e) {
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }
    }

    @ApiOperation(value = "管理员删除博文", notes = "博文id")
    @PreAuthorize("hasAuthority('ADMIN')")
    @DeleteMapping("/admin/{blogId}")
    public Result adminDeleteBlog(@PathVariable Integer blogId) throws JsonProcessingException {
        if (!formatUtil.checkPositive(blogId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        blogService.adminDeleteBlog(blogId);
        return Result.create(StatusCode.OK, "删除成功");
    }

    @ApiOperation(value = "管理员封禁博文", notes = "博文id")
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/ban/{blogId}/{state}")
    public Result adminBanBlog(@PathVariable Integer blogId, @PathVariable Integer state) throws JsonProcessingException {
        if (!formatUtil.checkPositive(blogId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        blogService.adminBanBlog(blogId,state);
        return Result.create(StatusCode.OK, "成功");
    }

    @ApiOperation(value = "管理员置顶博文", notes = "博文id")
    @PreAuthorize("hasAuthority('ADMIN')")
    @PostMapping("/top/{blogId}/{state}")
    public Result adminTopBlog(@PathVariable Integer blogId, @PathVariable Integer state) throws JsonProcessingException {
        if (!formatUtil.checkPositive(blogId)) {
            return Result.create(StatusCode.ERROR, "参数错误");
        }
        if(blogService.findTopBlog().size()<3 && state==1)
            return Result.create(StatusCode.OK, "至少需置顶两篇博客");
        blogService.adminTopBlog(blogId,state);
        if(state==1) return Result.create(StatusCode.OK, "取消置顶");
            else return Result.create(StatusCode.OK, "置顶成功");
    }

    @ApiOperation(value = "管理员分页搜索博文", notes = "搜索内容+页码+显示条数")
    @PreAuthorize("hasAuthority('ADMIN')")
    @GetMapping("/searchAllBlog/{page}/{showCount}")
    public Result searchAllBlog(String search,
                                @PathVariable Integer page,
                                @PathVariable Integer showCount) {

        if (!formatUtil.checkPositive(page, showCount)) {
            return Result.create(StatusCode.OK, "参数错误");
        }
        if (!formatUtil.checkStringNull(search)) {
            return Result.create(StatusCode.OK, "参数错误");
        }

        PageResult<Blog> pageResult = new PageResult<>(blogService.getSearchAllBlogCount(search),
                blogService.searchAllBlog(search, page, showCount));


        return Result.create(StatusCode.OK, "查询成功", pageResult);
    }


    @ApiOperation(value = "按月份归档博客", notes = "按月份归档博客")
    @GetMapping("/statisticalBlogByMonth")
    public Result statisticalBlogByMonth() {
        try {
            return Result.create(StatusCode.OK, "查询成功", blogService.statisticalBlogByMonth());
        } catch (IOException e) {
            return Result.create(StatusCode.SERVICEERROR, "服务异常");
        }
    }

}
