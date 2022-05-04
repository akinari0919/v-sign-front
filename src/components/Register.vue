<template>
  <div id="overlay">
    <div id="content" class="my-3">
      <p class="body-1">
        ランキングへ登録しますか？
      </p>

      <div class="width300 my-3">
        <v-img :src="item.image" width="300" height="300"/>
      </div>

      <p>{{ item.angle.toFixed(2) }}°</p>
      <p>ニックネーム : {{ item.name }}</p>

      <div class="my-5">
        <v-btn class="mx-5"
               :disabled="!item.done"
               @click="$emit('register')"
        >
          <v-icon>
            mdi-pencil
          </v-icon>
          登録
        </v-btn>

        <v-btn class="mx-5"
          @click="$emit('close')"
        >
          <v-icon>
            mdi-arrow-u-left-top-bold
          </v-icon>
          戻る
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
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
