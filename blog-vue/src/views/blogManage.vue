<template>
  <div>
    <div style="text-align: right;margin-bottom: 5px">
      <el-button style="width: 7%;text-align: center" v-if="searchFlag == true" @click="returnNormal()">返回</el-button>

      <el-input placeholder="模糊查询标题" v-model="searchName" suffix-icon="el-icon-search"
                style="width: 30%;" @keyup.enter.native="searchSubmit"/>
    </div>
    <div v-loading="loading" style="height:600px">
      <el-table :data="blogData" style="width: 100%" :border="true" >
        <el-table-column label="标题" width="400">
          <template slot-scope="scope">
            <i class="el-icon-tickets"></i>
            <span style="margin-left: 10px">{{ scope.row.title }}</span>
          </template>
        </el-table-column>

        <el-table-column label="发布时间" width="220">
          <template slot-scope="scope">
            <i class="el-icon-time"></i>
            <span style="margin-left: 10px">{{ getTime(scope.row.time) }}</span>
          </template>
        </el-table-column>

        <el-table-column label="用户" width="160">
          <template slot-scope="scope">
            <i class="el-icon-user"></i>
            <span style="margin-left: 10px">{{ scope.row.user.name }}</span>
          </template>
        </el-table-column>

        <el-table-column label="状态" width="160">
          <template slot-scope="scope">
            <i class="el-icon-wind-power"></i>
            <span style="margin-left: 10px" v-if="scope.row.state == 1">正常</span>
            <span style="margin-left: 10px;color:#F56C6C " v-if="scope.row.state == 0">封禁</span>
          </template>
        </el-table-column>

        <el-table-column label="操作" width="228">

          <template slot-scope="scope">
                       
            <el-button size="mini" v-if="scope.row.top == 0"
                       @click="topBlog(scope.row.id, scope.row.top)">
              置顶
            </el-button>
            <el-button size="mini" v-if="scope.row.top == 1" type="warning"  plain
                       @click="topBlog(scope.row.id, scope.row.top)">
              取消
            </el-button>
            <el-button size="mini" v-if="scope.row.state == 1" type="warning" 
                       @click="banBlog(scope.row.id, scope.row.state,scope.row.top)">
              封禁
            </el-button>
            <el-button size="mini" v-if="scope.row.state == 0" type="warning" plain
                       @click="banBlog(scope.row.id, scope.row.state)">
              解封
            </el-button>
            <el-button size="mini" type="danger" 
                       @click="deleteBlog(scope.row.id)">
              删除
            </el-button>

          </template>
        </el-table-column>
      </el-table>
    </div>
    <br/>
    <div style="padding-bottom: 4%">
      <el-pagination
        :page-size="pageSize"
        background
        layout="prev, pager, next"
        :total="total"
        @current-change="currentChange"
        :current-page="currentPage"
        @prev-click="currentPage=currentPage-1"
        @next-click="currentPage=currentPage+1"
        :hide-on-single-page="true">
      </el-pagination>
    </div>
  </div>
</template>
<script>
  import blog from '@/api/blog'
  import date from '@/utils/date'

  export default {
    name: 'blogManage',
    data() {
      return {
        blogData: [],
        total: 0,        //数据总数
        pageSize: 10,    //每页显示数量
        currentPage: 1,   //当前页数
        loading: true,
        searchName: '',
        searchFlag: false   //搜索状态 true 显示搜索数据 false显示正常数据
      }
    },
    created() {
      this.load()
    },
    methods: {
      load() {
        if (this.searchFlag) {
          blog.adminSearchBlog(this.searchName, this.currentPage, this.pageSize).then(res => {
            this.blogData = res.data.rows;
            this.total = res.data.total;
            this.loading = false;
          })
        }
        else {
          blog.adminGetBlog(this.currentPage, this.pageSize).then(res => {
            this.blogData = res.data.rows;
            this.total = res.data.total;
            this.loading = false;
          })
        }
      },
      currentChange(currentPage) { //页码更改事件处理
        this.currentPage = currentPage;
        this.load();
        scrollTo(0, 0);
      },
      searchSubmit() {
        this.currentPage = 1;
        this.loading = true;
        this.searchFlag = true;
        this.load()
      },
      returnNormal() {
        this.currentPage = 1;
        this.searchName = ''
        this.loading = true;
        this.searchFlag = false;
        this.load()
      },
      getTime(time) {
        return date.timeago(time)
      },
      deleteBlog(id) {
        this.$confirm('是否删除此博客?', '提示', {
          confirmButtonText: '确定',
          cancelButtonText: '取消',
          type: 'warning'
        }).then(() => {
          blog.adminDeleteBlog(id).then(res => {
            this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
            this.load();
          });
        }).catch(() => {
        })

      },
      banBlog(id,state,top) {
        if(top==1) {
          this.$notify({title: '提示',type: 'error',message: '请先取消置顶',duration: 3000 });
          return 
        }
        blog.adminBanBlog(id,state).then(res=>{
          if (state == 1) {
            this.$notify({title: '提示',type: 'success',message: '封禁成功',duration: 3000 });
          } else {
            this.$notify({title: '提示',type: 'success',message: '解封成功',duration: 3000 });
          }
          this.load()
        })
      },
      topBlog(id,top) {
        blog.adminTopBlog(id,top).then(res=>{
          var returnType = 'success'
          if(res.message=='至少需置顶两篇博客')
          returnType = 'error'
          this.$notify({title: '提示',type: returnType,message: res.message,duration: 3000 });
          this.load()
        })
      }
    }
  }
</script>
