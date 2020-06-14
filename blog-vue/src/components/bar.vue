<template>
  <div>
    <!--导航栏-->
    <header  :class="isVisible?'header-navigation slideDown':'header-navigation slideUp'"  id="header" >
      <nav>
        <div class="logo">
          <router-link to="/">
            <a href="javascript:void(0);">技术分享博客</a>
          </router-link>
        </div>
        <h2 id="mnavh" @click="openHead" :class="showHead?'open':''">
          <span class="navicon"></span>
        </h2>
        <ul id="starlist" :style="showHead?'display: block':''">
          <li>
            <router-link to="/">
              <a href="javascript:void(0);" >首页</a>
            </router-link>
          </li>
          <li>
            <router-link to="/classify">
              <a href="javascript:void(0);" >分类</a>
            </router-link>
          </li> 
          <li>
            <router-link to="/message">
              <a href="javascript:void(0);" >留言板</a>
            </router-link>
          </li>
          <li>
            <router-link to="/announcement">
              <a href="javascript:void(0);">本站公告</a>
            </router-link>
          </li>
          <li v-if="this.$store.state.token">
            <router-link to="/myblog">
              <a href="javascript:void(0);">我的博客</a>
            </router-link>
          </li>
          <li v-if="this.$store.state.token">
            <router-link to="/file">
              <a href="javascript:void(0);">文件资源</a>
            </router-link>
          </li>
        </ul>

        
        <!--搜索框-->
        <div class="searchbox">
          <div id="search_bar" :class="(showSearch || searchTxt.length > 0)?'search_bar search_open':'search_bar'">
            <input
              ref="searchInput"
              class="input"
              placeholder="想搜点什么呢.."
              type="text"
              name="keyboard"
              v-model="searchTxt"
              v-on:keyup.enter="searchSubmit"
            >
          </div>
          
        </div>
        <div class="swButton" v-if="showSearch==true">
          <el-button size="mini" v-if="state == 0" type="info" style="margin-top:8px;height:100%"
                       @click="state=1-state">
              <div id="x1">标签</div><div id="x3">/</div><div id="x2">全文</div>
            </el-button>
         <el-button size="mini" v-if="state == 1" type="info" style="margin-top:8px;height:100%"
                       @click="state=1-state">
              <div id="x1">全文</div><div id="x3">/</div><div id="x2">标签</div>
            </el-button>
        </div>
          <p class="search_ico" @click="clickSearchIco">
            <span></span>
          </p>
        <!--头像下拉菜单-->
        <el-dropdown @command="handleCommand" class="userInfoAvatar">
          <span class="el-dropdown-link" >
            <img v-if="!this.$store.state.token" src="../../static/images/defaultAvatar.png">
            <img v-else-if="userInfo.avatar==null" src="../../static/images/defaultAvatar.png">
            <img v-else-if="userInfo.avatar.length>0" :src="userInfo.avatar" >
            <img v-else  src="../../static/images/defaultAvatar.png" >
          </span>
          <el-dropdown-menu slot="dropdown">
            <el-dropdown-item command="login" v-show="!this.$store.state.token">登录</el-dropdown-item>
            <el-dropdown-item command="register" v-show="!this.$store.state.token">注册</el-dropdown-item>
            <el-dropdown-item command="writeBlog" v-show="this.$store.state.token">写博客</el-dropdown-item>
            <el-dropdown-item command="goUserInfo" v-show="this.$store.state.token">个人中心</el-dropdown-item>
            <el-dropdown-item command="goAdmin" v-show="this.$store.state.roles.indexOf('ADMIN') > -1">管理后台</el-dropdown-item>
            <el-dropdown-item command="logout" v-show="this.$store.state.token">退出登录</el-dropdown-item>
          </el-dropdown-menu>
        </el-dropdown>

        <!--侧栏抽屉-->
        <el-drawer  :visible.sync="drawer"  :show-close="true" :with-header="false" size="30%" :append-to-body="true"
              style="height: 100%; ">
          <el-tabs style="margin-top: 50px; height: 100%;" type="border-card" tab-position="left" v-model="activeName" @tab-click="handleClick">
              <el-tab-pane label="个人中心" name="0">
                <span slot="label"><i class="el-icon-user-solid"></i> 个人中心</span>
                
                <el-form label-position="left" :model="userInfo" label-width="100px" ref="userInfo">
                  <el-form-item label="用户头像" :label-width="labelWidth">
                    <el-upload
                      class="avatar-uploader"  action="123"
                      :show-file-list="false"
                      :on-change="fileChange"
                      :http-request="SubbmitFile" >
                      <img v-if="userInfo.avatar" :src="userInfo.avatar" class="avatar"
                          onerror="javascript:this.src='../../static/images/defaultAvatar.png'">
                      <i v-else class="el-icon-plus avatar-uploader-icon"></i>
                    </el-upload>
                  </el-form-item>
                  <el-form-item label="性别" :label-width="labelWidth">
                    <el-radio v-model="userInfo.gender" label="男" border size="medium">男</el-radio>
                    <el-radio v-model="userInfo.gender" label="女" border size="medium">女</el-radio>
                  </el-form-item>
                  <el-form-item label="生日" :label-width="labelWidth">
                    <el-date-picker
                      v-model="userInfo.birth" value-format="yyyy-MM-dd"
                      type="date" placeholder="选择日期">
                    </el-date-picker>
                  </el-form-item>
                  <el-form-item label="邮箱" :label-width="labelWidth" prop="email">
                    <div style="width: 100%">{{userInfo.email}}</div>
                  </el-form-item>
                  <el-form-item label="QQ号" :label-width="labelWidth" prop="qqNumber">
                    <el-input v-model="userInfo.qq" style="width: 100%"></el-input>
                  </el-form-item>
                  <el-form-item label="职业" :label-width="labelWidth">
                    <el-input v-model="userInfo.job" style="width: 100%"></el-input>
                  </el-form-item>
                  <el-form-item label="简介" :label-width="labelWidth">
                    <el-input
                      type="textarea"
                      :autosize="{ minRows: 5, maxRows: 10}"
                      placeholder="请输入内容"
                      style="width: 100%"
                      v-model="userInfo.summary">
                    </el-input>
                  </el-form-item>

                  <el-form-item>
                    <el-button type="primary" @click="submitForm()">保 存</el-button>
                  </el-form-item>

                </el-form>
              </el-tab-pane>
              <el-tab-pane label="密码邮箱" name="5">
                <span slot="label"><i class="el-icon-s-tools"></i> 修改密码</span>
                <el-collapse v-model="activeNames">
                  <el-collapse-item title="更改密码" name="1">
                  </el-collapse-item>
                </el-collapse>
                <el-form ref="form" label-position="left" :model="userInfo" label-width="100px" >
                  <el-form-item label="旧密码" :label-width="labelWidth" prop="oldPwd">
                    <el-input type="password" v-model="oldPassword" style="width: 100%"></el-input>
                  </el-form-item>
                  <el-form-item label="新密码" :label-width="labelWidth" prop="newPwd">
                    <el-input type="password" v-model="newPassword" style="width: 100%"></el-input>
                  </el-form-item>
                  <el-form-item label="重复密码" :label-width="labelWidth" prop="newPwd2">
                    <el-input type="password" v-model="confirmPassword" style="width: 100%"></el-input>
                  </el-form-item>
                  <el-form-item>
                    <el-button type="primary" @click="updatePwd()">提 交</el-button>
                  </el-form-item>
                </el-form>

                <el-collapse v-model="activeNames">
                  <el-collapse-item title="改绑邮箱" name="1">
                  </el-collapse-item>
                </el-collapse>
                <el-form ref="form" label-position="left" :model="userInfo" label-width="100px" >
                  <el-form-item label="新邮箱">
                    <el-input v-model="newMail" placeholder="新邮箱"></el-input>
                    <el-button type="text" style="width: 85%;" @click="updateMailSendMailToNew()">
                      发送验证码
                      <i class="el-icon-loading" v-if="updateMailToNewSendFlag"/>
                    </el-button>
                  </el-form-item>
                  <el-form-item label="新邮箱验证码">
                    <el-input v-model="newMailCode" placeholder="新邮箱验证码"></el-input>
                  </el-form-item>
                  <el-form-item>
                    <el-button type="primary" @click="updateMail()">改绑邮箱</el-button>
                  </el-form-item>
                </el-form>
              </el-tab-pane>
              <el-tab-pane label="我的评论" name="1">
                <span slot="label"><i class="el-icon-s-comment"></i> 我的评论</span>
                <div style="width: 100%; height: 840px;overflow:auto;">
                  <el-timeline>
                    <el-timeline-item v-for="comment in commentList" :key="comment.id"  placement="top">
                      <el-card>
                        <div class="commentList">
                        <span class="left p1">
                          <img v-if="!comment.user.avatar" src="../../static/images/defaultAvatar.png">
                          <img v-else style="height:30px;width:30px" :src="comment.user.avatar" 
                              onerror="javascript:this.src='../../static/images/defaultAvatar.png'"/>
                        </span>
                          <span class="right p1">
                          <div class="rightTop">
                            <el-link class="userName" :underline="false">{{comment.user.name}}</el-link>
                            <span> 评论了</span>
                            <el-tag type="info" size="mini" style="cursor: pointer;"  @click.native="router(comment.blog.id)">{{comment.blog.title.substring(0,10)}}</el-tag>
                          </div>
                          <div class="rightCenter">{{comment.body}}</div>
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
              </el-tab-pane>
              <el-tab-pane label="用户回复" name="8">
                <span slot="label"><i class="el-icon-s-comment"></i> 用户回复</span>
                <div style="width: 100%; height: 840px;overflow:auto;">
                  <el-timeline>
                    <el-timeline-item v-for="reply in replyList" :key="reply.id"  placement="top">
                      <el-card>
                        <div class="commentList">
                        <span class="left p1">
                          <img v-if="!reply.user.avatar" src="../../static/images/defaultAvatar.png">
                          <img v-else style="height:30px;width:30px" :src="reply.user.avatar" 
                              onerror="javascript:this.src='../../static/images/defaultAvatar.png'"/>
                        </span>
                          <span class="right p1">
                          <div class="rightTop">
                            <el-link class="userName" :underline="false">{{reply.user.name}}</el-link>
                            <span> 评论了</span>
                            <el-tag type="info" size="mini" style="cursor: pointer;"  @click.native="router(reply.discuss.blog.id)">{{reply.discuss.body.substring(0,10)}}</el-tag>
                          </div>
                          <div class="rightCenter">{{reply.body}}</div>
                        </span>
                        </div>
                      </el-card>
                    </el-timeline-item>

                    <el-timeline-item v-if="replyList.length == 0" placement="top">
                      <el-card>
                        <span style="font-size: 16px">空空如也~</span>
                      </el-card>
                    </el-timeline-item>
                  </el-timeline>
                </div>
              </el-tab-pane>
              <el-tab-pane label="我的点赞" name="2">
                <span slot="label"><i class="el-icon-s-flag"></i> 我的点赞</span>
                <div style="width: 100%; height: 840px;overflow:auto">
                  <el-timeline>
                    <el-timeline-item v-for="praise in praiseList" :key="praise.id" :timestamp="getTime(praise.blogTime)" placement="top">
                      <el-card>
                        <span>点赞</span><el-tag type="primary" style="margin-left:15px;cursor: pointer"  @click.native="router(praise.blogId)">{{praise.blogTitle}}</el-tag>
                      </el-card>
                    </el-timeline-item>
                    <el-timeline-item v-if="praiseList.length == 0" placement="top">
                      <el-card>
                        <span style="font-size: 16px">空空如也~</span>
                      </el-card>
                    </el-timeline-item>
                  </el-timeline>
                </div>
              </el-tab-pane>
              <el-tab-pane label="我的关注" name="7">
                <span slot="label"><i class="el-icon-platform-eleme"></i> 我的关注</span>
                <div style="width: 100%; height: 840px;overflow:auto">
                    <li v-for="follow in followingList.rows" :key="follow.id" placement="top" >
                      <el-card >
                        <div class="commentList">
                          <span class="left p1">
                            <img v-if="!follow.avatar" style="height:40px;width:40px" src="../../static/images/defaultAvatar.png">
                            <img v-else style="height:40px;width:40px" :src="follow.avatar" 
                                onerror="javascript:this.src='../../static/images/defaultAvatar.png'"/>
                          </span>
                          <el-button type="text" style="margin-left:5px;cursor: pointer;width:30%"  @click.native="routerUser(follow.name)">
                            {{follow.name}}
                          </el-button>
                          <el-tag v-if="!follow.job" type="info" size="medium" >无</el-tag>
                          <el-tag v-else type="info" size="medium">{{follow.job }}</el-tag>
                          <el-button  size="mini" style="cursor: pointer;width:22%;position:absolute;right:30px;margin-top:7px"  @click.native="removeFollow(follow.name)">
                            取消关注
                          </el-button>
                        </div>
                      </el-card>
                    </li>
                    <div v-if="followingList.length == 0" placement="top">
                      <el-card>
                        <span style="font-size: 16px">空空如也~</span>
                      </el-card>
                    </div>
                </div>
              </el-tab-pane>
              <el-tab-pane label="我的资源" name="3">
                <span slot="label"><i class="el-icon-upload"></i> 我的资源</span>
              </el-tab-pane>
              <el-tab-pane label="我的博客" name="4">
                <span slot="label"><i class="el-icon-s-unfold"></i> 我的博客</span>
              </el-tab-pane>
          </el-tabs>
        </el-drawer>
      </nav>
    </header>
    <!--登录注册对话框-->
    <el-dialog title="登录" :visible.sync="loginFormVisible" width="23%">
      <el-form :model="form">
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.loginName" placeholder="用户名" prefixIcon="el-icon-user-solid"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.loginPwd" placeholder="密码" :show-password="form.loginShowPwd"
                    @keyup.enter.native="userLogin" prefixIcon="el-icon-lock"/>
        </el-form-item>
        <el-button class="loginBtn" type="primary" @click="userLogin">登录&nbsp;&nbsp;<i class="el-icon-check"></i></el-button>
        <el-button class="registerBtn" type="info" @click="loginFormVisible=false,findFormVisible=true">忘记密码&nbsp;&nbsp;<i class="el-icon-right"></i></el-button>
      </el-form>
    </el-dialog>
    <el-dialog title="注册" :visible.sync="registerFormVisible" width="23%">
      <el-form :model="form">
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.registerName" placeholder="用户名" prefixIcon="el-icon-user-solid"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.registerPwd" placeholder="密码" :show-password="form.loginShowPwd"
                    prefixIcon="el-icon-lock"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.registerConfirmPwd" placeholder="确认密码" :show-password="form.loginShowPwd"
                    prefixIcon="el-icon-bell"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.registerMail" placeholder="邮箱" prefixIcon="el-icon-message"/>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.registerMailCode" placeholder="邮箱验证码" prefixIcon="el-icon-key"/>
        </el-form-item>
        <el-button class="loginBtn" type="primary" @click="userRegister">注册&nbsp;&nbsp;<i class="el-icon-check"></i></el-button>
        <el-button class="registerBtn" type="info" @click="sendMail(form.registerMail)">发送验证码&nbsp;&nbsp;
          <i class="el-icon-coffee-cup" v-if="!sendMailFlag"/>
          <i class="el-icon-loading" v-if="sendMailFlag"/>
        </el-button>
      </el-form>
    </el-dialog>
    <el-dialog title="找回密码" :visible.sync="findFormVisible" width="23%">
      <el-form ref="form" label-width="80px">
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.findName" placeholder="用户名" prefixIcon="el-icon-user-solid"></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.findPwd" placeholder="新密码" prefixIcon="el-icon-lock" show-password></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.findconfirmPwd" placeholder="确认密码" prefixIcon="el-icon-bell" show-password></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.findMail" placeholder="你的邮箱" prefixIcon="el-icon-message"></el-input>
        </el-form-item>
        <el-form-item :label-width="formLabelWidth">
          <el-input v-model="form.findMailCode" placeholder="收到的验证码" prefixIcon="el-icon-key"></el-input>
        </el-form-item>
      </el-form>
      <div>
        <el-button class="loginBtn" type="primary" @click="forgetPwd">更改密码&nbsp;&nbsp;<i class="el-icon-potato-strips"></i></el-button>
        <el-button class="registerBtn" type="info" @click="sendFindMail">发送验证码&nbsp;&nbsp;
          <i class="el-icon-coffee-cup" v-if="!sendMailFlag"/>
          <i class="el-icon-loading" v-if="sendMailFlag"/>
        </el-button>
      </div>
    </el-dialog>
    
    <!--小火箭-->
    <div>
      <a href="javascript:void(0);"  @click="returnTop"  :class="isCdTopVisible?'cd-top cd-is-visible':'cd-top'">Top</a>
    </div>

  </div>
</template>

<script>
  import axios from 'axios'
  import date from '@/utils/date'
  import user from '@/api/user'
  import reply from '@/api/reply'
  import store from '@/store/store'
  import discuss from '@/api/discuss'
  import blog from '@/api/blog'
  import 'element-ui/lib/theme-chalk/display.css'

  export default {
    name: 'bar',
    data() {
      return {
        //修改用户信息相关
        file: {}, //头像图片
        oldPassword: '',
        newPassword: '',
        confirmPassword: '',
        updatePwdMailCode: '', // 修改密码验证码
        mail: '', //用户原邮箱
        newMail: '',    //新邮箱
        newMailCode: '',  //新邮箱验证码
        updatePwdSendFlag: false,
        updateMailToOldSendFlag: false,
        updateMailToNewSendFlag: false,
        //侧栏基础元素
        activeNames: ['1', '2'], //激活的折叠面板
        activeName: "0", // 激活的标签
        yesNoDictList: [], // 是否 字典列表
        genderDictList: [], //性别 字典列表
        feedbackDictList: [], // 反馈 字典列表
        labelWidth: "85px",
        commentList: [], //我的评论
        replyList: [], // 我的回复
        praiseList: [], // 我的点赞
        followingList: [], // 我的关注
        followerList: [], // 我的粉丝
        userInfo: { //用户信息
          id: 0,  name: '',  gender: '', birth: '', email: '', qq: '', job:'', summary:'', avatar: ''
        },
        //导航栏基础元素
        drawer: false,
        isLogin: false,
        isVisible: true,//导航栏
        isCdTopVisible: false,//小火箭
        showLogin: false,
        searchTxt: '',//搜索框
        showSearch: false, // 控制搜索框的弹出
        showHead: false, //控制导航栏的弹出
        activeIndex: '1',//默认选中第一项->首页
        //登录注册对话框
        loginFormVisible: false,//登录框
        registerFormVisible: false,//注册框
        findFormVisible: false,//注册框
        state:1,      
        form: { //表单
          loginName: '',
          loginPwd: '',
          loginShowPwd: true, //登录是否显示密码
          registerName: '',//注册
          registerPwd: '',
          registerConfirmPwd: '',
          registerMail: '',
          registerMailCode: '',
          registerInviteCode: '',
          findName:'',
          findPwd:'',
          findconfirmPwd:'',
          findMail:'',
          findMailCode:''
        },
        formLabelWidth: '0px',
        sendMailFlag: false
      }
    },
    mounted() {
      var that = this;
      var after = 50;
      window.addEventListener("scroll", function () {
        let scrollTop = document.documentElement.scrollTop; //当前的的位置
        if (scrollTop > 300) {
          that.isCdTopVisible = true;
        } else {
          that.isCdTopVisible = false;
        }
        if(after <50) after = 50;
        if (scrollTop > after) {
          that.isVisible = false;
        } else {
          that.isVisible = true;
        }
        after = scrollTop;
      });
    },
    watch: {
      // 监控当前页面path，防止刷新页面显示错误
      '$route.path': {
        deep: true,
        immediate: true,
        handler(to, from) {
          if (to === '/') {
            this.activeIndex = '1'
          } else if (to === '/message') {
            this.activeIndex = '2'
          } else if (to === '/announcement') {
            this.activeIndex = '3'
          } else {
            this.activeIndex = '4'
          }
        }
      }
    },
    created(){
      this.getUserInfo()
    },
    methods: {
      removeFollow(userName){
        user.removeFollow(userName).then(res=>{
          this.$notify({title: '提示',type: 'info',message: '取消关注',duration: 2000 });
          this.getFollowingList()
        })
      },
      router(id){//跳转博客界面
        scrollTo(0, 0);
        this.$router.push({ //路由跳转
          path: '/blog/'+id
        })
        this.drawer = false;
      },
      routerUser(username) {//跳转用户动态/主页
        scrollTo(0, 0);
        this.$router.push({
          path: '/userIndex/'+username
        })
        this.drawer = false;
      },
      getUserInfo(){ //用户信息 
        if(this.$store.state.token){
          user.getUserInfo().then(response=>{
            // console.info(response.data)
            var a = response.data
            this.userInfo.id = a.id
            this.userInfo.name = a.name
            this.userInfo.gender = a.gender
            this.userInfo.birth = a.birth
            this.userInfo.email = a.mail
            this.userInfo.qq = a.qq
            this.userInfo.summary = a.summary
            this.userInfo.avatar = a.avatar
            this.userInfo.job = a.job
          })
        }
      },
      submitForm() { //修改用户信息
        var a = this.userInfo
        user.editUser(a.gender,a.birth,a.qq,a.job,a.summary).
        then(response => {
          if(response.code == 200) {
            this.$notify({title: '提示',type: 'success',message: '更新成功',duration: 2500 });
          } else {
            this.$notify({title: '提示',type: 'error',message: '更新失败',duration: 3000 });
          }
        });
      },
      getCommentList(){//评论列表
        discuss.getDiscussByUserId(this.userInfo.name).then(response=>{
          this.commentList = response.data
        })
      },
      getFavorList(){ //点赞列表
        user.getFavor().then(response=>{
          this.praiseList = response.data
        })
      },
      getFollowingList(){//关注列表
        user.getFollowing().then(response=>{
          this.followingList = response.data
          // console.info("following")
          // console.log(this.followingList)
        })
      },
      // getFollowerList(){//粉丝列表
      //   user.getFollower().then(response=>{
      //     this.followerList = response.data
      //     // console.info("follower")
      //     // console.log(this.followerList)
      //   })
      // },
      getReplyList(){ //被其他用户回复
        reply.getReply(this.userInfo.id).then(res=>{
          // console.log(res.data)
          this.replyList = res.data
        })
      },
      getTime(time) {//将时间戳转化为几分钟前，几小时前
        return date.timeago(time);
      },  
      handleClick(tab, event) {// 选择博客/资源标签时直接跳转
        if(tab.name==4) {
          this.$router.push({ path:'/myBlog'  }) 
          this.drawer = false;}
        else if(tab.name==3) {
          this.$router.push({ path:'/file'  })
          this.drawer = false;}
      },
      handleCommand(command) {// 点击头像触发的动作
        switch (command) {
          case "writeBlog" : {
            this.$router.push({ path:'/newBlog'  }) 
            // alert('该功能待完善');
          };break;
          case "logout" : {
            this.logout();
          };break;
          case "login" : {
            this.loginFormVisible = true;
          };break;
          case "register" : {
            this.registerFormVisible = true;
          };break;
          case "goUserInfo" : {
            // 打开抽屉
            this.drawer = true;
            // 获取评论列表
            this.getCommentList();
            // 获取点赞列表
            this.getFavorList()
            // 获取关注列表
            this.getFollowingList()
            // 获取粉丝列表
            // this.getFollowerList()
            //  获取被回复列表
            this.getReplyList()
          };break;
          case "goAdmin" : {
            this.$router.push({ path:'/admins/userManage'  })
          };break;
        }
      },
      closeLoginBox() {
        this.showLogin = false;
      },
      clickSearchIco() {
        if(this.searchTxt != "") {
          this.search();
        }
        this.showSearch = !this.showSearch;
        //获取焦点
        this.$refs.searchInput.focus();
      },
      openHead() {
        this.showHead = !this.showHead;
      },
      returnTop() {//回到顶端
        window.scrollTo(0, 0);
      },
      handleSelect(key, keyPath) {
        if (key != null && key !== '')
          this.activeIndex = key
      },
      updatePwd() {//修改密码
        if (this.oldPassword.length <= 0) {
          this.$notify({title: '提示',type: 'warning',message: '原密码不能为空',duration: 2500 });
          return;
        }
        if (this.newPassword != this.confirmPassword) {
          this.$notify({title: '提示',type: 'warning',message: '两次输入密码不一致',duration: 3000 });
          return;
        }
        user.updatePassword(this.oldPassword, this.newPassword).then(res => {
          this.$notify({title: '提示',type: 'success',message: '修改成功',duration: 3000 });
          this.drawer=false
          this.$store.commit('logout')//清除token等信息
          this.$router.push({path: '/'})
        })
      },
      updateMail() {//修改邮箱
        var reg = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
        if (!reg.test(this.newMail)) {//检测字符串是否符合正则表达式
          this.$notify({title: '提示',type: 'warning',message: '邮箱格式不正确',duration: 3000 });
          return;
        }
        if (this.newMailCode.length <= 0) {//
          this.$notify({title: '提示',type: 'warning',message: '请填写验证码',duration: 3000 });
          return;
        }
        user.updateMail(this.newMail, this.newMailCode).then(res => {
          this.$notify({title: '提示',type: 'success',message: '改绑成功',duration: 3000 });
          this.drawer=false
          this.newMail = '';
          this.newMailCode = '';
          this.load();
        })
      },
      userLogin() { //登录方法
        if (this.form.loginName.length <= 0 || this.form.loginPwd.length <= 0) {
          this.$notify({title: '提示',type: 'warning',message: '字段不完整',duration: 3000 });
          return;
        }
        user.login(this.form.loginName, this.form.loginPwd).then(response => {
          this.form.loginPwd = ''
          this.$store.commit('login', response.data)//存储token
          this.$notify({title: '提示',type: 'success',message: '登录成功',duration: 3000 });
          this.isLogin=true
          this.$router.go(0)
          this.loginFormVisible = false
        })
      },
      logout() {  //退出登录
        user.logout().then(res => {
          this.isLogin=false
          this.userInfo={}
          this.$store.commit('logout')//清除token等信息
          this.$notify({title: '提示',type: 'success',message: '退出登录',duration: 1000 });
          this.$router.push({ //路由跳转
            path: '/'
          })
        })

      },
      updateMailSendMailToNew() {  //更改密码发送验证码到新邮箱
        this.updateMailToNewSendFlag = true;
        this.sendMail(this.newMail);
      },
      sendMail(mail) {//发送邮件
        var reg = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
        if (!reg.test(mail)) {//检测字符串是否符合正则表达式
          this.$notify({title: '提示',type: 'warning',message: '邮箱格式不正确',duration: 3000 });
          return;
        }
        this.sendMailFlag = true;
        user.sendMail(mail).then(res => {
          this.$notify({title: '提示',type: 'success',message: '发送成功',duration: 3000 });
          this.sendMailFlag = false;
          this.updateMailToNewSendFlag = false;
        }).catch(() => {
          this.sendMailFlag = false;
          this.updateMailToNewSendFlag = false;
        })
      },
      sendFindMail() {//发送邮件.找回密码
        var reg = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
        if (this.form.findName.length <= 0) {
          this.$notify({title: '提示',type: 'error',message: '请填写用户名',duration: 3000 });
          return;
        }
        if (!reg.test(this.form.findMail)) {//检测字符串是否符合正则表达式
          this.$notify({title: '提示',type: 'error',message: '邮箱格式错误',duration: 3000 });
          return;
        }
        this.sendMailFlag = true;
        user.sendMail(this.form.findMail).then(res => {
          this.$notify({title: '提示',type: 'success',message: '发送成功',duration: 3000 });
          this.sendMailFlag = false;
        }).catch(()=>{
          this.sendMailFlag = false;
        })
      },
      userRegister() {//用户注册
        //判断是否输入字段
        if (this.form.registerName.length <= 0 || this.form.registerPwd.length <= 0 || this.form.registerConfirmPwd.length <= 0 ||
          this.form.registerMail.length <= 0 || this.form.registerMailCode.length <= 0 ) {
          this.$notify({title: '提示',type: 'warning',message: '字段不符合规范',duration: 3000 });
          return;
        }
        if (this.form.registerPwd !== this.form.registerConfirmPwd) {
          this.$notify({title: '提示',type: 'warning',message: '两次密码不一致',duration: 3000 });
          return;
        }
        if (this.form.registerPwd.length < 6) {
          this.$notify({title: '提示',type: 'warning',message: '密码长度需大于6位',duration: 3000 });
          return;
        }
        var reg = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
        if (!reg.test(this.form.registerMail)) {//检测字符串是否符合正则表达式
          this.$notify({title: '提示',type: 'warning',message: '邮箱格式不正确',duration: 3000 });
          return;
        }

        user.register(this.form.registerName, this.form.registerPwd, this.form.registerMail, this.form.registerMailCode, this.form.registerInviteCode).then(res => {
          this.$notify({title: '提示',type: 'success',message: '注册成功',duration: 3000 });
          this.registerFormVisible = false
        })

      },
      forgetPwd() {
        if (this.form.findName.length <= 0) {
          this.$notify({title: '提示',type: 'error',message: '请填写用户名',duration: 3000 });
          return;
        }
        var reg = new RegExp(/^([a-zA-Z0-9._-])+@([a-zA-Z0-9_-])+(\.[a-zA-Z0-9_-])+/);
        if (!reg.test(this.form.findMail)) {//检测字符串是否符合正则表达式
          this.$notify({title: '提示',type: 'error',message: '邮箱格式不正确',duration: 3000 });
          return;
        }
        if (this.form.findPwd.length < 6) {
          this.$notify({title: '提示',type: 'error',message: '密码不能小于6位',duration: 3000 });
          return;
        }
        if (this.form.findPwd != this.form.findconfirmPwd) {
          this.$notify({title: '提示',type: 'error',message: '两次输入密码不一致',duration: 3000 });
          return;
        }
        if (this.form.findMailCode.length <= 0) {
          this.$notify({title: '提示',type: 'error',message: '请输入验证码',duration: 3000 });
          return;
        }
        user.forgetPassword(this.form.findName, this.form.findMailCode, this.form.findPwd).then(res => {
          this.$notify({title: '提示',type: 'success',message: '更改成功',duration: 3000 });
          scrollTo(0, 0);
          this.form.findName='',this.form.findPwd='',this.form.findconfirmPwd='',
          this.form.findMail='',this.form.findMailCode=''
          this.findFormVisible=false
          this.$router.push({ //路由跳转
            path: '/'
          })
        })
      },
      searchSubmit() {//搜索
        if (this.searchTxt.length <= 0)
          return;
        if(this.state==1){
          this.$router.push({ 
            path: '/searchBlog/' + this.searchTxt
          })
        }
        else{
          this.$router.push({ 
            path: '/searchBlog/TAG_' + this.searchTxt
          })
        }
        this.searchTxt = '';//清空搜索框
      },
      fileChange(e,list){//上传头像.子函数
          this.file=e;
      },
      SubbmitFile(){//上传头像
          let param = new FormData(); 
          param.append("file", this.file.raw);
          let config = {
            headers: { 'Content-Type': 'multipart/form-data' },
          }
          config.headers['Authorization'] = store.state.token
          // console.log(param)
          axios.post("/api/file/uploadAvatar/", param, config,{timeout:900000})
          .then(response => {
            if (response) { 
              this.$router.go(0)
              this.file={}
              // console.log(response.data);
            } else {
              alert(response.data.msg);
            }
          })
          .catch(function (err) {
            console.log(err);
          });
      },
      
    }
  }
</script>

<style>
  .loginBtn {
    width: 40%;
  }
  .registerBtn {
    width: 40%;
  }
  .avatar-uploader .el-upload {
    border: 1px dashed #d9d9d9;
    border-radius: 6px;
    margin: 0, 0, 0, 10px;
    cursor: pointer;
    position: relative;
    overflow: hidden;
  }
  .avatar-uploader .el-upload:hover {
    border-color: #409eff;
  }
  .avatar-uploader-icon {
    font-size: 28px;
    color: #8c939d;
    width: 100px;
    height: 100px;
    line-height: 100px;
    text-align: center;
  }
  .imgBody {
    width: 100px;
    height: 100px;
    border: solid 2px #ffffff;
    float: left;
    position: relative;
  }
  .imgBody img {
    width: 100px;
    height: 100px;
  }
  .uploadImgBody {
    margin-left: 5px;
    width: 100px;
    height: 100px;
    border: dashed 1px #c0c0c0;
    float: left;
    position: relative;
  }
  .uploadImgBody :hover {
    border: dashed 1px #00ccff;
  }
  .inputClass {
    position: absolute;
  }
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
    margin-top: 3px;
    margin-left: 3px;
  }
  .commentList .rightTop .userName {
    margin-top: -3px;
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
    margin-top: 10px;
    line-height: 30px;
    height: 37px;
  }
  #x1{
    font-size: 14px;
    float: left;
    margin-top: -3px;
  }
  #x2{
    font-size: 10px;
    float: left;
    margin-top: 9px;
  }
  #x3{
    font-size: 20px;
    float: left;
    margin-top: -2px;
    margin-left: 2px;
  }
</style>
