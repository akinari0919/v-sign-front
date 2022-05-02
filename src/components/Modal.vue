<template>
  <div id="overlay">
    <div id="content">
      <p>ランキングへ反映しますか？</p>

      <div class="width300 mb-3">
        <v-img :src="'data:image/jpeg;base64,' + item.image" width="300" height="300"/>
      </div>

      <p>{{ item.angle }}</p>
      <p>ニックネーム : {{ item.name }}</p>

      <div class="my-5">
        <v-btn class="mx-5" :disabled="!item.image" @click="$emit('register')">登録</v-btn>
        <v-btn class="mx-5" @click="$emit('close')">戻る</v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  name: 'Modal',
  props: ['item'],
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

.width300 {
  width: 300px;
  margin: 0 auto;
}
</style>
