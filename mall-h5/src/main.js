// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue';
import App from './App';
import router from './router';
import store from './vuex/store'
import iView from 'iview';
import 'iview/dist/styles/iview.css';

import {Sku, Button} from 'vant';
import 'vant/lib/index.css';


Vue.use(iView);
Vue.use(Sku);
Vue.use(Button);

Vue.config.productionTip = false;
//开启vue-devtools
Vue.config.devtools = true

router.beforeEach((to, from, next) => {
  iView.LoadingBar.start();

  if (to.meta.requireAuth) {
    if (store.state.userInfo.sessionId) {
      next()
    } else {
      next({path: '/Login'})
    }
  } else {
    next()
  }
});

router.afterEach(route => {
  iView.LoadingBar.finish();
});

new Vue({
  el: '#app',
  router,
  store,
  components: {App},
  template: '<App/>'
});
