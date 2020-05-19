<template>
  <div>
  <v-app>
    <Header />
    <v-content>
      <router-view />
    </v-content>
    <Footer />
  </v-app>
  </div>
</template>

<script>
import Header from './packs/components/Header.vue'
import Footer from './packs/components/Footer.vue'

export default {
  name: 'app',
  components: {
    Header, Footer
  }
}
</script>
