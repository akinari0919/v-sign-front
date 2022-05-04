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

        <table id="table" border="1">
          <thead>
            <tr>
              <th width="150">順位</th>
              <th width="150">投稿者</th>
              <th width="150">角度</th>
              <th width="150">✌️</th>
            </tr>
          </thead>
          <tbody>
            <tr v-for="(sign, index) in signs" :key="index">
              <td>{{ index + 1 }}位</td>
              <td>{{ sign.name }}</td>
              <td>{{ sign.angle.toFixed(2) }}°</td>
              <td><img :src="sign.image" width="150" height="150"/></td>
            </tr>
          </tbody>
        </table>
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
