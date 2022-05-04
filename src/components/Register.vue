<template>
  <div id="overlay">
    <div id="content" class="my-3">
      <p class="text-h6 mt-3 mb-5">
        ランキングへ登録しますか？
      </p>

      <v-row class="text-h5 mt-5 mb-1"
             justify="center"
      >
        <v-text>
          {{ item.angle.toFixed(2) }}°
        </v-text>
      </v-row>

      <v-row justify="center">
        <v-card width="320px">
        <div class="width300 my-3">
          <v-img class="my-3"
                 :src="item.image"
                 width="300"
                 height="300"
          />
        </div>
        </v-card>
      </v-row>

      <v-row class="text-h6 mt-8 mb-1"
             justify="center"
      >
        <v-text>
          {{ item.name }}
        </v-text>
      </v-row>

      <v-row class="width300 mb-3"
             justify="center"
      >
        <v-col>
          <v-btn
            :disabled="!item.done"
            @click="$emit('register')"
          >
            <v-icon>
              mdi-pencil
            </v-icon>
            登録
          </v-btn>
        </v-col>

        <v-col>
          <v-btn
            @click="$emit('close')"
          >
            <v-icon>
              mdi-arrow-u-left-top-bold
            </v-icon>
            戻る
          </v-btn>
        </v-col>
      </v-row>
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
  width:500px;
  padding: 1em;
  background:#fff;
}

.width300 {
  width: 300px;
  margin: 0 auto;
}
</style>
