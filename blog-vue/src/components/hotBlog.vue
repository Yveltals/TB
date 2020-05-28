<template>
    <div class="tuijian" v-if="hotBlog.length > 0">
      <h2 class="hometitle">点击排行</h2>
      <ul class="tjpic" v-if="hotBlog[0]">
        <i><img style="cursor:pointer" :src="imageUrlFirst" @click="router(hotBlog[0].id)"></i>
        <p style="text-align: left;"><a href="javascript:void(0);" @click="router(hotBlog[0].id)">{{hotBlog[0].title}}</a></p>
      </ul>
      <ul class="sidenews">
        <li v-for="item in hotBlog"  :key="item.id">
          <i><img style="cursor:pointer"   :src="imageUrlOther" @click="router(item.id)"></i>
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
      imageUrlFirst: "http://demopicture.moguit.cn//blog/admin/jpg/2020/4/15/1586946598186.jpg",
      imageUrlOther: "http://demopicture.moguit.cn//blog/admin/jpg/2020/4/15/1586946618433.jpg",
      hotBlog: [], //热门博客列表
    };
  },
  created() {
    blog.getHotBlog().then(responese => {
        this.hotBlog = responese.data;
        this.hotBlog[0].photoList = ""
        // console.log(this.hotBlog)
      });
  },
  methods: {
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
};
</script>

<style>

</style>
