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
        { name: '月曜日', label: 'monday',    color: '#E4B071', link: '/monday' },
        { name: '火曜日', label: 'tuesday',   color: '#E4B071', link: '/tuesday' },
        { name: '水曜日', label: 'wednesday', color: '#E4B071', link: '/wednesday' },
        { name: '木曜日', label: 'thursday',  color: '#E4B071', link: '/thursday' },
        { name: '金曜日', label: 'friday',    color: '#E4B071', link: '/friday' },
        { name: '土曜日', label: 'saturday',  color: '#1982C4', link: '/saturday' },
        { name: '日曜日', label: 'sunday',    color: '#E06060', link: '/sunday' }
      ]
    }
  }
}
</script>