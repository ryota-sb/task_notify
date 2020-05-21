<template>
  <v-row justify="center" dense>
    <v-dialog v-model="dialog" persistent max-width="600px">
      <template v-slot:activator="{ on }">
        <v-col :cols="12">
        <v-btn
          block
          depressed
          color="white"
          dense
          v-on="on"
        >
          <v-icon>add</v-icon>
        </v-btn>
        </v-col>
      </template>
      <v-card>
        <v-toolbar
          color="#70C1B3"
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
                <v-form ref="valid_form">
                  <v-text-field
                    v-model="newTask"
                    label="タスクを入力して下さい"
                    color="#70C1B3"
                    :rules="[required_task, limit_length]"
                    counter="40"
                  >
                  </v-text-field>
                  <template>
                    <v-row>
                      <v-col>
                        <v-dialog
                          ref="dialog"
                          v-model="modal2"
                          :return-value.sync="time"
                          persistent
                          width="290px"
                        >
                          <template v-slot:activator="{ on }">
                            <v-text-field
                              v-model="time"
                              label="タスクの開始時間を入力してください"
                              color="#70C1B3"
                              readonly
                              v-on="on"
                            ></v-text-field>
                          </template>
                          <v-time-picker
                            v-if="modal2"
                            v-model="time"
                            full-width
                            ampm-in-title
                          >
                            <v-spacer></v-spacer>
                            <v-btn text color="primary" @click="modal2 = false">閉じる</v-btn>
                            <v-btn text color="primary" @click="$refs.dialog.save(time)">追加</v-btn>
                          </v-time-picker>
                        </v-dialog>
                      </v-col>
                    </v-row>
                  </template>
                </v-form>
              </v-col>
            </v-row>
          </v-container>
        </v-card-text>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="blue darken-1" text @click="dialog = false">閉じる</v-btn>
          <v-btn
            color="blue darken-1"
            text
            :disabled="newTask && time ? disabled = false : disabled"
            @click="addTask()"
          >
            追加
          </v-btn>
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
      disabled: true,
      time: null,
      menu2: false,
      modal2: false,
      newTask: '',
      required_task: value => !!value || '入力してください',
      limit_length: value => value.length <= 40 || '40文字以内で入力してください',
    }
  },
  methods: {
    addTask() {
      if (this.$refs.valid_form.validate()) { 
        this.$emit('add', this.newTask, this.time)
        this.time = ''
        this.newTask = ''
        this.dialog = false
        this.disabled = true
      }
    }
  }
}
</script>