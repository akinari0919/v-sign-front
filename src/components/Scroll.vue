<template>
  <transition name="fade">
    <v-btn
      v-scroll="onScroll"
      v-show="fab"
      fab
      color=#333333
      fixed
      bottom
      right
      @click="toTop"
    >
      <v-icon color="white">
        mdi-arrow-up-bold
      </v-icon>
    </v-btn>
  </transition>
</template>

<script>
export default {
  data: () => {
    return {
      fab: false
    };
  },
  methods: {
    onScroll (e){
      if (typeof window === 'undefined') return
      const top = window.pageYOffset ||   e.target.scrollTop || 0
      this.fab = top > 500
    },
    toTop () {
      this.$vuetify.goTo(0)
    }
  }
}
</script>

<style scoped>
.fade-enter-active, .fade-leave-active {
  transition: 0.5s;
}
.fade-enter, .fade-leave-to {
  opacity: 0;
  transform: scale(0);
}
</style>
