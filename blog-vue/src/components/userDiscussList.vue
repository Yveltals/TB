<template>
  <div id="userBlogList">
    <div style="width: 100%; height: 840px;overflow:auto;">
      <div class="news_infos">
        <el-timeline>
          <el-timeline-item v-for="comment in commentList" :key="comment.id"  placement="top">
              <el-card>
              <div class="commentList">
                <span class="left p1">
                  <img style="height:50px;width:50px" :src="comment.user.avatar" 
                    onerror="javascript:this.src='../../static/images/defaultAvatar.png'"/>
                </span>
                <span class="right p1">
                  <div class="rightTop" style="text-align:left">
                    <el-link  class="userName" :underline="false">{{comment.user.name}}&nbsp;评论：&nbsp;</el-link>
                    <el-tag style="cursor: pointer;"  @click.native="router(comment.blog.id)">{{comment.blog.title}}</el-tag>
                  </div>
                  <div class="rightCenter" style="text-align:left">{{comment.body}}</div>
                </span>
              </div>
              </el-card>
          </el-timeline-item>

          <el-timeline-item v-if="commentList.length == 0" placement="top">
              <el-card>
              <span style="font-size: 16px">空空如也~</span>
              </el-card>
          </el-timeline-item>
        </el-timeline>
      </div>
      <div class="sidebar">
        <div class="about">
          <p class="avatar" onerror="javascript:this.src='../../static/images/defaultAvatar.png'">
            <img  :src="avatar" alt />
          </p>
          <p class="abname">{{userName}}&nbsp;&nbsp;&nbsp;{{gender}}</p>
          <p class="abname">关注：{{followingNum}}&nbsp;&nbsp;&nbsp;粉丝：{{followerNum}}</p>
          <p class="abname">{{job}}</p>
          <p class="abname">{{mail}}</p>
          <p class="abtext">{{summary}}</p>
        </div>
      </div>
    </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import blogOverView from '@/components/blogOverView'
  import blog from '@/api/blog'
  import date from '@/utils/date'
  import store from '@/store/store'
  import discuss from '@/api/discuss'
  import user from '@/api/user'
  export default {
    name: 'userDiscussList',
    data() {
      return {
        job:'',
        gender:'',
        mail:'',
        summary:'',
        followingNum:0,
        followerNum:0,
        avatar:'',
        commentList: [], //我的评论
      }
    },
    props:['userName'],  //实则username.........
    created(){
      this.getCommentList()
      this.getfollow()
    },
    watch: {
      '$route.path': function(){
        this.userName = this.$route.params.userName
        this.getCommentList()
        this.getUserInfoByName()
        this.getfollow()
      }
    },
    methods: {
      router(id){
        scrollTo(0, 0);
        this.$router.push({ //路由跳转
          path: '/blog/'+id
        })
      },
      getTime(time) {//将时间戳转化为几分钟前，几小时前
        return date.timeago(time);
      },
      getCommentList(){
        discuss.getDiscussByUserId(this.userName).then(response=>{
          // console.log(response.data)
          this.commentList = response.data
          this.getUserInfoByName()
        })
      },
      getfollow(){
        blog.followingNum(this.userName).then(res=>{
          this.followingNum = res.data
        })
        blog.followerNum(this.userName).then(res=>{
          this.followerNum = res.data
        })
      },
      getUserInfoByName(){ //用户信息 
          user.getUserInfoByName(this.userName).then(response=>{
            // console.info(response.data)
            var a = response.data
            this.gender = a.gender
            this.email = a.mail
            this.job = a.job
            this.mail = a.mail
            this.summary = a.summary
            this.avatar = a.avatar
          })
      },
    }
  }
</script>
<style>
  .commentList {
    width: 100%;
    margin: 0 auto;
  }
  .commentList .p1 {
    float: left;
  }
  .commentList .left {
    display: inline-block;
    width: 10%;
    height: 100%;
  }
  .commentList .left img {
    margin: 0 auto;
    width: 100%;
    border-radius: 50%;
  }
  .commentList .right {
    display: inline-block;
    width: 85%;
    margin-left: 5px;
  }
  .commentList .rightTop {
    height: 30px;
  }
  .commentList .rightTop .userName {
    color: #303133;
    margin-left: 10px;
    font-size: 16px;
    font-weight: bold;
  }
  .commentList .rightTop .timeAgo {
    color: #909399;
    margin-left: 10px;
    font-size: 15px;
  }
  .commentList .rightCenter {
    margin-left: 20px;
    line-height: 30px;
    height: 60px;
  }
  .news_infos .newsview img {
    max-width: 650px;
    height: auto;
  }
</style>
