<template>
  <div style="min-height: 870px;">
    <div class="pagebg classify"></div>
    <div class="container">
      <h1 class="t_nav">
        <a href="/" class="n1">网站首页</a>
        <a href="javascript:void(0);" class="n2">分类</a>
      </h1>

      <div class="sortBox">
        <div class="time">
          <div class="block">
            <div class="radio" style="margin-bottom:20px;"></div>
            <el-timeline :reverse="reverse">
              <el-timeline-item style="text-align: left" v-for="(activity, index) in activities" hide-timestamp :key="index">
                <span
                  @click="getBlogList(activity.name)"
                  :class="[activity.id == selectBlogUid ? 'sortBoxSpan sortBoxSpanSelect' : 'sortBoxSpan']"
                >{{activity.name}}</span>
              </el-timeline-item>
            </el-timeline>
          </div>
        </div>

        <div class="sortBoxarticle">
          <div class="block">
            <el-timeline>
              <el-timeline-item
                v-for="item in blogByDate"
                :key="item.id"
                style="text-align: left"
                :timestamp="getTime(item.time)"
                placement="top"
                >
                <el-card>
                  <h4 style="text-align: left" @click="router(item.id)" class="itemTitle">{{item.title}}</h4>
                  <br>
                  <div style="text-align: left">
                    <el-tag class="elTag" type="danger">原创</el-tag>
                    <el-tag class="elTag" v-if="item.user.name">{{item.user.name}}</el-tag>
                    <el-tag class="elTag" type="info" v-for="tag in item.tags" :key="tag.id">{{tag.name}}</el-tag>
                  </div>
                </el-card>
              </el-timeline-item>
            </el-timeline>
          </div>
        </div>

        <div class="bottomPagination">
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

    </div>
  </div>
</template>

<script>
import blog from '@/api/blog'
import tag from '@/api/tag'
import date from '@/utils/date'
export default {
  name: 'classify',
  data() {
    return {
      firstTagName:'',
      curTagName: '',
      lastTagName:'',
      selectBlogUid: "",
      reverse: false,
      activities: [],
      blogByDate: [],
      total: 0,  
      currentPage: 1,
      pageSize: 4
    };
  },
  created() {
    this.getTagList()
  },
  mounted(){
    this.curTagName = this.$route.params.tag
    this.getBlogList(this.curTagName)
  },
  methods: {
    getTagList(){
      tag.getTagAll().then(res=>{
        if(res.code==200){
          var activities  =res.data;
          var result = [];
          for (var a = 0; a < activities.length; a++) {
            var dataForDate = {
              name: activities[a].name,
              id: activities[a].id
            };
            result.push(dataForDate);
          }
          this.activities = result;
          if(this.curTagName==null){
            this.getBlogList(activities[0].name);
            this.curTagName = activities[0].name
          }
        }
      })
    },
    getBlogList(TagName) {
      if(this.lastTagName!=TagName) this.currentPage = 1
      this.curTagName =TagName
      blog.userSearchBlogTag(TagName, this.currentPage,this.pageSize).then(res=>{//暂时...
        if(res.code==200){
          this.blogByDate = res.data.rows;
        }
      })
      blog.userSearchBlogTagCnt(TagName).then(response=>{
        if(response.code==200){
          this.total = response.data;
        }
      })
      this.lastTagName = TagName
    },
    currentChange(currentPage) { //页码更改事件处理
      this.currentPage = currentPage;
      this.getBlogList(this.curTagName);
    },
    //跳转到搜索详情页
    router(id) {
        scrollTo(0, 0);
        this.$router.push({ //路由跳转
          path: '/blog/'+id
        })
    },
    getTime(time) {//将时间戳转化为几分钟前，几小时前
      return date.timeago(time);
    },
  }
}
</script>


<style>
.sortBox {
  color: #555;
}
.sortBoxSpan {
  cursor: pointer;
}
.sortBoxSpan:hover {
  color: #409eff;
}
.sortBoxSpanSelect {
  color: #409eff;
}
.bottomPagination{
  margin-left: 20px;
  float: center;
  width: 78%;
  height: 70px;
  overflow: scroll;
  overflow-x: hidden;
  overflow-y: auto;
}
.sortBoxarticle {
    margin-left: 20px;
    float: left;
    width: 78%;
    height: 700px;
    overflow: scroll;
    overflow-x: hidden;
    overflow-y: auto;
}
.itemTitle {
  cursor: pointer;
}
.itemTitle:hover {
  color: #409eff;
}
.elTag {
  cursor: pointer;
}
</style>
