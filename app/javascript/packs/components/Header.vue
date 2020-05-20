<template>
  <div>
    <v-navigation-drawer app v-model="drawer" clipped>
      <v-container>
        <v-list dense nav>
          <v-list-item
            v-for="list in nav_lists"
            :key='list.name'
            :to="list.link"
          >
            <v-list-item-icon>
              <v-icon>{{ list.icon }}</v-icon>
            </v-list-item-icon>
            <v-list-item-content>
              <v-list-item-title>{{ list.name }}</v-list-item-title>
            </v-list-item-content>
          </v-list-item>
        </v-list>
      </v-container>
      <template v-slot:append>
        <div class="pa-2">
          <v-btn block>Logout</v-btn>
        </div>
      </template>
    </v-navigation-drawer>
    <v-app-bar app dark clipped-left color="#70C1B3">
      <v-app-bar-nav-icon @click="drawer=!drawer"></v-app-bar-nav-icon>
      <v-toolbar-title>Task Notify</v-toolbar-title>
    </v-app-bar>
  </div>
</template>

<script>
export default {
  data() {
    return {
      drawer: false,
      nav_lists: [
        { name: 'トップ',             icon: 'home',            link: '/' },
        { name: 'アプリについて',     icon: 'contact_support', link: '/about' },
        { name: '週間のタスクセット', icon: 'assignment',      link: '/weektask' },
        { name: '今日のタスク',       icon: 'note',            link: '/todaytask' }
      ]
    }
  }
}
</script>