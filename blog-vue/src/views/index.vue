<template>
<div  style="background-image: url('../../static/images/bg.png')">
<article>
  <div class="picsbox">
      <!--banner end-->
      <recommendFirst></recommendFirst>
      <!-- 二级推荐 -->
      <div class="toppic">
        <li v-for="item in secondData" :key="item.id" @click="router(item.id)">
          <a href="javascript:void(0);">
            <i>
              <img :src="coverUrl(item.tags[0].name)" alt
                onerror="javascript:this.src='../../static/images/cover/css.jpg'">
            </i>
            <h2>{{item.title}}</h2>
            <span>{{item.tags[0].name}}</span>
          </a>
        </li>
      </div>
      <div class="blank"></div>

      <!--博文列表-->
      <div class="blogsbox">
        <div
          v-for="item in newBlogData"
          :key="item.id"
          class="blogs"
          data-scroll-reveal="enter bottom over 1s"
        >
          <h3 class="blogtitle">
            <a href="javascript:void(0);" @click="router(item.id)">{{item.title}}</a>
          </h3>

          <span class="blogpic">
            <a href="javascript:void(0);" @click="router(item.id)" title>
              <img :src="coverUrl(item.tags[0].name)" alt
                onerror="javascript:this.src='../../static/images/cover/css.jpg'">
            </a>
          </span>

          <p class="blogtext">{{item.title}}</p>
          <div class="bloginfo">
            <ul>
              <li class="author">
                <span class="iconfont">&#xe60f;</span>
                <a href="javascript:void(0);" @click="routerUser(item.user.name)">{{item.user.name}}</a>
              </li>
              <li class="lmname">
                <span class="iconfont">&#xe603;</span>
                <a href="javascript:void(0);" @click="routerTag(item.tags[0].name)">{{item.tags[0].name}}</a>
              </li>
              <li class="view">
                <span class="iconfont">&#xe8c7;</span>
                <span>{{item.blogViews}}</span>
              </li>
              <li class="like">
                <span class="iconfont">&#xe663;</span>
                {{item.favorCount}}
              </li>
              <li class="createTime">
                <span class="iconfont">&#xe606;</span>
                {{getTime(item.time)}}
              </li>
            </ul>
          </div>
        </div>
        <!--分页按钮-->
        <div>
          <el-pagination
            :pager-count="5"
            :page-size="pageSize"
            background
            layout="prev, pager, next"
            :total="total"
            @current-change="currentChange"
            :current-page="currentPage"
            @prev-click="currentPage=currentPage-1"
            @next-click="currentPage=currentPage+1">
          </el-pagination>
        </div>
    </div>
    <!--侧栏-->
    <div class="sidebar">
      <!--分类板块-->
      <tagCloud></tagCloud>
      <!-- 特别推荐 -->
      <recommendSide></recommendSide>
      <!--阅读排行-->
      <hotBlog></hotBlog>
      <!-- 相关链接-->
      <sideLink></sideLink>
    </div>

  </div>
</article>
</div>
</template>
<script>

import recommendFirst from '@/components/recommendFirst'
import sideLink from '@/components/sideLink'
import newDiscuss from '@/components/newDiscuss'
import hotBlog from '@/components/hotBlog'
import recommendSide from '@/components/recommendSide'
import tagCloud from '@/components/tagCloud'
import 'element-ui/lib/theme-chalk/display.css'
import { Loading } from 'element-ui';
import blog from '@/api/blog'
import date from '@/utils/date'

export default {
  name: 'index',
  components: {recommendFirst, newDiscuss, hotBlog, sideLink, recommendSide, tagCloud},
  data() {
    return{
      secondData: [],
      newBlogData: [],
      loading: false,
      loadingInstance: null, // loading对象
      pageSize: 7,
      total: 0,
      currentPage: 1
    }
  },
  created(){
    this.sideBlogList()
    this.newBlogList() 
  },
  methods :{
    routerUser(username) {
        scrollTo(0, 0);
        this.$router.push({
            path: '/userIndex/'+username
          })
      },
    sideBlogList() {
      blog.getTopBlog().then(response => {
        if(response.code == 200) {
          this.secondData.push (response.data[0]);
          this.secondData.push (response.data[1]);
      }});
    },
    coverUrl(tag){
      return "../../static/images/cover/"+tag+".jpg"
    },
    newBlogList() { //首页博文列表
      var that = this;
      that.loadingInstance = Loading.service({
        lock: true,
        text: '正在努力加载中……',
        background: 'rgba(0, 0, 0, 0.7)'
      })
      blog.getBlogHome(this.currentPage,this.pageSize).then(response => {
        if (response.code == 200) {
          that.newBlogData = response.data.rows;
          that.total = response.data.total;
        }
        that.loadingInstance.close();
      });
    },
    router(id) {
      scrollTo(0, 0);
      this.$router.push({ //路由跳转
        path: '/blog/'+id
      })
    },
    routerTag(tagName){
      scrollTo(0, 0);
      this.$router.push({ name:'classify',params:{tag:tagName}})
    },
    currentChange(currentPage) { //页码更改事件处理
      this.currentPage = currentPage;
      this.newBlogList();
      scrollTo(0, 500);
    },
    getTime(time) {//将时间戳转化为几分钟前，几小时前
      return date.timeago(time);
    },
  }
}
</script>
<style scoped>
</style>
