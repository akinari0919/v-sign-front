<template>
  <v-app>
    <Header/>

    <v-main>
      <PeaceSign/>
      <Measure/>
      <!--
      <Timer/>
      -->
      <Ranking/>
      <Footer/>
      <Scroll/>
    </v-main>
  </v-app>
</template>

<script>
import Header from './components/Header';
import PeaceSign from './components/PeaceSign';
import Measure from './components/Measure';
// import Timer from './components/Timer';
import Ranking from './components/Ranking';
import Footer from './components/Footer';
import Scroll from './components/Scroll';

export default {
  name: 'App',

  components: {
    Header,
    PeaceSign,
    Measure,
    // Timer,
    Ranking,
    Footer,
    Scroll
  }
}
</script>

<style>
img, canvas, .my-modal {
  border-radius: 10px;
}
.bgc {
  background: linear-gradient(transparent 60%, #ff05 60%);
  border-radius: 5px;
}
</style>
