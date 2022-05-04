<template>
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
        src="../assets/peace-sign-logo.webp"
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

  </v-app-bar>
</template>

<script>
  export default {
    name: 'App',
  }
</script>
