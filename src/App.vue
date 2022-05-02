<template>
  <v-app>
    <Header/>

    <v-main>
      <PeaceSign/>
      <Measure/>
      <Reflect/>
      <!--
      <Timer/>
      -->
      <Ranking/>
    </v-main>
  </v-app>
</template>

<script>
import Header from './components/Header';
import PeaceSign from './components/PeaceSign';
import Measure from './components/Measure';
import Reflect from './components/Reflect';
// import Timer from './components/Timer';
import Ranking from './components/Ranking';

export default {
  name: 'App',

  components: {
    Header,
    PeaceSign,
    Measure,
    Reflect,
    // Timer,
    Ranking
  }
}
</script>
