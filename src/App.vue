<template>
  <v-app>
    <Header/>

    <v-main>
      <PeaceSign/>
      <Camera/>
      <Timer/>
      <Ranking/>
    </v-main>
  </v-app>
</template>

<script>
import Header from './components/Header';
import PeaceSign from './components/PeaceSign';
import Camera from './components/Camera';
import Timer from './components/Timer';
import Ranking from './components/Ranking';

export default {
  name: 'App',

  components: {
    Header,
    PeaceSign,
    Camera,
    Timer,
    Ranking
  }
}
</script>
