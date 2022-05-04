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
