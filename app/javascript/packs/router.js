import Vue        from 'vue'
import VueRouter  from 'vue-router'
import Top        from './views/Top.vue'
import About      from './views/About.vue'
import Task       from './views/Task.vue'

Vue.use(VueRouter)
export default new VueRouter({
  routes: [
    { path: '/',      component: Top },
    { path: '/about', component: About },
    { path: '/task',  component: Task },
  ]
})