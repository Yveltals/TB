<template>
  <div>
    <el-dialog title="添加标签" :visible.sync="flag">
      <el-form style="margin-left: -5%">
        <el-form-item label="分类类别" :label-width="'120px'">
          <el-input v-model="newTag" autocomplete="off" placeholder="请输入" maxlength="255"
                    show-word-limit></el-input>
        </el-form-item>
      </el-form>
      <div slot="footer" class="dialog-footer">
        <el-button @click="flag = false">取 消</el-button>
        <el-button type="primary" @click="sendTag()">确 定</el-button>
      </div>
    </el-dialog>

    <div style="text-align: right;margin-bottom: 5px">
      <el-button style="width: 12%;text-align: center" @click="flag = true">添加新标签</el-button>
    </div>

    <div v-loading="loading" style="height:620px">
      <el-table :data="tagList" style="width: 100%" :border="true">
        <el-table-column label="标签" width="300">
          <template slot-scope="scope">
            <i class="el-icon-menu"></i>
            <span style="margin-left: 10px">{{ scope.row.name}}</span>
          </template>
        </el-table-column>
        <el-table-column label="文章数" width="650">
          <template slot-scope="scope">
            <i class="el-icon-wind-power"></i>
            <span style="margin-left: 10px">{{ scope.row.blogcnt }}</span>
          </template>
        </el-table-column>
        <el-table-column label="操作">
          <template slot-scope="scope">
            <el-button
              size="mini"
              @click="flag = true,curTagId = scope.row.id">编辑</el-button>
            <el-button
              size="mini"
              type="danger"
              @click="handleDelete(scope.row.id, scope.row.blogcnt)">删除</el-button>
          </template>
        </el-table-column>
      </el-table>
    </div>
    <div id="page">
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
  import tag from '@/api/tag'

  export default {
    name: 'codeManage',
    data() {
      return {
        flag:false, //显示添加标签对话框
        curTagId:0,//选中修改/删除
        newTag:'', 
        tagList: [],
        total: 0,        //数据总数
        pageSize: 10,    //每页显示数量
        currentPage: 1,   //当前页数
        loading: true
      }
    },
    created() {
      this.load()
    },
    methods: {
      load() {
        tag.getTagAllByPage(this.currentPage, this.pageSize).then(res => {
          this.tagList = res.data.rows;
          this.total = res.data.total;
          this.loading = false;
          // console.log(this.tagList)
        });
      },
      currentChange(currentPage) { //页码更改事件处理
        this.currentPage = currentPage;
        this.load();
        scrollTo(0, 0);
      },
      sendTag() { //修改/添加标签
        if (this.newTag.length <= 0) {
          this.$notify({title: '提示',type: 'error',message: '字段不完整',duration: 3000 });
          return;
        }
        if(this.curTagId==0){
          tag.sendTag(this.newTag).then(res => {
            this.$notify({title: '提示',type: 'success',message: '添加成功',duration: 3000 });
            this.clear()
          })
        }
        if(this.curTagId!=0){
          tag.updateTag(this.curTagId,this.newTag).then(res=>{
            this.$notify({title: '提示',type: 'success',message: '修改成功',duration: 3000 });
            this.clear()
          })
        }
      },
      handleDelete(id,blogcnt){
        this.$confirm('确认删除文件？','提示',{
            confirmButtonText: '确定',
            cancelButtonText: '取消',
            type: 'warning'
        }).then(()=>{
          tag.deleteTag(id).then(res=>{
          this.$notify({title: '提示',type: 'success',message: '删除成功',duration: 3000 });
          this.load();
        })
        }).catch(()=>{})
        
      },
      clear(){
        this.newTag = ''
        this.curTagId = 0
        this.flag = false
        this.load();
      }
    }
  }
</script>
<style scoped>
  #page{
    margin-top: 10px;
    padding-bottom:4% ;
    
  }
</style>