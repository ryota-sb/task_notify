import Vue       from 'vue'
import App       from '../app.vue'
import axios     from 'axios'
import store     from './store/index'
import router    from './router/index'
import Vuetify   from 'vuetify'
import cookie    from 'vue-cookies'
import status    from 'http-status'
import { pick }  from 'lodash'
import 'material-design-icons-iconfont/dist/material-design-icons.css'
import 'vuetify/dist/vuetify.min.css'

Vue.prototype.$axios = axios.create()

// リクエストを送る前にユーザーを認証する
Vue.prototype.$axios.interceptors.response.use(response => {
  if(response.headers['access-token']) {
    const authHeaders = pick(response.headers, ["access-token", "client", "uid", "expiry", "token-type"])
    console.log(authHeaders)
    store.commit('auth', authHeaders)

    let session = cookie.get('session')
    if(session) {
      let session = JSON.parse(session)
      session['tokens'] = authHeaders
      cookie.set('session', JSON.stringify(session), { expires: '14D' })
    }
  }
  return response
}, (error) => {
  if(router.currentRoute.name !== 'signin' && error.response.status === status.UNAUTHORIZED) {
    store.commit('user', null)
    router.push({ name: 'signin' })
  }
  return Promise.reject(error)
})

Vue.use(Vuetify);
const opts = { icons: { iconfont: 'md' } };
const vuetify = new Vuetify(opts);

document.addEventListener('DOMContentLoaded', () => {
  const app = new Vue({
    store,
    router,
    vuetify,
    render: h => h(App)
  }).$mount()
  document.body.appendChild(app.$el)

  console.log(app)
})