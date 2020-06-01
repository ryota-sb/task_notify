import Vue   from 'vue';
import Vuex  from 'vuex';
import axios from 'axios';
import createPersistedState from "vuex-persistedstate";

Vue.use(Vuex);

export default new Vuex.Store({
  state: {
    tasks: [],
    users: [],
    headers: {
      "uid": '',
      "client": '',
      "access-token": ''
    }
  },
  mutations: {
    getTasks(state, tasks) {
      state.tasks = tasks;
    },
    createTask(state, task) {
      state.tasks.push(task);
    },
    updateTask(state, task) {
      state.tasks = task;
    },
    deleteTask(state, index) {
      state.tasks.splice(index, 1);
    },
    signUp(state, users) {
      state.users = users
    },
    signIn(state, headers) {
      state.headers = {
        "uid": headers['uid'],
        "client": headers['client'],
        "access-token": headers['access-token']
      }
    },
    signOut(state) {
      state.headers = null
    }
  },
  actions: {
    getTasksAction({ commit }) {
      axios.get('/api/v1/tasks').then(response => {
        commit('getTasks', response.data);
      }).catch(error => {
        console.log(error);
      })
    },
    createTaskAction({ commit }, { newTask, week, time }) {
      if (newTask == '' || newTask.length > 40) { return }
      axios.post('/api/v1/tasks', { task: { content: newTask, week: week, notification_time: time } }).then(response => {
        commit('createTask', response.data);
      }).catch(error => {
        console.log(error);
      })
    },
    updateTaskAction({ commit }, { task_id }) {
      axios.put('/api/v1/tasks/' + task_id).then(response => {
        commit('updateTask', response.data);
      }).catch(error => {
        console.log(error);
      })
    },
    deleteTaskAction({ commit }, { task_id, index }) {
      axios.delete('/api/v1/tasks/' + task_id).then(response => {
        commit('deleteTask', index);
      }).catch(error => {
        console.log(error);
      })
    },
    signUpAction({ commit }, params) {
      axios.post('/api/auth', params).then(response => {
        commit('signUp', response.data);
      }).catch(error => {
        console.log(error);
      })
    },
    signInAction({ commit }, params) {
      axios.post('/api/auth/sign_in', params).then(response => {
        commit('signIn', response.headers);
      }).catch(error => {
        console.log(error);
      })
    },
    signOutAction({ commit }, params) {
      axios.delete('/api/auth/sign_out', { headers: params }).then(response => {
        commit('signOut', response.headers);
      }).catch(error => {
        console.log(error);
      })
    }
  },
  // stateの状態をリロードしても保持する
  plugins: [createPersistedState({ storage: window.sessionStorage })]
});