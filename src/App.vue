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

@import url('https://fonts.googleapis.com/css2?family=Yomogi&display=swap');

h1 {
  font-family: 'Yomogi', cursive;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: rgba(0,0,0,0.7);

}

#app {
  font-family: 'Yomogi', cursive;
  -webkit-font-smoothing: antialiased;
  -moz-osx-font-smoothing: grayscale;
  color: rgba(0,0,0,0.7);

  background:
    radial-gradient(rgba(0,128,0,0.1), 3px, transparent 4px),
    radial-gradient(rgba(0,128,0,0.1), 3px, transparent 4px),
    linear-gradient(#fff 4px, transparent 0),
    linear-gradient(45deg, transparent 74px, transparent 75px, rgba(0,128,0,0.1) 75px, rgba(0,128,0,0.1) 76px, transparent 77px, transparent 109px),
    linear-gradient(-45deg, transparent 75px, transparent 76px, rgba(0,128,0,0.1) 76px, rgba(0,128,0,0.1) 77px, transparent 78px, transparent 109px),
  #fff;
  background-size: 109px 109px, 109px 109px,100% 6px, 109px 109px, 109px 109px;
  background-position: 54px 55px, 0px 0px, 0px 0px, 0px 0px, 0px 0px;
}

.card {
  background-color: #FFFFE0;
}

.card-img {
  background-color: #F8F8FF;
}
</style>
