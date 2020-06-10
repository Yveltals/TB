<template>
    <div class="links">
      <h2 class="hometitle">友情链接</h2>
      <ul>
          <li v-for="item in linkData" :key="item.uid">
            <img :src='item.img' @click="goLink(item)" width="50px" height="50px">
            <a  href="javascript:void(0);" @click="goLink(item)">{{item.title}}</a>
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
  },
  methods: {
    goLink: function(item) {
      window.location.href = item.url;
    }
  }
};
</script>

<style>
</style>
