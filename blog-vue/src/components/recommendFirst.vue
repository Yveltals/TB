<template>
  <div class="banner">
    <el-carousel class="bannerBox" indicator-position="outside" >
      <el-carousel-item  v-for="(item,index) in slideList" :key="index">
            <img
              style="width:100%; height:100%; display:block;cursor:pointer;"
              :src="coverUrl(index)"
              :alt="item.title"
              @click="router(item.id)">
            <div class="carousel-title" @click="router(item.id)">
              <span>{{item.title}}</span>
            </div>
      </el-carousel-item>
    </el-carousel>
  </div>
</template>

<script>
import blog from '@/api/blog'
export default {
  name: "recommendFirst",
  data() {
    return {
      isShow: true, //控制左右滑动按钮是否显示
      slideList: [],
      total: 0,        //数据总数
      blogList: [],   //当前页数据
      pageSize: 3,    //每页显示数量
      currentPage: 1,   //当前页数
      loading: true
    };
  },
  created() {
    this.load()
  },
  methods: {
    router(id) {
      scrollTo(0, 0);
      this.$router.push({
        path: '/blog/'+id
      })
    },
    coverUrl(index){// 0 1 2 3
      if(index==0) return "../../static/images/firstCover1.png" 
      if(index==1) return "../../static/images/firstCover2.jpg" 
      return "../../static/images/firstCover3.jpg"
    },
    load(){
      blog.getRecommendFirst(this.currentPage, this.pageSize).then(responese => {
      this.total = responese.data.total;
      this.slideList = responese.data.rows;
    });
    }
  }
}
</script>

<style>
  .el-carousel__container {
    height: 450px !important;;
  }
.carousel-title span {
  color: white;
  font-size: 22px;
  display: inline-block;
}
@media only screen and (max-width: 1200px) {
  .el-carousel__container {
    height: 360px !important;;
  }
}
  @media only screen and (max-width: 1000px) {
    .el-carousel__container {
      height: 340px !important;;
    }
  }
  @media only screen and (max-width: 960px) {
    .el-carousel__container {
      height: 280px !important;;
    }
  }
  @media only screen and (max-width: 500px) {
    .el-carousel__container {
      height: 200px !important;;
    }
  }
.carousel-title {
  cursor: pointer;
  position: absolute;
  z-index: 10;
  bottom: 40px;
  height: 40px;
  width: 100%;
  line-height: 40px;
  text-align: center;
  background: rgba(0, 0, 0, 0.3);
}
.el-carousel__item h3 {
  color: #475669;
  font-size: 18px;
  opacity: 0.75;
  line-height: 300px;
  margin: 0;
}

.el-carousel__item:nth-child(2n) {
  background-color: #99a9bf;
}

.el-carousel__item:nth-child(2n+1) {
  background-color: #d3dce6;
}
</style>
