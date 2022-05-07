<template>
  <div id="overlay">
    <div id="content" class="my-modal my-3">
      <h2 class="mt-3 mb-5">
        ランキングへ登録しますか？
      </h2>

      <v-row class="mt-5 mb-1"
             justify="center"
      >
        <h2>
          {{ item.angle.toFixed(2) }}°
        </h2>
      </v-row>

      <v-row justify="center">
        <v-card class="card-img">
          <div class="width300 mt-1">
            <img class="my-3"
                 :src="item.image"
                 width="300"
                 height="300"
            />
          </div>
        </v-card>
      </v-row>

      <v-row class="mt-8 mb-1"
             justify="center"
      >
        <h2>
          {{ item.name }}
        </h2>
      </v-row>

      <v-row class="width300 mb-3 mx-12"
             justify="center"
      >
        <v-col>
          <v-btn
            class="width180"
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
            class="width180"
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
  background:
    radial-gradient(rgba(0,128,0,0.1), 3px, transparent 4px),
    radial-gradient(rgba(0,128,0,0.1), 3px, transparent 4px),
    linear-gradient(#fff 4px, transparent 0),
    linear-gradient(45deg, transparent 74px, transparent 75px, rgba(0,128,0,0.1) 75px, rgba(0,128,0,0.1) 76px, transparent 77px, transparent 109px),
    linear-gradient(-45deg, transparent 75px, transparent 76px, rgba(0,128,0,0.1) 76px, rgba(0,128,0,0.1) 77px, transparent 78px, transparent 109px),
  #fff;
  background-size: 109px 109px, 109px 109px,100% 6px, 109px 109px, 109px 109px;
  background-position: 54px 55px, 0px 0px, 0px 0px, 0px 0px, 0px 0px;
}

.card-img {
  width: 330px;
}

.width150 {
  width: 150px;
  margin: 0 auto;
}

/* TODO:写真位置の修正  */
@media (max-width: 768px) {
  #content {
    width: 90%;
  }

  .my-modal {
    font-size: 13px;
  }

  .card-img {
    width: 180px;
  }

  img {
    height: 150px;
    width: 150px;
  }

  .width300 {
    width: 200px;
    margin: 0 auto;
  }
  .width180 {
    width: 180px;
  }

}
</style>
