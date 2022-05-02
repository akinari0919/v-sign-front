<template>
  <div id="overlay">
    <div id="content">
      <p>ランキングへ反映しますか？</p>
      <img :src="'data:image/jpeg;base64,' + this.item.image" width="300" height="300"/>
      <p v-model="item.angle">{{ item.angle }}</p>

      <div class="my-5">
        <v-btn class="mx-5" :disabled="!item.angle" @click="$emit('register')">登録</v-btn>
        <v-btn class="mx-5" @click="$emit('close')">戻る</v-btn>
      </div>
    </div>
  </div>
</template>

<script>
import axios from 'axios';
const url = process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com';

export default {
  name: 'Modal',
  props: ['item'],

  data() {
    return {
      name: this.item.name,
      image: null,
      angle: null
    }
  },

  methods: {
    register: function() {
      axios
        .post(`${url}/v1/signs`, {
          name: this.name,
          image: this.image,
          angle: this.angle,
          type: 0
        })
        .then( response => {
          this.signs = response.data.signs //signs
        })
        .catch( (err) => {
          this.msg = err // エラー処理
        });
      window.location.href = '/'
    }
  }
}
</script>

<style>
#overlay{
  z-index:1;
  position:fixed;
  top:0;
  left:0;
  width:100%;
  height:100%;
  background-color:rgba(0, 0, 0, 0.2);
  display: flex;
  align-items: center;
  justify-content: center;
}

#content{
  z-index:2;
  width:50%;
  padding: 1em;
  background:#fff;
}
</style>
