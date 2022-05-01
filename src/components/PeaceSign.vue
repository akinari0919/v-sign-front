<template>
  <v-container>
    <v-row class="text-center">
      <v-col cols="12">
        <v-img
          :src="require('../assets/peace-sign-logo.webp')"
          class="my-3"
          contain
          height="200"
        />
      </v-col>

      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          ピースサイン競争
        </h1>

        <p class="subheading font-weight-regular">
          Peace - Sign - Competition
        </p>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold mb-3">
          遊び方
        </h2>

        <v-row justify="center">
          <a
            v-for="(next, i) in howTo"
            :key="i"
            :href="next.href"
            class="subheading mx-3"
            target="_blank"
          >
            {{ next.text }}
          </a>
        </v-row>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold mb-3">
          測る
        </h2>

        <v-row justify="center">
          <a
            v-for="(link, i) in measure"
            :key="i"
            :href="link.href"
            class="subheading mx-3"
            target="_blank"
          >
            {{ link.text }}
          </a>
        </v-row>
      </v-col>

      <v-col
        class="mb-5"
        cols="12"
      >
        <h2 class="headline font-weight-bold mb-3">
          ランキング
        </h2>

        <v-row justify="center">
          <a
            v-for="(eco, i) in ranking"
            :key="i"
            :href="eco.href"
            class="subheading mx-3"
            target="_blank"
          >
            {{ eco.text }}
          </a>
        </v-row>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
  export default {
    name: 'App',

    data: () => ({
      ranking: [
        {
          text: 'Ranking',
          href: '#',
        },
      ],
      measure: [
        {
          text: 'Peace sign',
          href: '#',
        },
        {
          text: 'Spock hand',
          href: '#',
        },
      ],
      howTo: [
        {
          text: 'How to',
          href: '#',
        },
      ],
    }),
  }
</script>

