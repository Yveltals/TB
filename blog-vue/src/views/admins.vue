<template>
  <div style="width: 99%; min-height: 870px;">
    <el-container>
      <el-aside style="width: 20%; margin-bottom: -3%">
        <div id="aside">
          <el-menu :router="true" :default-active="activeIndex" class="el-menu-vertical-demo" style="height:870px" background-color="#545c64" text-color="#fff" active-text-color="#ffd04b" @select="handleSelect">
            <el-menu-item style="margin-top:70px" class="menuItem" index="1" route="/admins/userManage">
              <i class="el-icon-user-solid" ></i>
              <span slot="title">用户管理</span>
            </el-menu-item>

            <el-menu-item class="menuItem" index="2" route="/admins/codeManage">
              <i class="el-icon-menu"></i>
              <span slot="title">标签管理</span>
            </el-menu-item>

            <el-menu-item class="menuItem" index="3" route="/admins/announcementManage">
              <i class="el-icon-data-board"></i>
              <span slot="title">公告管理</span>
            </el-menu-item>

            <el-menu-item class="menuItem" index="4" route="/admins/blogManage">
              <i class="el-icon-document"></i>
              <span slot="title">博客管理</span>
            </el-menu-item>
          </el-menu>
        </div>
      </el-aside>
      <el-main style="width: 75%">
        <router-view/>
      </el-main>

    </el-container>

  </div>
</template>
<script>
  //vue不支持文件名为admin的文件
  export default {
    name: 'admins',
    data() {
      return {
        activeIndex: '1'
      }
    },
    watch: {
      // 监控当前页面path，防止刷新页面显示错误
      '$route.path': {
        deep: true,
        immediate: true,
        handler(to, from) {
          if (to === '/admins/codeManage') {
            this.activeIndex = '2'
          } else if (to === '/admins/announcementManage') {
            this.activeIndex = '3'
          } else if (to === '/admins/blogManage') {
            this.activeIndex = '4'
          }
        }
      }
    },
    methods: {
      handleSelect(key, keyPath) {
        this.activeIndex = key
      }
    }
  }
</script>
<style scoped>
  .menuItem {
    margin: 15% 0;
  }

  #aside {
    margin: 0px 60px 0px 0px;
    box-shadow: 0 2px 4px rgba(0, 0, 0, .12), 0 0 6px rgba(0, 0, 0, .04)
  }
</style>
