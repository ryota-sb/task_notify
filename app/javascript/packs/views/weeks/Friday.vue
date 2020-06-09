<template>
  <div>
    <v-container>
      <!-- タスク表示 -->
      <v-row>
        <v-col>
          <v-card color="#EEEEEE">
            <v-toolbar
              color="#ECD273"
              dark
              dense
              flat
            >
              <v-toolbar-title>タスク(金)</v-toolbar-title>
            </v-toolbar>
            <v-container>
              <v-row dense>
                <v-col
                  v-for="(task, index) in doneTasks()"
                  :key="task.id"
                  :cols="12"
                >
                  <v-card flat>
                    <v-card-text>
                      <v-btn text icon @click="updateTask(task.id, index)">
                        <v-icon color="#70C1B3">check_circle_outline</v-icon>
                      </v-btn>
                      {{ task.content }} / {{ task.notification_time | moment }}開始
                    </v-card-text>
                  </v-card>
                </v-col>
                <v-col>
                  <!-- タスク追加フォーム -->
                  <AddTask @add="createTask" />
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
      </v-row>

      <!-- 完了タスク -->
      <v-row>
        <v-col>
          <v-card color="#EEEEEE">
            <v-toolbar
              color="red lighten-2"
              dark
              dense
              flat
            >
              <v-toolbar-title>完了</v-toolbar-title>
            </v-toolbar>
            <v-container>
              <v-row dense>
                <v-col
                   v-for="(task, index) in notDoneTasks()"
                  :key="task.id"
                  :cols="12"
                >
                  <v-card flat>
                    <v-card-text>
                      <v-btn text icon color="red lighten-2" @click="deleteTask(task.id, index)">
                        <v-icon color="red">remove_circle_outline</v-icon>
                      </v-btn>
                      {{ task.content }}
                    </v-card-text>
                  </v-card>
                </v-col>
              </v-row>
            </v-container>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import AddTask from '../../components/AddTask.vue'
import moment from 'moment'
import { mapState } from 'vuex'

export default {
  name: 'Friday',
  components: { AddTask },
  mounted() {
    this.$store.dispatch('tasks/getTasksAction')
  },
  computed: {
    ...mapState({
      tasks: state => state.tasks.tasks,
      user: state => state.auth.user.id
    })
  },
  methods: {
    createTask(newTask, time) {
      const user_id = this.user
      this.$store.dispatch('tasks/createTaskAction', { newTask: newTask, week: 'friday', time: time, user_id: user_id })
    },
    updateTask(task_id) {
      this.$store.dispatch('tasks/updateTaskAction', { task_id })
    },
    deleteTask(task_id, index) {
      this.$store.dispatch('tasks/deleteTaskAction', { task_id, index })
    },
    doneTasks() {
      const task = this.tasks
      const user_id = this.user
      if(Object.keys(task).length) {
        return task.filter(task => !task.is_done && task.week == "friday" && task.user_id == user_id)
      }
    },
    notDoneTasks() {
      const task = this.tasks
      const user_id = this.user
      if(Object.keys(task).length) {
        return task.filter(task => task.is_done && task.week == "friday" && task.user_id == user_id)
      }
    }
  },
  filters: {
    moment(date) {
      return moment(date).format('HH:mm')
    }
  }
}
</script>