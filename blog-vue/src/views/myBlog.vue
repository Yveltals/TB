<template>
  <div style="min-height: 870px;">
    <div class="pagebg sorts"></div>
    <div class="container">
      <h1 class="t_nav">
        <a href="/" class="n1">网站首页</a>
        <a href="javascript:void(0);" class="n2">我的博文</a>
      </h1>

      <div class="sortBox">
        <myBlogList/>
      </div>
    </div>
  </div>
</template>
<script>
import myBlogList from '@/components/myBlogList'
import tagCloud from '@/components/tagCloud'

export default {
  name: 'myBlog',
  components: {myBlogList,tagCloud}
}
</script>
<style scoped>
  #myBlog{
    margin: auto 1%;
  }
</style>
