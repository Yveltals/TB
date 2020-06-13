<template>
  <div>
     <div class="pagebg sh"></div>
     <div class="container">
      <h1 class="t_nav">
        <a href="/" class="n1">网站首页</a>
        <a class="n2">搜索</a>
      </h1>
      <!-- 触发监听 -->
      <p style="display: none">{{searchTxt = this.$route.params.searchTxt}}</p>
      <!--blogsbox begin-->
      <div class="blogsbox">
        <div v-for="item in blogData" :key="item.id" class="blogs" data-scroll-reveal="enter bottom over 1s">
          <h3 class="blogtitle">
            <a href="javascript:void(0);" @click="router(item.id)" v-html="item.title">
              {{item.title}}
            </a>
          </h3>
          <span class="blogpic">
            <a href="javascript:void(0);" @click="router(item.id)" title>
              <img :src="coverUrl(item.tags[0].name)" alt
                onerror="javascript:this.src='../../static/images/cover/css.jpg'">
            </a>
          </span>
          <p class="blogtext" v-html="item.body">{{item.body}}</p>
          <div class="bloginfo">
            <ul>
              <li class="author">
                <span class="iconfont">&#xe60f;</span>
                <a href="javascript:void(0);">{{item.user.name}}</a>
              </li>
              <li class="lmname">
                <span class="iconfont">&#xe603;</span>
                <a href="javascript:void(0);" @click="routerTag(item.tags[0].name)">{{item.tags[0].name}}</a>
              </li>
              <li class="createTime"><span class="iconfont">&#xe606;</span>{{getTime(item.time)}}</li>
            </ul>
          </div>
        </div>
        <span v-if="total == 0">空空如也~</span>
        <div v-if="total >5">
          <el-pagination
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
      <!--blogsbox end-->

      <div class="sidebar">
        <tagCloud></tagCloud>
        <recommendSide></recommendSide>
        <hotBlog></hotBlog>
        <sideLink></sideLink>
      </div>

     </div>
  
  </div>
</template>
<script>
import blog from '@/api/blog'
import date from '@/utils/date'
import tagCloud from '@/components/tagCloud'
import recommendSide from '@/components/recommendSide'
import hotBlog from '@/components/hotBlog'
import sideLink from '@/components/sideLink'

export default {
  name: 'searchBlog',
  components: {hotBlog,sideLink,recommendSide,tagCloud},
  data () {
    return {
      searchTxt: '',
      blogData: [],   //当前页数据
      total: 0,        //数据总数
      pageSize: 6,    //每页显示数量
      currentPage: 1,   //当前页数
      loading: false
    }
  },
  watch: {
    searchTxt() { //在此调用接口
      this.searchTxt = this.$route.params.searchTxt
      this.loadBlog();
    }
  },
  methods: {
    loadBlog() { //加载数据
      var strs= new Array()
      strs=this.searchTxt.split("_"); 
      if(strs[0]=='TAG'){
        blog.userSearchBlogTag(strs[1], this.currentPage, this.pageSize).then(responese => {
          this.total = responese.data.total;
          this.blogData = responese.data.rows;
          this.loading = false;
        });
      }
      else{
        blog.userSearchBlog(this.searchTxt, this.currentPage, this.pageSize).then(responese => {
          this.total = responese.data.total;
          this.blogData = responese.data.rows;
          this.loading = false;
        })
      }
    },
    coverUrl(tag){
      return "../../static/images/cover/"+tag+".jpg"
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
      scrollTo(0, 200);
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
  }
}
</script>
<style scoped>
  #searchblogData {
    text-align: center;
    margin: -13px 5% 0 5%;
  }
  .loadContent {
  width: 120px;
  height: 30px;
  line-height: 30px;
  font-size: 16px;
  margin: 0 auto;
  color: aliceblue;
  cursor: pointer;
  background: rgba(0, 0, 0, 0.8);
}
</style>
