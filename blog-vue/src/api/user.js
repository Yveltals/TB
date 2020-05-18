import request from '@/utils/request'
import qs from 'qs';

export default {
  login(name, password) {
    return request({
      url: '/user/login',
      method: 'post',
      data: qs.stringify({'name': name, 'password': password})
    })
  },
  getFile(){
    return request({
        url: '/file/showAll',
        method: 'get',
    })
  },
  fileDownload(id,vm,size){
    return request({
        url: '/file/download',
        method: 'post',
        timeout: 900000,
        data: qs.stringify({'id': id}),
        responseType: 'blob',
        headers:{
          'X-Requested-With': 'XMLHttpRequest'
        },
        onDownloadProgress(a) {
          // console.log(a);
          var strs = new Array();
          strs = size.split(" ");// "32.5 Mb"
          var sizeTotal = parseInt(strs[0])*1024
          if(strs[1]=="Mb") sizeTotal *= 1024
          var rate =  (a.loaded / sizeTotal);
          if (rate < 1) {
            vm.downloadRate = rate;
            // console.log(rate)
            // console.log(a.loaded+'  '+sizeTotal)
            vm.downloadStyle.width = (rate *100).toFixed(2)+ '%';
          }
        }
    })
  },
  fileDelete(id){
    return request({
        url: '/file/delete',
        method: 'post',
        data: qs.stringify({'id': id})
    })
  },
  sendMail(mail) {
    return request({
      url: '/user/sendMail',
      method: 'post',
      data: qs.stringify({'mail': mail})
    })
  },
  register(name, password, mail, mailCode, inviteCode) {
    return request({
      url: '/user/register',
      method: 'post',
      data: qs.stringify({
        'name': name, 'password': password,
        'mail': mail, 'mailCode': mailCode,
        'inviteCode': inviteCode
      })
    })
  },
  forgetPassword(userName, mailCode, newPassword) {
    return request({
      url: '/user/forgetPassword',
      method: 'post',
      data: qs.stringify({'userName': userName, 'mailCode': mailCode, 'newPassword': newPassword})
    })
  },
  getUserMail() {
    return request({
      url: '/user/mail',
      method: 'get',
    })
  },
  updateReward(filePath) {
    return request({
      url: '/user/updateReward',
      method: 'put',
      data: qs.stringify({'imgPath': filePath})
    })
  },
  getUserReward() {
    return request({
      url: '/user/getReward',
      method: 'get',
    })
  },
  updatePassword(oldPassword, newPassword, mailCode) {
    return request({
      url: '/user/updatePassword',
      method: 'post',
      data: qs.stringify({'oldPassword': oldPassword, 'newPassword': newPassword, 'code': mailCode})
    })
  },
  updateMail(newMail, oldMailCode, newMailCode) {
    return request({
      url: '/user/updateMail',
      method: 'post',
      data: qs.stringify({'newMail': newMail, 'oldMailCode': oldMailCode, 'newMailCode': newMailCode})
    })
  },
  getUser(page, showCount) { //管理员分页查询用户数据
    return request({
      url: '/user/' + page + '/' + showCount,
      method: 'get',
    })
  },
  getUserByName(searchName, page, showCount) {   //管理层分页模糊查询用户名
    return request({
      url: '/user/search/' + page + '/' + showCount + '?userName=' + searchName,
      method: 'get',
    })
  },
  banUser(userId, userState) {
    return request({
      url: '/user/ban/' + userId + '/' + userState,
      method: 'get',
    })
  },
  logout(){
    return request({
      url: '/user/logout',
      method: 'get',
    })
  }


}
