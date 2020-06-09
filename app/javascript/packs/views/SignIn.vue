<template>
  <v-container>
    <v-row>
      <v-col>
        <v-card>
          <v-toolbar
            color="#FF7854"
            dark
            flat
            dense
          >
            <v-toolbar-title>ログイン</v-toolbar-title>
          </v-toolbar>
          <v-col>
            <v-form ref="valid_form">
              <v-text-field
                v-model="email"
                label="メールアドレス"
                color="#70C1B3"
              >
              </v-text-field>
              <v-text-field
                v-model="password"
                label="パスワード"
                color="#70C1B3"
              >
              </v-text-field>
              <v-btn
                block
                @click="signIn"
              >
                ログイン
              </v-btn>
            </v-form>
          </v-col>
        </v-card>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  name: 'signin',
  data() {
    return {
      email: '',
      password: ''
    }
  },
  methods: {
    signIn() {
      const params = {
        email: this.email,
        password: this.password
      }
      if (this.$refs.valid_form.validate()) {
        this.$store.dispatch('auth/signIn', params)
        this.email = ''
        this.password = ''
      }
    }
  }
}
</script>