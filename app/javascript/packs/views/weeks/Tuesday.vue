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
              <v-toolbar-title>タスク(火)</v-toolbar-title>
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

export default {
  name: 'Tuesday',
  components: { AddTask }, 
  mounted() {
    this.$store.dispatch('getTasksAction')
    this.doneTasks()
    this.notDoneTasks()
  },
  methods: {
    createTask(newTask, time) {
      this.$store.dispatch('createTaskAction', { newTask: newTask, week: 'tuesday', time: time })
    },
    updateTask(task_id) {
      this.$store.dispatch('updateTaskAction', { task_id })
      this.$router.go({ path: this.$router.currentRoute.path, force: true })
    },
    deleteTask(task_id, index) {
      this.$store.dispatch('deleteTaskAction', { task_id, index })
    },
    doneTasks() {
      let task = this.$store.state.tasks
      return task.filter(task => !task.is_done && task.week == "tuesday")
    },
    notDoneTasks() {
      let task = this.$store.state.tasks
      return task.filter(task => task.is_done && task.week == "tuesday")
    }
  },
  filters: {
    moment(date) {
      return moment(date).format('HH:mm')
    }
  }
}
</script>