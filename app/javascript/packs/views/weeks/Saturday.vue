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
              <v-toolbar-title>土曜日のタスク</v-toolbar-title>
            </v-toolbar>
            <v-list
              v-for="(task, index) in doneTasks()"
              :key="task.id"
            >
              <v-list-item>
                <v-list-item-action>
                  <v-btn text icon @click="updateTask(task.id, index)">
                    <v-icon color="green">check_circle_outline</v-icon>
                  </v-btn>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>{{ task.content }}</v-list-item-title>
                </v-list-item-content>
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
                <v-list-item-action>
                  <v-btn text icon color="red lighten-2" @click="deleteTask(task.id, index)">
                    <v-icon color="red">remove_circle_outline</v-icon>
                  </v-btn>
                </v-list-item-action>
                <v-list-item-content>
                  <v-list-item-title>{{ task.content }}</v-list-item-title>
                </v-list-item-content>
              </v-list-item>
            </v-list>
          </v-card>
        </v-col>
      </v-row>
      
      <!-- タスク追加フォーム -->
      <v-row>
        <v-col>
          <AddTask @add="createTask" />
        </v-col>
      </v-row>

    </v-container>
  </div>
</template>

<script>
import axios from 'axios'
import AddTask from '../../components/AddTask.vue'
import { mapGetters } from 'vuex'

export default {
  name: 'Saturday',
  components: { AddTask }, 
  mounted() {
    this.$store.dispatch('getTasksAction')
    this.doneTasks()
    this.notDoneTasks()
  },
  methods: {
    createTask(newTask) {
      this.$store.dispatch('createTaskAction', { newTask: newTask, week: 'saturday' })
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
      return task.filter(task => !task.is_done && task.week == "saturday")
    },
    notDoneTasks() {
      let task = this.$store.state.tasks
      return task.filter(task => task.is_done && task.week == "saturday")
    }
  }
}
</script>