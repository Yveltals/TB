<template>
  <div style="min-height: 870px;">
    <div class="pagebg sorts"></div>
    <p style="display: none">{{userName=this.$route.params.userName}}</p>
    <div class="container">
      <h1 class="t_nav">
        <span v-if="userName!=this.$store.state.name">
          <el-button size="mini" v-if="state == 0" type="warning" plain
                       @click="followUser(userName,state)">
              关注
            </el-button>
          <el-button size="mini" v-if="state == 1" type="success" plain
                       @click="followUser(userName,state)">
              取关
            </el-button>
        </span>
        <a href="/" class="n1">网站首页</a>
        <a href="" @click.prevent="flag=true" class="n2">最新博客</a>
        <a href="" @click.prevent="flag=false" class="n3">最新评论</a>
      </h1>

      <div class="sortBox">
        <userBlogList v-if="flag" :userName=userName></userBlogList>
        <userDiscussList v-else  :userName=userName></userDiscussList>
      </div>
    </div>
  </div>
</template>
<script>
import userBlogList from '@/components/userBlogList'
import userDiscussList from '@/components/userDiscussList'
import tagCloud from '@/components/tagCloud'
import user from '@/api/user'

export default {
  name: 'myBlog',
  components: {userBlogList,tagCloud,userDiscussList},
  data(){
     return{
        id:0,
        userName:'', 
        flag:true,
        state:1  //是否已关注
     }
  },
  created() {
    this.userName=this.$route.params.userName
    this.isfollow()
  },
  methods: {
    isfollow(){
      user.isfollow(this.userName).then(res=>{
        // console.log(res.data)
        if(res.data==true) this.state=1
        else this.state=0
      })
    },
    followUser (userName, state) {
      if(state==0){
        user.newFollow(userName).then(res=>{
          this.isfollow()
          this.$notify({title: '提示',type: 'success',message: '关注成功',duration: 3000 });
        })
      }
      else{
        user.removeFollow(userName).then(res=>{
          this.isfollow()
          this.$notify({title: '提示',type: 'success',message: '取消关注',duration: 3000 });
        })
      }
      this.$router.go(0);
    },
  }
}
</script>
<style scoped>
  #userBlogList{
    margin: auto 1%;
  }
</style>
