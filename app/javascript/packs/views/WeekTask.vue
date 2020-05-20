<template>
  <div>
    <v-container>
      <v-row>
        <v-col>
          <v-list
            v-for="week in dayOfWeeks"
            :key="week.name"
          >
            <v-hover
              v-slot:default="{ hover }"
            >
              <v-card
                :to="week.link"
                :elevation="hover ? 16 : 2"
              >
                <v-toolbar
                  dark
                  dense
                  flat
                  :style="{ background: week.color }"
                >
                  <v-toolbar-title>{{ week.name }}</v-toolbar-title>
                </v-toolbar>
              </v-card>
            </v-hover>
          </v-list>
        </v-col>
      </v-row>
    </v-container>
  </div>
</template>

<script>

export default {
  name: 'WeekTask',
  data() {
    return {
      dayOfWeeks: [
        { name: '月曜日', label: 'monday',    color: '#ECD273', link: '/monday' },
        { name: '火曜日', label: 'tuesday',   color: '#ECD273', link: '/tuesday' },
        { name: '水曜日', label: 'wednesday', color: '#ECD273', link: '/wednesday' },
        { name: '木曜日', label: 'thursday',  color: '#ECD273', link: '/thursday' },
        { name: '金曜日', label: 'friday',    color: '#ECD273', link: '/friday' },
        { name: '土曜日', label: 'saturday',  color: '#247BA0', link: '/saturday' },
        { name: '日曜日', label: 'sunday',    color: '#FF7854', link: '/sunday' }
      ]
    }
  }
}
</script>