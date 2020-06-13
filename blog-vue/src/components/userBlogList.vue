<template>
  <div id="userBlogList">
    <div class="news_infos">
     <div style="min-height:470px">
        <div v-for="blog in blogList" :key="blog.id">
          <blogOverView :id="blog.id" :title="blog.title" :body="blog.body" :time="getTime(blog.time)"
                        :blogViews="blog.blogViews"
                        :discussCount="blog.discussCount" :tags="catchTagName(blog.tags)"
                        :name="blog.user.name"/>
        </div>
        <el-card class="box-card" style="margin: 20% " v-if="blogList.length <= 0">
          <div>
            还没发布过博客
          </div>
        </el-card>
     </div>
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
    <div class="sidebar">
        <div class="about">
          <p class="avatar">
            <img  v-if="!avatar" src="../../static/images/defaultAvatar.png" alt />
            <img  v-else-if="avatar.length<1" src="../../static/images/defaultAvatar.png" alt />
            <img  v-else :src="avatar" alt />
          </p>
          <p class="abname">{{userName}}&nbsp;&nbsp;&nbsp;{{gender}}</p>
          <p class="abname">关注：{{followingNum}}&nbsp;&nbsp;&nbsp;粉丝：{{followerNum}}</p>
          <p class="abname">{{job}}</p>
          <p class="abname">{{mail}}</p>
          <p class="abtext">{{summary}}</p>
        </div>
      </div>
  </div>
</template>
<script>
  import axios from 'axios'
  import blogOverView from '@/components/blogOverView'
  import blog from '@/api/blog'
  import user from '@/api/user'
  import date from '@/utils/date'
  import store from '@/store/store'
  export default {
    name: 'userBlogList',
    components: {blogOverView},
    data() {
      return {
        total: 0,        //数据总数
        blogList: [],   //当前页数据
        pageSize: 5,    //每页显示数量
        currentPage: 1,   //当前页数

        job:'',
        gender:'',
        mail:'',
        summary:'',
        followingNum:0,
        followerNum:0,
        avatar:'',
      }
    },
    props:['userName'],  //实际username
    created() {
      this.loadBlog();
    },
    watch: {
      '$route.path': function(){
        this.userName = this.$route.params.userName
        this.loadBlog()
      }
    },
    methods: {
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
      getTime(time) {//将时间戳转化为几分钟前，几小时前
        return date.timeago(time);
      },
      catchTagName(tag) { //从tag对象数组中拿到tag.Name属性
        var tagNames = [];
        for (var i = 0; i < tag.length; i++) {
          tagNames.push(tag[i].name)
        }
        return tagNames;
      },
      currentChange(currentPage) { //页码更改事件处理
        this.currentPage = currentPage;
        this.loadBlog();
        scrollTo(0, 0);
      },
      loadBlog() { //加载数据
        blog.getUserBlog(this.userName, this.currentPage, this.pageSize).then(responese => {
          // console.log(responese.data);
          this.total = responese.data.total;
          this.blogList = responese.data.rows;
        });
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
        blog.followingNum(this.userName).then(res=>{
          this.followingNum = res.data
        })
        blog.followerNum(this.userName).then(res=>{
          this.followerNum = res.data
        })
      }
    }
  }
</script>
<style scoped>
  #userBlogList {
    margin-top: -13px;
  }
</style>
