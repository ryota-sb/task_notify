<template>
  <div>
    <v-navigation-drawer app v-model="drawer" clipped>
      <v-container>
        <v-list dense nav>
          <v-list-item v-for="list in nav_lists" :key='list.name' :to="list.link">
            <v-list-item-content>
              <v-list-item-title>{{ list.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-container>
    </v-navigation-drawer>
    <v-app-bar app dark clipped-left color="#92C440">
      <v-app-bar-nav-icon @click="drawer=!drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>Notify</v-toolbar-title>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  data() {
    return {
      drawer: false,
      nav_lists: [
        { name: 'トップ',             link: '/' },
        { name: 'アプリについて',     link: '/about' },
        { name: '週間のタスクセット', link: '/weektask' },
        { name: '今日のタスク',       link: '/task' }
      ]
    }
  }
}
</script>