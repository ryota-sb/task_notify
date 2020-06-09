import axios  from 'axios'
import router from '../../router/index'

export const tasks = {
  namespaced: true,
  state: {
    tasks: []
  },
  getters:{
    tasks: state => state.tasks
  },
  mutations: {
    getTasks(state, value) {
      state.tasks = value;
    },
    createTask(state, value) {
      state.tasks.push(value);
    },
    updateTask(state, value) {
      state.tasks = value;
    },
    deleteTask(state, index) {
      state.tasks.splice(index, 1);
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
    createTaskAction({ commit }, { newTask, week, time, user_id }) {
      if (newTask == '' || newTask.length > 40) { return }
      axios.post('/api/v1/tasks', { task: { content: newTask, week: week, notification_time: time, user_id: user_id } }).then(response => {
        commit('createTask', response.data);
      }).catch(error => {
        console.log(error);
      })
    },
    updateTaskAction({ commit }, { task_id }) {
      axios.put('/api/v1/tasks/' + task_id).then(response => {
        commit('updateTask', response.data);
        router.go({ path: router.currentRoute.path, force: true })
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
    }
  }
}