<template>
  <div style="min-height: 870px;">
    <div class="pagebg classify"></div>
    <div class="container">
      <h1 class="t_nav">
        <span>不要轻易放弃。学习成长的路上，我们长路漫漫，只因学无止境。</span>
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

        <div class="article">
          <div class="block" v-infinite-scroll="load">
            <el-timeline>
              <el-timeline-item
                v-for="item in itemByDate"
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
                    <el-tag class="elTag" v-for="tag in item.tags" :key="tag.id" type="success">{{tag.name}}</el-tag>
                  </div>
                </el-card>
              </el-timeline-item>
            </el-timeline>
          </div>
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
      selectBlogUid: "",
      reverse: false,
      activities: [],
      itemByDate: [],
      articleByDate: {},
      count: 0,
      currentPage: 1,
      pageSize: 10
    };
  },
  created() {
    var that = this;
    tag.getTagAll().then(res=>{
      console.log(res.data)
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
        this.getBlogList(activities[0].name);
      }
    })
  },
  methods: {
    getBlogList(TagName) {
      // this.selectBlogUid = Tagid;
      blog.userSearchBlogTag(TagName, 1, 6).then(res=>{//暂时...
        if(res.code==200){
          console.info('-----')
          console.log(res.data)
          this.itemByDate = res.data.rows;
        }
      })
    },
    load() {
      var params = new URLSearchParams();
      if (
        this.selectBlogUid == null ||
        this.selectBlogUid == "" ||
        this.selectBlogUid == undefined
      ) {
        return;
      }
      params.append("Tagid", this.selectBlogUid);
      params.append("currentPage", this.currentPage + 1);
      getArticleByBlogSortUid(params).then(response => {
        if (response.code == "success") {
          this.itemByDate = this.itemByDate.concat(response.data.records);
          this.currentPage = response.data.current;
          this.pageSize = response.data.size;
        }
      });
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
