import Vue        from 'vue'
import VueRouter  from 'vue-router'
import Top        from './views/Top.vue'
import About      from './views/About.vue'
import WeekTask   from './views/WeekTask.vue'
import Task  from './views/Task.vue'

import Monday     from './views/weeks/Monday.vue'
import Tuesday    from './views/weeks/Tuesday.vue'
import Wednesday  from './views/weeks/Wednesday.vue'
import Thursday   from './views/weeks/Thursday.vue'
import Friday     from './views/weeks/Friday.vue'
import Saturday   from './views/weeks/Saturday.vue'
import Sunday     from './views/weeks/Sunday.vue'

Vue.use(VueRouter)
export default new VueRouter({
  mode: 'history',
  routes: [
    { path: '/',          component: Top },
    { path: '/about',     component: About },
    { path: '/weektask',  component: WeekTask },
    { path: '/task',      component: Task },
    { path: '/monday',     component: Monday },
    { path: '/tuesday',    component: Tuesday},
    { path: '/wednesday',  component: Wednesday},
    { path: '/thursday',   component: Thursday},
    { path: '/friday',     component: Friday},
    { path: '/saturday',   component: Saturday},
    { path: '/sunday',     component: Sunday} 
  ] 
})