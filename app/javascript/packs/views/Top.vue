<template>
  <v-container fill-height>
    <v-row>
      <v-card>
        <v-toolbar
          color="light-green lighten-1"
          dark
          dense
          flat
        >
          <v-toolbar-title>Notify</v-toolbar-title>
        </v-toolbar>
        <v-card-text>必要タスクを通知。やることのきっかけ作りを。</v-card-text>
        <v-btn text>
          <router-link to="/task">Task Create</router-link>
        </v-btn>
      </v-card>
    </v-row>
  </v-container>
</template>