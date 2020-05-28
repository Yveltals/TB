<template>
  <div class="cloud" v-if="hotTagData.length > 0">
    <h2 class="hometitle">分类板块</h2>
    <ul>
      <a v-for="item in hotTagData" :key="item.id" href="javascript:void(0);" >{{item.name}}</a>
    </ul>
  </div>
</template>

<script>
import tag from '@/api/tag'
export default {
  name: "tagCloud",
  data() {
    return {
      hotTagData: [] //标签列表
    };
  },
  created() {
    this.hotTagData = []
    tag.getTagAll().then(response => {
      this.hotTagData = response.data;
    });
  },
  methods: {
    //跳转到搜索详情页
  }
};
</script>

<style>
</style>
