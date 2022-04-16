<template>
  <v-container>
    <v-row class="text-center">
      <v-col class="mb-4">
        <h1 class="display-2 font-weight-bold mb-3">
          APIテスト
        </h1>

        <p class="subheading font-weight-regular">
          API - Test
        </p>

        <p>
          こんにちは、 {{ name }} さん！
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';

export default {
  data () {
    return {
      name: ''
    }
  },

  created () {
    axios
      .get(process.env.VUE_APP_API_URL)
      .then( response => {
        this.name = response.data.signs[0].name //signs
      })
      .catch( (err) => {
        this.msg = err // エラー処理
      });
  }
}
</script>

