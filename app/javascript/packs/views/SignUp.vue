<template>
  <v-container>
    <v-row>
      <v-col>
        <v-alert
          border="left"
          color="#247BA0"
          dark
        >
          登録が完了しました！
        </v-alert>
      </v-col>
    </v-row>
    <v-row>
      <v-col>
        <v-card>
          <v-toolbar
            color="#247BA0"
            dark
            flat
            dense
          >
            <v-toolbar-title>ユーザー登録</v-toolbar-title>
          </v-toolbar>
          <v-col>
            <v-form
              ref="valid_form"
              v-model="valid"
            >
              <v-text-field
                v-model="name"
                label="ユーザー名"
                color="#70C1B3"
                counter="20"
                :rules="nameRules"
              >
              </v-text-field>
              <v-text-field
                v-model="email"
                label="メールアドレス"
                color="#70C1B3"
                :rules="emailRules"
              >
              </v-text-field>
              <v-text-field
                v-model="password"
                label="パスワード"
                color="#70C1B3"
                :rules="passwordRules"
                append-icon="eye-off"
              >

              </v-text-field>
              <v-btn
                block
                :disabled="!valid || loading"

                :loading="loading"
                @click="signUp"
              >
                登録
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
  name: 'signup',
  data() {
    return {
      name: '',
      email: '',
      password: '',
      disabled: true,
      valid: true,
      loading: false,
      nameRules: [
        v => !!v || "名前は必須項目です",
        v => v.length <= 20 || "名前は20文字以内で入力してください"
      ],
      emailRules: [
        v => !!v || "メールアドレスは必須項目です",
        v => /.+@.+\..+/.test(v) || "メールアドレスの形式が正しくありません。"
      ],
      passwordRules: [
        v => !!v || "パスワードは必須項目です",
        v => v.length >= 8 || "パスワードは8文字以上で入力してください"
      ]
    }
  },
  methods: {
    signUp() {
      const params = {
        name: this.name,
        email: this.email,
        password: this.password
      }
      if (this.$refs.valid_form.validate()) {
        this.loading = true
        this.$store.dispatch('auth/signUp', params)
        this.name = ''
        this.email = ''
        this.password = ''
      }
    }
  }
}
</script>