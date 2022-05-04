<template>
  <v-container>
    <v-row class="text-center mb-3">
      <v-col class="mb-4">
        <h1 class="display-1 font-weight-bold mb-3">
          ランキング
        </h1>

        <p class="subheading font-weight-regular">
          Ranking
        </p>

        <p class="body-1">
          現在{{ rankers }}位まで登録されています。
        </p>

        <div class="body-1 mt-8 mb-1">
          <v-row>
            <v-col>
              順位
            </v-col>
            <v-col>
              投稿者
            </v-col>
            <v-col>
              角度
            </v-col>
            <v-col>
              ピース✌️
            </v-col>
            <v-col>
              投稿日
            </v-col>
          </v-row>
        </div>

        <v-card>
        <div
          class="mb-4"
          v-for="(sign, index) in signs"
          :key="index"
        >
          <v-row class="text-h6" align="center">
            <v-col>
              {{ index + 1 }}位
            </v-col>
            <v-col>
              {{ sign.name }}
            </v-col>
            <v-col>
              {{ sign.angle.toFixed(2) }}°
            </v-col>
            <v-col>
              <img class="mb-1"
                 :src="sign.image"
                 width="150"
                 height="150"
              />
            </v-col>
            <v-col>
              {{ sign.created_at.substr(0, 10) }}
            </v-col>
          </v-row>
          <v-divider/>
        </div>
        </v-card>

      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
const url = process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com';

export default {
  data () {
    return {
      signs: null,
      rankers: null
    }
  },

  created () {
    axios
      .get(`${url}/v1/signs`)
      .then( response => {
        this.signs = response.data.signs
        this.rankers = response.data.rankers
      })
      .catch( (err) => {
        this.msg = err // エラー処理
      });
  }
}
</script>

<style>
#table {
  margin: auto;
}
</style>
