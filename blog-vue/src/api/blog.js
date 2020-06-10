import request from '@/utils/request'
import qs from 'qs';

export default {
  thumbUp(id){
    return request({
      url: '/blog/thumbUp/'+ id,
      method: 'post'
    })
  },
  getHotBlog() {
    return request({
      url: '/blog/hotBlog',
      method: 'get'
    })
  },
  getTopBlog() {
    return request({
      url: '/blog/topBlog',
      method: 'get'
    })
  },
  getStatisticalBlogByMonth() {
    return request({
      url: '/blog/statisticalBlogByMonth',
      method: 'get'
    })
  },
  getBlogHome(page, showCount) {//主页最新博客
    return request({
      url: '/blog/home/' + page + '/' + showCount,
      method: 'get'
    })
  },
  getRecommendFirst(page, showCount) { //recommendFirst 点赞排序
    return request({
      url: '/blog/recommendFirst/' + page + '/' + showCount,
      method: 'get'
    })
  },
  getBlogById(id, isClick) {
    return request({
      url: '/blog/' + id + '/' + isClick,
      method: 'get'
    })
  },
  getMyBlog(page, showCount) {
    return request({
      url: '/blog/myblog/' + page + '/' + showCount,
      method: 'get'
    })
  },
  getUserBlog(userName,page, showCount) {
    return request({
      url: '/blog/userblog/' +userName+ '/' + page + '/' + showCount,
      method: 'get'
    })
  },
  sendBlog(blogTitle, blogBody, tagId) {  //发布博客
    // alert(qs.stringify({'blogTitle': blogTitle, 'blogBody': blogBody,'tagId':tagId}))
    return request({
      url: '/blog',
      method: 'post',
      data: qs.stringify({'blogTitle': blogTitle, 'blogBody': blogBody, 'tagId': tagId})
    })
  },
  uploadImg(formdata) {
    return request({
      url: '/blog/uploadImg',
      method: 'post',
      data: formdata,
      headers: {'Content-Type': 'multipart/form-data'},
    })
  },
  editBlog(blogId, blogTitle, blogBody, tagId) {  //发布博客
    return request({
      url: '/blog/' + blogId,
      method: 'put',
      data: qs.stringify({'blogTitle': blogTitle, 'blogBody': blogBody, 'tagId': tagId})
    })
  },
  adminDeleteBlog(blogId) { //管理员删除博客
    return request({
      url: '/blog/admin/' + blogId,
      method: 'delete'
    })
  },
  adminBanBlog(blogId,state) { //管理员封禁博客
    return request({
      url: '/blog/ban/' + blogId+'/'+state,
      method: 'post'
    })
  },
  adminTopBlog(blogId,state) { //管理员置顶博客
    return request({
      url: '/blog/top/' + blogId+'/'+state,
      method: 'post'
    })
  },
  userDeleteBlog(blogId) { //普通用户删除博客
    return request({
      url: '/blog/' + blogId,
      method: 'delete'
    })
  },
  adminGetBlog(page, showCount) {
    return request({
      url: '/blog/AllBlog/' + page + '/' + showCount,
      method: 'get'
    })
  },
  adminSearchBlog(searchTxt, page, showCount) {
    return request({
      url: '/blog/searchAllBlog/' + page + '/' + showCount + '?search=' + searchTxt,
      method: 'get'
    })
  },
  userSearchBlog(searchTxt, page, showCount) {
    return request({
      url: '/blog/searchBlog/' + page + '/' + showCount + '?search=' + searchTxt,
      method: 'get'
    })
  },
  //关键字(标签)匹配接口
  userSearchBlogTag(searchTxt, page, showCount) {
    return request({
      url: '/blog/searchBlogTag/' + page + '/' + showCount + '?search=' + searchTxt,
      method: 'get'
    })
  },
  userSearchBlogTagCnt(searchTxt){
    return request({
      url: '/blog/searchBlogTag/'+searchTxt,
      method: 'get'
    })
  },
  followerNum(userName){
    return request({
      url: '/follow/followerNum/'+userName,
      method: 'get'
    })
  },
  followingNum(userName){
    return request({
      url: '/follow/followingNum/'+userName,
      method: 'get'
    })
  },
}
