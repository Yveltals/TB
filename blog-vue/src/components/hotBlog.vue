<template>
    <div class="tuijian" v-if="hotBlog.length > 0">
      <h2 class="hometitle">点击排行</h2>
      <ul class="tjpic" v-if="hotBlog[0]">
        <i>
          <img style="cursor:pointer" :src="coverUrl(hotBlog[0].tags[0].name)" @click="router(hotBlog[0].id)"
              onerror="javascript:this.src='../../static/images/cover/css.jpg'">
        </i>
        <p style="text-align: left;"><a href="javascript:void(0);" @click="router(hotBlog[0].id)">{{hotBlog[0].title}}</a></p>
      </ul>
      <ul class="sidenews">
        <li v-for="(item,index) in hotBlog"  :key="item.id">
          <i v-if="index!= 0" ><img style="cursor:pointer"   :src="coverUrl(item.tags[0].name)" @click="router(item.id)"></i>
          <p style="text-align: left;"><a href="javascript:void(0);" @click="router(item.id)">{{item.title}}</a></p>
          <span style="text-align: left;">{{getTime(item.time)}}</span>
        </li>
      </ul>
    </div>
</template>

<script>
import blog from '@/api/blog'
import date from '@/utils/date'
export default {
  name: "hotBlog",
  data() {
    return {
      hotBlog: [], //热门博客列表
    };
  },
  created() {
    blog.getHotBlog().then(responese => {
        this.hotBlog = responese.data;
        this.hotBlog[0].photoList = ""
      });
  },
  methods: {
      router(id) {
        scrollTo(0, 0);
        this.$router.push({ 
          path: '/blog/'+id
        })
      },
      getTime(time) {
        return date.timeago(time);
      },
      coverUrl(tag){
      return "../../static/images/cover/"+tag+".jpg"
    },
  }
};
</script>

<style>

</style>
