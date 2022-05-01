<template>
  <v-app>
    <Header/>

    <v-main>
      <PeaceSign/>
      <Camera/>
      <Ranking/>
    </v-main>
  </v-app>
</template>

<script>
import Header from './components/Header';
import PeaceSign from './components/PeaceSign';
import Camera from './components/Camera';
import Ranking from './components/Ranking';

export default {
  name: 'App',

  components: {
    Header,
    PeaceSign,
    Camera,
    Ranking
  }
}
</script>
