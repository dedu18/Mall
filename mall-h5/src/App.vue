<template>
  <div id="app">
    <IndexHeader></IndexHeader>
    <router-view/>
    <!-- 部分路由不应该包含这个Footer -->
    <Footer v-if="excludeRoutes.indexOf($route.name) == -1"></Footer>
  </div>
</template>

<script>
import IndexHeader from './views/index/IndexHeader';
import Footer from './views/footer/Footer';
export default {
  name: 'App',
  data () {
    return {
      excludeRoutes: ['HomeIndex', 'MyAddress', 'AddAddress', 'MyOrder', 'MyShoppingCart']
    };
  },
  components: {
    IndexHeader,
    Footer
  }
};
</script>
