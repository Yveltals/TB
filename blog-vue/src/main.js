import Vue from 'vue'
import App from './App'
import VueCookies from 'vue-cookies'


import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import axios from 'axios'
import store from './store/store'

import mavonEditor from 'mavon-editor'
import 'mavon-editor/dist/css/index.css'

import router from './router/router'

//引入全局css
import "@/assets/iconfont/iconfont.css";
import '../static/css/ckeditor.css';
import '../static/css/index.css';

Vue.config.productionTip = false
Vue.use(VueCookies)
Vue.use(ElementUI)
Vue.use(mavonEditor)

Vue.prototype.$http = axios


/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  store,
  components: {App},
  template: '<App/>'
})
