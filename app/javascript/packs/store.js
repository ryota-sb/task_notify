import Vue   from 'vue'
import Vuex  from 'vuex'
import axios from 'axios'

Vue.use(Vuex)

export default new Vuex.Store({
  state: {
    tasks: []
  },
  mutations: {
    getTasks(state, tasks) {
      state.tasks = tasks
    },
    createTask(state, task) {
      state.tasks.push(task)
    },
    updateTask(state, task) {
      state.tasks = task
    },
    deleteTask(state, index) {
      state.tasks.splice(index, 1)
    }
  },
  actions: {
    getTasksAction({ commit }) {
      axios.get('/api/v1/tasks').then(response => {
        commit('getTasks', response.data)
      }).catch(error => {
        console.log(error)
      })
    },
    createTaskAction({ commit }, { newTask, week, time }) {
      if (newTask == '' || newTask.length > 40) { return }
      axios.post('/api/v1/tasks', { task: { content: newTask, week: week, notification_time: time } }).then(response => {
        commit('createTask', response.data)
      }).catch(error => {
        console.log(error)
      })
    },
    updateTaskAction({ commit }, { task_id }) {
      axios.put('/api/v1/tasks/' + task_id).then(response => {
        commit('updateTask', response.data)
      }).catch(error => {
        console.log(error)
      })
    },
    deleteTaskAction({ commit }, { task_id, index }) {
      axios.delete('/api/v1/tasks/' + task_id).then(response => {
        commit('deleteTask', index)
      }).catch(error => {
        console.log(error)
      })
    }
  }
})