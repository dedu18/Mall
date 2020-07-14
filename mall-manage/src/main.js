// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue'
import App from './App'
import router from './router'
import ElementUI from 'element-ui'
import 'element-ui/lib/theme-chalk/index.css'
import VueResource from 'vue-resource'
import breadCrumb from './components/Breadcrumb.vue'

Vue.config.productionTip = false
Vue.use(ElementUI);
Vue.use(VueResource);
Vue.component("m-breadcrumb", breadCrumb)

router.beforeEach(function (to, from, next) {
  if (to.meta.needLogin) {
    if (localStorage.getItem("ms_username")) {
      next();
    } else {
      next({
        name: "login"
      });
    }
  } else {
    next(); //继续往后走
  }
});

/* eslint-disable no-new */
new Vue({
  el: '#app',
  router,
  components: {App},
  template: '<App/>'
})
