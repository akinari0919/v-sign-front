<template>
  <v-app>
    <v-app-bar
      app
      color="dark"
      dark
    >
      <div class="d-flex align-center">
        <v-img
          alt="PeaceSign Logo"
          class="shrink mr-2"
          contain
          src="./assets/peace-sign-logo.webp"
          transition="scale-transition"
          width="40"
        />

        <h1
          alt="PeaceSign Name"
          class="shrink mt-1 hidden-sm-and-down"
          contain
          min-width="100"
          width="100"
        >
         ピースサイン競争
        </h1>
      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://github.com/akinari0919/peace-sign"
        target="_blank"
        text
      >
        <span class="mr-2">GitHub</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <PeaceSign/>
      <Ranking/>
    </v-main>

  </v-app>
</template>

<script>
import PeaceSign from './components/PeaceSign';
import Ranking from './components/Ranking';

export default {
  name: 'App',

  components: {
    PeaceSign,
    Ranking
  }
}
</script>
