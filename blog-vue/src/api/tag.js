import request from '@/utils/request'
import qs from 'qs';

export default {
  getTagAll() {
    return request({
      url: '/tag/all',
      method: 'get'
    })
  },
  getTagAllByPage(page, showCount) {
    return request({
      url: '/tag/'+page + '/' + showCount,
      method: 'get'
    })
  },
  sendTag(tagName) {
    return request({
      url: '/tag',
      method: 'post',
      data: qs.stringify({'tagName': tagName})
    })
  },
  deleteTag(tagId) {
    return request({
      url: '/tag/' + tagId,
      method: 'delete',
    })
  },
  updateTag(tagId, tagName) {
    return request({
      url: '/tag',
      method: 'put',
      data: qs.stringify({'tagId': tagId, 'tagName': tagName})
    })
  }

}
