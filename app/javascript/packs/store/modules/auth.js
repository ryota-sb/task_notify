import axios    from 'axios'
import cookie   from 'vue-cookies'
import router   from '../../router/index'
import { pick } from 'lodash'

export const auth = {
  namespaced: true,
  state: {
    users: [],
    user: null,
    auth: {}
  },
  getters: {
    user: state => state.user,
    auth: state => state.auth
  },
  mutations: {
    user(state, value) {
      state.user = value
    },
    auth(state, value) {
      state.auth = value
    },
    login(state, user) {
      state.users = user
    },
    logout(state) {
      state.auth = {}
    }
  },
  actions: {
    signUp({ commit }, params) {
      axios.post('/api/auth', params).then(response => {
        commit('login', response.data)
        router.push({ name: 'signin' })
      }).catch(error => {
        console.log(error)
      })
    },
    signIn({ commit }, params) { 
      axios.post('/api/auth/sign_in', params).then(response => {
        const authHeaders = pick(response.headers, ["access-token", "client", "uid", "expiry", "token-type"])
        commit('user', response.data.data)
        commit('auth', authHeaders)
        // cookieへ書き込み
        const contents = {
          tokens: authHeaders,
          user: response.data.data
        }
        cookie.set('session', JSON.stringify(contents), { expire: '14D' })
        router.push({ name: 'about' })
      }).catch(error => {
        console.log(error)
      })
    },
    signOut({ commit }, params) {
      axios.delete('/api/auth/sign_out', { headers: params }).then(response => {
        commit('logout')
        router.push({ name: 'signin' })
      }).catch(error => {
        console.log(error)
      })
    }
  }
}