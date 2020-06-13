<template>
<div  style="background-image: url('../../static/images/bg.png')">
  <article>
    <h1 class="t_nav">
      <a href="/" class="n1">网站首页</a>
      <a href="javascript:void(0);" @click="back()" class="n2">Back</a>
    </h1>
    <!--博文内容区域-->
    <div class="infosbox">
      <div class="newsview">
        <p style="display: none">{{blogId = this.$route.params.blogId}}</p>

        <h1 style="text-align: left">{{title}}</h1>
        <div style="text-align: left" class="bloginfo">
          <ul>
            <li class="author">
              <span class="iconfont">&#xe60f;</span>
              <a href="javascript:void(0);" @click="router(userName)">{{userName}}</a>
            </li>
            <li class="lmname">
              <span class="iconfont">&#xe603;</span>
              <a>慢生活</a>
            </li>
            <li class="createTime">
              <span class="iconfont">&#xe606;</span>
              {{getTime(time)}}
            </li>
            <li class="view">
              <span class="iconfont">&#xe8c7;</span>
              {{blogViews}}
            </li>
            <li>
              <span class="iconfont">&#58991;</span>
              {{discussCount}}
            </li>
            <li >
              <span class="iconfont">&#xe663;</span>
              {{favor}}
            </li>
          </ul>
        </div>
        <div style="text-align: left" class="tags">
          <a v-for="tag in catchTagName(tags)" :key="tag.id" href="javascript:void(0);" @click="routertag(tag)">{{tag}}</a>
        </div>
        <div style="text-align: left" class="news_about">
          <strong>版权</strong>
          本文为博客原创文章，转载无需和我联系，但请注明来自博客 http://www.123456.cn 
        </div>
        
        <mavon-editor  :boxShadow="false" codeStyle="atom-one-light"
            v-model="body" id="editor" :toolbarsFlag="false" :subfield="false" defaultOpen="preview"/>

        <div class="clearfix" >
          <el-divider/>
          <div style="float:left; width:100px;clear:both">
            <el-avatar shape="square" :size="80" :src="avatarURL" @error="true">
              <img src="https://cube.elemecdn.com/e/fd/0fc7d20532fdaf769a25683617711png.png"/>
            </el-avatar>
            <el-button v-if="state == 0" size="mini" style="margin-top:20px;width:80%" plain  @click="followUser(userName,state)">
              关注
            </el-button>
            <el-button v-if="state == 1" size="mini" style="margin-top:20px;width:80%" plain  @click="followUser(userName,state)">
              取关
            </el-button>
          </div>
          <div style="margin-left:10px; text-align:left;width:70%;float:left;" @click="router(userName)">
              <b>作者：</b>{{userName}}
              <br>
              <b>职业：</b>{{job}}
              <br>
              <b>关注：</b>{{followingNum}}&nbsp;&nbsp;&nbsp;&nbsp;粉丝：{{followerNum}}
              <br>
              <b>简介：</b>{{summary}}
              <br>
              <b>声援博主：</b>如果您觉得文章对您有帮助，可以点赞一下。您的鼓励是博主的最大动力！
          </div>          
        </div>
        
        <el-divider/>
        <div  class="commentBox">
          <!-- 评论部分 -->
          <div style="text-align:left;width: 100%;padding-top: 2%" >
              <!-- <el-divider/> -->
              <el-input v-model="discussBody" placeholder="请输入评论内容" style="width: 50%" size="mini"></el-input>
              <el-button type="primary" style="margin-left:10px;width: 10%" size="mini" @click="sendDiscuss">评论</el-button>
              <el-button style="margin-left:10px;width: 10%" size="mini" @click="thumbUp()">点赞 {{favor}}</el-button>
          </div>

          <div v-for="discuss in discussList" :key="discuss.id" id="discussList" style="text-align:left;">
            <p @mouseenter="pEnter()" @mouseleave="pLeave()">
              <el-button type="text">{{discuss.user.name}}&nbsp;&nbsp;:</el-button>
              <span style="margin-left: 10px">{{discuss.body}}</span>
              <span style="color: #909399;margin-left: 50px" class="el-icon-time">{{getTime(discuss.time)}}</span>
              <el-button type="text" style="margin-left: 5%"
                        v-if="(discuss.user.name==getStoreName()||(getStoreRoles().indexOf('ADMIN') > -1))&&replyFlag"
                        @click="deleteDiscuss(discuss.id)">删除
              </el-button>
              <el-button type="text" style="margin-left: 1%" @click="sendReply(discuss.id,null)"
                        v-if="getStoreName()!=''&&replyFlag">回复
              </el-button>
            </p>
            <!-- 评论下的回复部分 -->
            <p   v-for="reply in discuss.replyList" style="margin: -5px" :key="reply.id"
              @mouseenter="pEnter()" @mouseleave="pLeave()">
              <span style="margin-left: 5%" class="el-icon-arrow-right"></span>
              <el-button type="text">{{reply.user.name}}&nbsp;&nbsp;:</el-button>

              <span v-if="reply.reply !== null">回复:</span>
              <el-button type="text" v-if="!(typeof(reply.reply) == 'undefined') && reply.reply !== null">
                {{reply.reply.user.name}}
              </el-button>

              <span style="margin-left: 10px">{{reply.body}}</span>
              <span style="color: #909399;margin-left: 50px" class="el-icon-time">{{getTime(reply.time)}}</span>

              <el-button type="text" style="margin-left: 5%"
                        v-if="(reply.user.name==getStoreName()||(getStoreRoles().indexOf('ADMIN') > -1))&&replyFlag"
                        @click="deleteReply(reply.id)">删除
              </el-button>
              <el-button type="text" style="margin-left: 1%" @click="sendReply(discuss.id,reply.id)"
                        v-if="getStoreName()!=''&&replyFlag">回复
              </el-button>
            </p>
          </div>

          <div style="padding-bottom: 4%">
            <el-pagination
              :page-size="pageSize"
              background
              layout="prev, pager, next"
              :total="total"
              @current-change="currentChange"
              :current-page="currentPage"
              @prev-click="currentPage=currentPage-1"
              @next-click="currentPage=currentPage+1"
              :hide-on-single-page="true">
            </el-pagination>
          </div>

        </div>


      </div>
    </div>
    <!--博文右侧栏区域-->
    <div class="sidebar">
      <tagCloud></tagCloud>
      <hotBlog></hotBlog>
      <recommendSide></recommendSide>
      <sideLink></sideLink>
    </div>
  </article>
</div>
</template>

<script>
  import blog from '@/api/blog'
  import user from '@/api/user'
  import store from '@/store/store'
  import discuss from '@/api/discuss'
  import reply from '@/api/reply'
  import date from '@/utils/date'
  import tagCloud from '@/components/tagCloud'
  import sideLink from '@/components/sideLink'
  import hotBlog from '@/components/hotBlog'
  import recommendSide from '@/components/recommendSide'
  import 'element-ui/lib/theme-chalk/display.css';
  import { Loading } from 'element-ui';

  export default {
    name: 'blog',
    components: {tagCloud,sideLink,hotBlog,recommendSide},
    data() {
      return {
        blogId: -1,//博文id
        favor: 0,
        title: '',//博文标题
        body: '',//博文内容
        discussCount: 0,//评论数
        blogViews: 0,//浏览数
        time: 0, //发布事件
        userName: '',//博客用户名
        userId: '',//博客id
        followingNum:0, //粉丝数
        followerNum:0,  //关注数
        avatarURL: '', //作者头像
        job:'', //作者职业
        summary:'',//作者简介
        state: 0,//未关注0 关注1
        tags: [],  //博文标签

        total: 0,        //数据总数
        discussList: [],   //当前页数据
        pageSize: 5,    //每页显示数量
        currentPage: 1,   //当前页数

        discussBody: '',//评论内容
        replyFlag: false,  // 是否显示回复按钮
        replyBody: ''   ,//回复内容

        loading: false,
        loadingInstance: null, // loading对象
      }
    },
    watch: {
      blogId() {//在此调用接口
        this.loadBlog();
        var w = document.documentElement.offsetWidth || document.body.offsetWidth;
        if (w < 768) {  //对应xs
          document.getElementById('editor').style.margin = '0% -4.5%';
          document.getElementById('blog').style.margin = '20px 0% 0 0%';
          document.getElementById('blog').style.padding = '0';
        }
      }
    },
    methods: {
      followUser (userName, state) { //关注动作 以state判断是否已关注
        if(!this.$store.state.name) {
          this.$notify({title: '提示', message: '请先登录', type: 'error', duration: 4000 });
          return
        }
        if(userName==this.getStoreName()){
          this.$notify({title: '提示',type: 'error',message: '不能关注自己',duration: 3000 });
          return
        }
        if(state==0){
          user.newFollow(userName).then(res=>{
            this.isfollow()
            this.$notify({title: '提示',type: 'success',message: '关注成功',duration: 3000 });
            this.getfollower()
          })
        }
        else{
          user.removeFollow(userName).then(res=>{
            this.isfollow()
            this.$notify({title: '提示',type: 'info',message: '取消关注',duration: 3000 });
            this.getfollower()
          })
        }
      },
      router(username) {  //跳转用户动态
        scrollTo(0, 0);
        this.$router.push({
            path: '/userIndex/'+username
          })
      },
      thumbUp(){
        if(!this.$store.state.name) {
          this.$notify({title: '提示', message: '请先登录', type: 'error', duration: 4000 });
          return
        }
        blog.thumbUp(this.blogId).then(res => {
          this.$notify({title: '提示',type: 'success',message: res.message, duration: 3000 });
          this.loadBlog();
        })
      },
      isfollow(){ //检查是否关注当前用户
        if(!this.$store.state.name) return
        user.isfollow(this.userName).then(res=>{
          // console.log(res.data)
          if(res.data==true) this.state=1
          else this.state=0
        })
      },
      getfollowing(){ //获取关注数
        blog.followingNum(this.userName).then(res=>{
          this.followingNum = res.data
        })
      },
      getfollower(){  //获取粉丝数
        blog.followerNum(this.userName).then(res=>{
          this.followerNum = res.data
        })
      },
      getTime(time) {//将时间戳转化为几分钟前，几小时前的格式
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
      },
      loadBlog() { //加载数据
        var cookies = this.$cookies.get('history');
        var isClick = null;
        this.loadingInstance = Loading.service({
          lock: true,
          text: '正在努力加载中……',
          background: 'rgba(0, 0, 0, 0.7)'
        })
        //存在此cookies key
        if (this.$cookies.isKey('history'))
          //此cookies key 对应的 value 中有此 博客id
          if (cookies.indexOf(this.blogId) > -1)  //已点击查看
            isClick = true;
          else  isClick = false;
        else isClick = false;

        blog.getBlogById(this.blogId, isClick).then(res => {
            this.title = res.data.title;
            this.favor = res.data.favorCount;
            this.body = res.data.body;
            this.discussCount = res.data.discussCount;
            this.blogViews = res.data.blogViews;
            this.time = res.data.time;
            this.userName = res.data.user.name;
            this.userId = res.data.user.id;
            this.tags = res.data.tags;
            this.avatarURL = res.data.user.avatar;
            if(!res.data.user.job) this.job = '无'
            else this.job = res.data.user.job;
            if(!res.data.user.summary) this.summary = '无'
            else this.summary = res.data.user.summary;

            this.isfollow()
            this.getfollowing()
            this.getfollower()
            //设置cookies
            // 是否存在history此key
            if (this.$cookies.isKey('history')) {
              var cookies = this.$cookies.get('history');

              //不包含此博客的id  追加id
              if (cookies.indexOf(this.blogId) <= -1) {
                cookies = cookies + ',' + res.data.id;
                this.$cookies.set('history', cookies);
              }

            } else {
              var cookies = res.data.id;
              this.$cookies.set('history', cookies);
            }
          }
        );

        discuss.getDiscussByBlogId(this.blogId, this.currentPage, this.pageSize).then(responese => {
          this.total = responese.data.total;
          this.discussList = responese.data.rows;
        });
        this.loadingInstance.close();
      },

      getStoreName() { //获取store中存储的name
        return this.$store.state.name;
      }
      ,
      getStoreRoles() { //获取store中存储的roles
        return this.$store.state.roles;
      }
      ,
      pEnter() {
        this.replyFlag = true
      }
      ,
      pLeave() {
        this.replyFlag = false  
      },
      routertag(tagName){
        this.$router.push({ name:'classify',params:{tag:tagName}})
      },
      sendReply(discussId, replyId) {  //发送回复
        if(!this.$store.state.name) {
          this.$notify({title: '提示', message: '请先登录', type: 'error', duration: 4000 });
          return
        }
        this.$prompt('请输入回复内容', '提示', {
          confirmButtonText: '回复',
          cancelButtonText: '取消'
        }).then(({value}) => {
          if (value == null || value.length <= 0) {
            this.$notify({title: '提示',type: 'error',message: '字段不完整',duration: 4000 });
            return;
          }
          reply.sendReply(discussId, value, replyId).then(res => {
            this.$notify({title: '提示',type: 'success',message: '回复成功',duration: 4000 });
            this.loadBlog();
          })
        }).catch(() => {
        });
      }
      ,
      sendDiscuss() {  //发送评论
        if(!this.$store.state.name) {
          this.$notify({title: '提示', message: '请先登录', type: 'error', duration: 4000 });
          return
        }
        if (this.discussBody.length <= 0) {
          this.$notify({title: '提示',type: 'error',message: '字段不完整',duration: 3000 });
          return;
        }
        discuss.sendDiscuss(this.blogId, this.discussBody).then(res => {
          this.$notify({title: '提示',type: 'success',message: '评论成功',duration: 3000 });
          this.discussBody = ''
          this.loadBlog();
        })
      }
      ,
      deleteDiscuss(discussId) {  //删除评论  判断是用户还是管理员 走不一样的api
        this.$confirm('是否删除此评论?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          if (this.$store.state.roles.indexOf('ADMIN') > -1) {
            //管理员
            discuss.adminDeleteDiscuss(discussId).then(res => {
              this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
              this.loadBlog();
            })
          } else {
            //普通用户
            discuss.userDeleteDiscuss(discussId).then(res => {
              this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
              this.loadBlog();
            })
          }


        }).catch(() => {
        });
      }
      ,
      deleteReply(replyId) {  //删除回复  判断是用户还是管理员 走不一样的api
        this.$confirm('是否删除此回复?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          if (this.$store.state.roles.indexOf('ADMIN') > -1) {
            //管理员
            discuss.adminDeleteReply(replyId).then(res => {
              this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
            })
          } else {
            //普通用户
            discuss.userDeleteReply(replyId).then(res => {
              this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
            })
          }
          this.loadBlog();
        }).catch(() => {
        });
      }
      ,
      back() {
        history.back()
      }
    }
  }
</script>
<style scoped>
.clearfix{ *zoom:1; }
.clearfix:after{
content:"";
display: block;
clear:both;
}
.commentBox {
     /* border: 1px solid rgb(153, 150, 150); padding: 10px;  */
     margin: 20px auto 15px auto; line-height: 23px; 
  }
  #editor {
    height: 100%;
  }

  #discuss {
    margin: 15px 5% 0 5%;
  }

  #discussList {
    text-align: left;
    padding: 2% 1% 1% 3%;
  }
</style>
