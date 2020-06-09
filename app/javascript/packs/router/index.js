import Vue        from 'vue'
import VueRouter  from 'vue-router'
import store      from '../store/index'
import Top        from '../views/Top.vue'
import About      from '../views/About.vue'
import WeekTask   from '../views/WeekTask.vue'
import TodayTask  from '../views/TodayTask.vue'
import SignUp     from '../views/SignUp.vue'
import SignIn     from '../views/SignIn.vue'

import Monday     from '../views/weeks/Monday.vue'
import Tuesday    from '../views/weeks/Tuesday.vue'
import Wednesday  from '../views/weeks/Wednesday.vue'
import Thursday   from '../views/weeks/Thursday.vue'
import Friday     from '../views/weeks/Friday.vue'
import Saturday   from '../views/weeks/Saturday.vue'
import Sunday     from '../views/weeks/Sunday.vue'

Vue.use(VueRouter);

const routes = [
  { path: '/',           name: 'top',       component: Top },
  { path: '/about',      name: 'about',     component: About },
  { path: '/signup',     name: 'signup',    component: SignUp },
  { path: '/signin',     name: 'signin',    component: SignIn },
  { path: '/weektask',   name: 'weektask',  component: WeekTask,  meta: { requiresAuth: true } },
  { path: '/todaytask',  name: 'todaytask', component: TodayTask, meta: { requiresAuth: true } },
  { path: '/monday',     name: 'monday',    component: Monday,    meta: { requiresAuth: true } },
  { path: '/tuesday',    name: 'tuesday',   component: Tuesday,   meta: { requiresAuth: true } },
  { path: '/wednesday',  name: 'wednesday', component: Wednesday, meta: { requiresAuth: true } },
  { path: '/thursday',   name: 'thursday',  component: Thursday,  meta: { requiresAuth: true } },
  { path: '/friday',     name: 'friday',    component: Friday,    meta: { requiresAuth: true } },
  { path: '/saturday',   name: 'saturday',  component: Saturday,  meta: { requiresAuth: true } },
  { path: '/sunday',     name: 'sunday',    component: Sunday,    meta: { requiresAuth: true } },
]

const router = new VueRouter({
  mode: 'history',
  routes
});

router.beforeEach((to, from, next) => {
  const authHeaders = store.state.auth.auth
  if(to.matched.some(record  => record.meta.requiresAuth) && !authHeaders) {
    next({ path: '/signin', query: { redirect: to.fullPath } });
  } else {
    next();
  }
})

export default router;