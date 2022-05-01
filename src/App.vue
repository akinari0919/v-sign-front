<template>
  <v-app>
    <Header/>

    <v-main>
      <PeaceSign/>
      <Ranking/>
      <Camera/>
    </v-main>

  </v-app>
</template>

<script>
import Header from './components/Header';
import PeaceSign from './components/PeaceSign';
import Ranking from './components/Ranking';
import Camera from './components/Camera';

export default {
  name: 'App',

  components: {
    Header,
    PeaceSign,
    Ranking,
    Camera,
  }
}
</script>
