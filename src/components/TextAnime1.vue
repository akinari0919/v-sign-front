<template>
  <h2 class="TextAnime1">
    <span v-for="(t, index) in text" :key="index" v-text="t" class="item delay-anime"/>
  </h2>
</template>

<script>
export default {
  data() {
    return {
      text: 'ピースサイン競争'
    }
  }
}
</script>

<style scoped>
@keyframes text-in {
  0% {
    transform: translate(0, -20px);
    opacity: 0;
  }
}

.item {
  display: inline-block;
  min-width: 0.3em;
  animation: text-in 0.8s cubic-bezier(0.22, 0.15, 0.25, 1.43) 0s backwards;
}

for co in 0 .. 12 {
  .delay-anime:nth-child({co + 1}) {
    animation-delay: co * 100ms + 200ms;
  }
}

@media (max-width: 768px) {
  h2 {
    font-size: 100%;
  }
}
</style>
