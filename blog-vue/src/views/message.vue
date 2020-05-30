<template>
  <div style="min-height: 870px;" class="page">
    <div class="pagebg clock"></div>
    
    <div class="container">
      <h1 class="t_nav">
        <span>每个人都有自己故事，只是演绎的方式不同。</span>
        <a href="/" class="n1">网站首页</a>
        <a href="/" class="n2">留言</a>
      </h1>
      <!--发评论-->
      <div class="commentBox">
          <span class="right">
            <textarea id="textpanel" class="textArea" placeholder="既然来了，那就留下些什么吧~" v-model="messageBody" @input="vaildCount"></textarea>
          </span>
        </div>
        <div class="bottom">
          <el-button class="submit p2" type="primary"  @click="sendMessage">发送评论</el-button>
          <el-button class="cancel p2" type="info" @click="handleCancle">取消评论</el-button>
          <div class="emoji-panel-btn p2">
            <img src="../assets/face.png" />
          </div>
          <span class="allow p2">还能输入{{count}}个字符</span>
        </div>
      <!--评论列表-->
      <div class="message_infos">
        <div v-for="message in messageList" :key="message.id">
          <div class="commentList">
            <span class="left p1">
              <img :src="avatarUrl(message.name)"  style="width:50px; height:50px"
                onerror="javascript:this.src='https://wpimg.wallstcn.com/f778738c-e4f8-4870-b634-56703b4acafe.gif'" />
            </span>
            <span class="right p1">
              <div class="rightTop" v-if="message.name">
                <el-link class="userName" :underline="false">{{message.name}}</el-link>
                <span class="timeAgo" >{{getTime(message.time)}}</span>
              </div>
              <div class="rightCenter">{{message.body}}</div>
              <div class="rightBottom">
                  <el-divider content-position="right">
                  <el-link :underline="false" class="el-icon-delete" v-if="getStoreRoles().indexOf('ADMIN') > -1"
                      @click="deleteMessage(message.id)"/>
                  </el-divider>
              </div>
            </span>
          </div>
        </div>
        <div class="noComment" v-if="messageList.length ==0">还没有评论，快来抢沙发吧！</div>
      </div>
    </div>
  </div>
</template>
<script>
import message from '@/api/message'
import date from '@/utils/date'
import axios from 'axios'
import 'element-ui/lib/theme-chalk/display.css';

export default {
  name: 'message',
  data() {
    return {
      count:1024, //留言最多字数
      total: 0,        //数据总数
      messageList: [],   //当前页数据
      pageSize: 5,    //每页显示数量
      currentPage: 1,   //当前页数
      messageBody: '',
      loading: true, //是否加载中
    }
  },
  created () {
    this.loadMessage();
  },
  methods: {
    avatarUrl(name){
      return  'http://39.107.228.168/image/'+name+'.jpg'
    },
    vaildCount: function() {
      var count = 1024 - this.messageBody.length;
      if(count <= 0) {
        this.count = 0
      } else {
        this.count = count;
      }
    },
    handleCancle() {
      this.messageBody = '';
      this.count = 1024;
    },
    loadMessage () {
      message.getMessage(this.currentPage, this.pageSize).then(res => {
        this.total = res.data.total
        this.messageList = res.data.rows
        this.loading = false
      })
    },
    currentChange (currentPage) { //页码更改事件处理
      this.currentPage = currentPage;
      this.loadMessage();
    },
    sendMessage () {
      if (this.messageBody.length <= 0) {
        this.$message({
          type: 'error',
          message: '字段不完整'
        });
        return;
      }
      message.sendMessage(this.messageBody).then(res => {
        this.$message({
          type: 'success',
          message: '留言成功'
        })
        this.messageBody = ''
        this.loadMessage()
      })
    },
    deleteMessage(id) {
      this.$confirm('是否删除此留言?', '提示', {
        confirmButtonText: '确定',
        cancelButtonText: '取消',
        type: 'warning'
      }).then(() => {
        message.deleteMessage(id).then(res => {
          this.$message({
            type: 'success',
            message: '删除成功'
          });
          this.loadMessage();
        })
      }).catch(() => {
      });
    },
    getStoreRoles() { //获取store中存储的roles
      return this.$store.state.roles;
    },
    getTime(time) {//将时间戳转化为几分钟前，几小时前
      return date.timeago(time);
    },
  },
}
</script>
<style scoped>
  #message {
    margin: 10px 5% 0 5%;
  }
    .commentStyle {
    display: block;
    margin-top: 10px;
    margin-left: 10px;
    border-left: 1px dashed SlateGray;
  }
  .comment {
    display: none;
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
    width: 5%;
    height: 100%;
  }
  .commentList .left img {
    margin: 0 auto;
    width: 100%;
    border-radius: 50%;
  }
  .commentList .right {
    display: inline-block;
    width: 93%;
    margin-left: 5px;
  }
  .commentList .rightTop {
    text-align: left;
    margin-left: 5px;
    height: 30px;
    margin-top: 2px;
  }
  .commentList .rightTop .userName {
    text-align: left;
    color: #303133;
    margin-left: 10px;
    font-size: 16px;
    font-weight: bold;
  }
  .commentList .rightTop .timeAgo {
    text-align: left;
    color: #909399;
    margin-left: 10px;
    font-size: 15px;
  }
  .commentList .rightCenter {
    text-align: left;
    margin-left: 20px;
    height: 50px;
    margin-top: 15px;
  }
  .commentList .rightBottom {
    margin-left: 10px;
    height: 30px;
  }
  .commentBox {
    min-width: 700px;
    width: 100%;
    height: 100px;
    margin: 0 auto;
  }
  .commentBox .left {
    display: inline-block;
    width: 4%;
    height: 100%;
    padding-top: 3px;
  }
  .commentBox .left img {
    cursor: pointer;
    margin: 0 auto;
    width: 90%;
    border-radius: 50%;
  }
  .commentBox .right {
    display: inline-block;
    margin: 5px 2px 0 0;
    width: 95%;
    height: 100%;
  }
  textarea::-webkit-input-placeholder {
    color: #909399;
  }
  .commentBox .right textarea {
    color: #606266;
    padding:10px 5px 5px 10px;
    resize: none;
    width: 95%;
    height: 100%;
  }
  .bottom {
    position: relative;
    min-width: 690px;
    width: 98%;
    height: 60px;
    line-height: 40px;
    margin-top: 20px;
  }
  .bottom .p2 {
    float: right;
    margin-top: 5px;
    margin-right: 10px;
  }
    .emoji-panel-btn img{
    height: 35px;
    width: 35px;
  }
  .emoji-panel-btn:hover {
    cursor: pointer;
    opacity: 0.8;
  }
  .emoji-item-common {
    display: inline-block;
  }
  .emoji-item-common:hover {
     cursor: pointer;
   }
  .emoji-size-small {
    zoom: 0.3;
  }
  .emoji-size-large {
    zoom: 0.5;
    margin: 4px;
  }
</style>
