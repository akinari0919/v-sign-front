<template>
  <div id="overlay">
    <div id="content">
      <h1 class="display-1 font-weight-bold mb-3">
        結果は{{ sign.name }}/{{ sign.angle }}位でした！
      </h1>

      <v-img :src="'data:image/jpeg;base64,' + item.image" width="100" height="100"/>
      <p>{{ item.angle }}</p>
      <p>ニックネーム : {{ item.name }}</p>

      <div class="my-5">
        <v-btn class="mx-5" @click="$emit('tweet')">つぶやく</v-btn>
        <v-btn class="mx-5" @click="$emit('toTop')">TOPへ</v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['item','sign']
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
