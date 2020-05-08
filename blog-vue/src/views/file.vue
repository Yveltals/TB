<template>
  <el-card id="file">
    <div id="updatePwd">
    <el-container>
        <el-header>
            <h2>--文件列表--</h2>
        </el-header>

        <el-divider/>
        
        <el-container>
            <el-aside style="width: 30%">
                <br>
                <br>
                <el-upload
                    class="upload-demo"
                    drag
                    action="123"
                    :show-file-list="false"
                    :on-change="fileChange"
                    :http-request="SubbmitFile"
                    >
                    <i class="el-icon-upload"></i>
                    <div class="el-upload__text">将文件拖到此处，或<em>点击上传</em></div>
                    <div class="el-upload__tip" slot="tip">上传文件不超过500Mb</div>
                </el-upload>
                
            </el-aside>
            <el-main style="width: 60%">
                <el-table :data="files" style="width: 100%">
                    <!-- <el-table-column label="ID" width="100">
                    <template slot-scope="scope">
                        <span style="margin-left: 10px">{{ scope.row.id }}</span>
                    </template>
                    </el-table-column> -->

                    <el-table-column label="文件名" width="200">
                    <template slot-scope="scope">
                        <span style="margin-left: 10px">{{ scope.row.name }}</span>
                    </template>
                    </el-table-column>

                    <el-table-column label="类型" width="120">
                    <template slot-scope="scope">
                        <div slot="reference" class="name-wrapper">
                            <el-tag size="medium">{{ scope.row.type }}</el-tag>
                        </div>
                    </template>
                    </el-table-column>

                    <el-table-column label="大小" width="120">
                    <template slot-scope="scope">
                        <span style="margin-left: 10px">{{ scope.row.size }}</span>
                    </template>
                    </el-table-column>

                    <el-table-column label="上传时间" width="200">
                    <template slot-scope="scope">
                        <i class="el-icon-time"></i>
                        <span style="margin-left: 10px">{{ scope.row.uploadTime }}</span>
                    </template>
                    </el-table-column>

                    <el-table-column label="操作">
                    <template slot-scope="scope">
                        <el-button size="mini" type="success" plain
                            @click="DownloadFile(scope.row.id,scope.row.name)">下载</el-button>
                        <el-button size="mini" type="danger" plain
                            @click="DeleteFile(scope.row.id)">删除</el-button>
                    </template>
                    </el-table-column>
                </el-table>
            </el-main>
        </el-container>
    </el-container>
    </div>
  </el-card>
</template>

<script>
    import axios from 'axios'
    import user from '@/api/user'
    import store from '@/store/store'
    var token =  localStorage.getItem('token')
    
    export default {
    name: 'file',
    data() {
        return {
            files:[{id:0, name:'',size:0, type:'',uploadTime:''}],
            fileList: [],
            file: {},
      }
    },
    created() {
      this.load();
    },
    methods: {
        fileChange(e,list){
            this.file=e;
        },
        SubbmitFile(){
            console.info("submit")
            let param = new FormData(); //创建form对象
            
            param.append("file", this.file.raw); //通过append向form对象添加数据
            let config = {
                headers: { "Content-Type": "multipart/form-data" }
            };
            config.headers['Authorization'] = store.state.token
            console.log("param:")
            console.log(param)
            axios.post("http://127.0.0.1:8080/file/upload/", param, config)
                .then(response => {
                    this.load()
                    this.file={}
                    console.log(response.data);
                }).catch(
                error=>{
                    alert("失败");
                }
            );
        },
        load() {
            user.getFile().then(res => {
                console.log(res.data);
                console.info("-------------------");
                this.files = res.data;
            })
        },
        DeleteFile(id) {
            // return this.$confirm(`确定移除？`);
            this.$confirm('确认删除文件？','提示',{
                confirmButtonText: '确定',
                cancelButtonText: '取消',
                type: 'warning'
            }).then(()=>{
                user.fileDelete(id)
                .then(res =>{
                    this.load()
                    console.log("Deleted.")
                })
                .catch(() => {
                    this.$message.error("删除失败，请联系管理员");
                });
            }).catch(()=>{
                layer.msg('已取消删除',{icon:5,time:1000});
            })
        },
        DownloadFile(id,name) {
            console.log("-----------"+ id)
            user.fileDownload(id)
            .then(res => {
                console.info("已获取Blob 开始下载...")
                console.log(res)
                if (res) {
                    const content = res;
                    const blob = new Blob([content]);
                    const fileName = name; ///////////-----------
                    if ("download" in document.createElement("a")) {
                        // 非IE下载
                        const elink = document.createElement("a");
                        elink.download = fileName;
                        elink.style.display = "none";
                        elink.href = URL.createObjectURL(blob);
                        document.body.appendChild(elink);
                        elink.click();
                        URL.revokeObjectURL(elink.href); // 释放URL 对象
                        document.body.removeChild(elink);
                    } else {
                        // IE10+下载
                        navigator.msSaveBlob(blob, fileName);
                    }
                }
            })
            .catch(() => {
                this.$message.error("下载失败，请联系管理员");
            });
        },
    },
  }
</script>

<style scoped>
</style>
