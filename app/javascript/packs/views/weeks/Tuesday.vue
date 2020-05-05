<template>
  <div>
    <v-container>
      <!-- 入力によるアラート -->
      <v-alert v-model="success_state" outlined type="success">
        タスク追加しました
      </v-alert>
      <v-alert v-model="error_state" outlined type="error">
        1～40文字以内で入力してください
      </v-alert>
      
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
              <v-toolbar-title>タスク</v-toolbar-title>
            </v-toolbar>
            <v-list
              v-for="(task, index) in filterStartTasks()"
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
              v-for="(task, index) in filterFinishTasks()"
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
      <AddTask @add="createTask" />

    </v-container>
  </div>
</template>

<script>
import axios   from 'axios' 
import AddTask from '../../components/AddTask.vue'

export default {
  data() {
    return {
      tasks: [],
      error_state: false,
      success_state: false
    }
  },
  components: {
    AddTask
  }, 
  mounted() {
    this.fetchTasks()
    this.filterStartTasks()
    this.filterFinishTasks()
  },
  methods: {
    fetchTasks() {
      axios.get('/api/v1/tasks').then((response) => {
        this.tasks = response.data;
      }).catch(() => {
        alert('ERROR');
      })
    },
    createTask(newTask) {
      if (newTask == '' || newTask.length > 40) {
        this.success_state = false;
        this.error_state = true;
        return 
      }
      axios.post('/api/v1/tasks', { task: { content: newTask, week: "tuesday" } }).then((response) => {
          this.tasks.unshift(response.data);
          this.error_state = false;
          this.success_state = true;
      }).catch(() => {
        alert('ERROR');
      })
    },
    updateTask(task_id) {
      axios.put('/api/v1/tasks/' + task_id).then((response) => {
        this.$router.go({ path: '/tuesday', force: true })
      }).catch(() =>{
        alert('ERROR');
      })
    },
    deleteTask(task_id, index) {
      axios.delete('/api/v1/tasks/' + task_id).then((response) => {
        this.tasks.splice(index, 1);
      }).catch(() => {
        alert('ERROR');
      })
    },
    filterStartTasks() {
      return this.tasks.filter(task => !task.is_done && task.week == "tuesday")
    },
    filterFinishTasks() {
      return this.tasks.filter(task => task.is_done && task.week == "tuesday")
    }
  }
}
</script>