<template>
  <v-row justify="center">
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-btn fab x-large dark color="#6A4C93" v-on="on">
          <v-icon dark>create</v-icon>
        </v-btn>
      </template>
      <v-card>
        <v-toolbar
          color="light-green lighten-1"
          dark
          dense
          flat
        >
          <v-toolbar-title>タスク追加</v-toolbar-title>
        </v-toolbar>
        <v-card-text>
          <v-container>
            <v-row>
              <v-col>
                <v-text-field
                  v-model="newTask"
                  label="タスクを入力して下さい"
                  color="light-green lighten-1"
                  counter="40"
                >
                </v-text-field>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          <v-btn color="blue darken-1" text @click="AddTask">追加</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
  </v-row>
</template>

<script>
export default {
  data() {
    return {
      dialog: false,
      newTask: ''
    }
  },
  methods: {
    AddTask() {
      this.dialog = false;
      this.$emit('add', this.newTask)
      this.newTask = '';
    }
  }
}
</script>