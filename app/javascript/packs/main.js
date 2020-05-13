import Vue      from 'vue';
import App      from '../app.vue'
import store    from './store.js'
import router   from './router.js'
import Vuetify  from 'vuetify'

import 'material-design-icons-iconfont/dist/material-design-icons.css'
import 'vuetify/dist/vuetify.min.css'

Vue.use(Vuetify)
const vuetify = new Vuetify({ icons: { iconfont: 'md' } });

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