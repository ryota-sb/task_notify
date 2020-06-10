<template>
  <v-container fill-height>
    <v-row>
      <v-col
        cols="12"
        md="8"
      >
        <v-card
          height="100%"
          flat
        >
          <h1 class="font-weight-thin display-4 text-center">Task<br v-if="$vuetify.breakpoint.xsOnly"> Notify</h1>
          <v-card-subtitle class="text-center">- タスクをLINEで通知。-</v-card-subtitle>
        </v-card>
      </v-col>
      <v-col
        cols="12"
        md="4"
      >
        <v-row justify="center">
          <v-col cols="6">
            <v-list
              v-for="btn in buttons"
              :key="btn.name"
            >
              <v-btn
                block
                outlined
                :to="btn.link"
                :style="{ color: btn.color }"
              >
                {{ btn.name }}
              </v-btn>
            </v-list>
          </v-col>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
export default {
  data() {
    return {
      buttons: [
        { name: '新規作成', link: '/signup', color: '#247BA0'},
        { name: 'ログイン', link: '/signin', color: '#FF7854'},
      ]
    }
  }
}
</script>