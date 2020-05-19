<template>
  <div>
    <v-container>
      <!-- タスク表示 -->
      <v-row>
        <v-col>
          <v-card>
            <v-toolbar
              color="#92C440"
              dark
              dense
              flat
            >
              <v-toolbar-title>今日のタスク</v-toolbar-title>
            </v-toolbar>
            <v-list
              v-for="(task, index) in doneTasks()"
              :key="task.id"
            >
              <v-list-item>
                <v-row no-gutters>
                  <v-col>
                    <v-card>
                      <v-card-text>
                        <v-btn text icon @click="updateTaskAction(task.id, index)">
                          <v-icon color="green">check_circle_outline</v-icon>
                        </v-btn>
                        {{ task.content }} / {{ task.notification_time | moment }}開始
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>
      </v-row>    
      <!-- 完了タスク -->
      <v-row>
        <v-col>
          <v-card>
            <v-toolbar
              color="red lighten-1"
              dark
              dense
              flat
            >
              <v-toolbar-title>完了</v-toolbar-title>
            </v-toolbar>
            <v-list
              v-for="(task, index) in notDoneTasks()"
              :key="task.id"
            >
              <v-list-item>
                <v-row no-gutters>
                  <v-col>
                    <v-card>
                      <v-card-text>
                        <v-btn text icon color="red lighten-2" @click="deleteTaskAction(task.id, index)">
                          <v-icon color="red">remove_circle_outline</v-icon>
                        </v-btn>
                        {{ task.content }}
                      </v-card-text>
                    </v-card>
                  </v-col>
                </v-row>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>
import moment from 'moment'

export default {
  name: 'Task',
  computed: {
    tasks() {
      return this.$store.state.tasks
    }
  },
  mounted() {
    this.$store.dispatch('getTasksAction')
    this.doneTasks()
    this.notDoneTasks()
  },
  methods: {
    updateTaskAction(task_id) {
      this.$store.dispatch('updateTaskAction', { task_id })
      this.$router.go({ path: this.$router.currentRoute.path, force: true })
    },
    deleteTaskAction(task_id, index) {
      this.$store.dispatch('deleteTaskAction', { task_id, index })
    },
    doneTasks() {
      const date = new Date()
      const week = date.getDay()
      const weeks = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
      return this.tasks.filter(task => !task.is_done && task.week == weeks[week])
    },
    notDoneTasks() {
      const date = new Date()
      const week = date.getDay()
      const weeks = ['sunday', 'monday', 'tuesday', 'wednesday', 'thursday', 'friday', 'saturday']
      return this.tasks.filter(task => task.is_done && task.week == weeks[week])
    }
  },
  filters: {
    moment(date) {
      return moment(date).format('HH:mm')
    }
  }
}
</script>