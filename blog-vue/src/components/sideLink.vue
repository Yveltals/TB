<template>
    <div class="links">
      <h2 class="hometitle">友情链接</h2>
      <ul>
          <li v-for="item in linkData" :key="item.uid">
            <img :src='item.img' width="50px" height="50px">
            <a  :href="item.url" target="_blank">{{item.title}}</a>
          </li>
      </ul>
    </div>
</template>

<script>
export default {
  name: "sideLink",
  data() {
    return {
      linkData: [
        {uid:1, title:'Github', url:'https://github.com/Necrosma/Technology-blog/',img:'../../static/images/github.jpg'},
        {uid:2, title:'Gitee', url:'https://gitee.com/',img:'../../static/images/gitee.jpg'}
      ], 
    };
  }
};
</script>

<style>
</style>
