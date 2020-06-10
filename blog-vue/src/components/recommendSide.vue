<template>
  <div class="zhuanti" >
    <h2 class="hometitle">特别推荐</h2>
    <ul>
      <li>
        <i>
          <img  src="../../static/images/recommendSide.png">
        </i>
        <p>{{item.title}} 
          <span><a href="javascript:void(0);" @click="router(item.id)">阅读</a></span>
        </p>
      </li>
    </ul>
  </div>
</template>

<script>
import blog from '@/api/blog'
import router from '../router/router'
export default {
  name: "recommendSide",
  data() {
    return {
      thirdData: [],
      item: {},
    };
  },
  created() {
    blog.getHotBlog().then(responese => {
        this.thirdData = responese.data;
        this.item = responese.data[0];
        // console.log(this.thirdData[0].title)
    });
  },
  methods: {
    router(id) {
        scrollTo(0, 0);
        this.$router.push({
          path: '/blog/'+id
        })
      }}
};
</script>

<style>
</style>
