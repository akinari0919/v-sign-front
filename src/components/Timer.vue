<template>
  <v-container>
    <v-row id="timer" class="text-center mb-4">
      <v-col>
        <p id="time" class="display-1 font-weight-regular">{{ Time }}</p>
        <button v-on:click="start" v-if="!timerOn">セルフタイマー</button>
        <button v-on:click="reset" v-if="timerOn">リセット</button>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import axios from 'axios';
const url = process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com';

export default {
  name: 'timer',
  data() {
    return {
      sec: 3,
      timerOn: false,
      timerObj: null,
    }
  },
  methods: {
    count: function() {
      if (this.sec === 1) {
        this.complete()
        document.getElementById('time').textContent = 'パシャ!!'
        // 画像データの格納
        const canvas = document.getElementById("canvas")
        const base64 = canvas.toDataURL('image/jpeg').replace(/data:.*\/.*;base64,/, '')
        // 角度データの格納
        const angle = document.getElementById("angle").textContent

        axios
          .post(`${url}/v1/signs`, {
            name: "test3",
            image: base64,
            angle: angle,
            type: 0
          })
          .then( response => {
            this.signs = response.data.signs //signs
          })
          .catch( (err) => {
            this.msg = err // エラー処理
          });

        window.location.href = '/'

      } else {
        this.sec --;
      }
    },

    start: function() {
      let self = this;
      this.timerObj = setInterval(function() {self.count()}, 1000)
      this.timerOn = true; //timerがONであることを状態として保持
    },

    reset: function() {
      clearInterval(this.timerObj);
      document.getElementById('time').textContent = '3'
      this.sec = 3;
      this.timerOn = false; //timerがOFFであることを状態として保持
    },

    complete: function() {
      clearInterval(this.timerObj)
    }
  },
  computed: {
    Time: function() {
      let timeStrings = [
        this.sec.toString()
      ].map(function(str) {
        return str
      })
      return timeStrings[0]
    }
  }
}
</script>

