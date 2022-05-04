<template>
  <div id="overlay">
    <div id="content">
      <h1 class="display-1 font-weight-bold mb-5">
        <span>
          (全{{ rankers }}位中)
        </span>
        <br>
        結果は{{ rank }}位でした✌️
      </h1>

      <v-card class="body-1 mt-8 mb-1">
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
          <v-col class="mr-2">
            ピース✌️
          </v-col>
        </v-row>

      <v-divider/>

      <v-row class="text-h6"
             align="center"
             justify="center">
        <v-col>
          {{ rank }}位
        </v-col>
        <v-col>
          {{ sign.name }}
        </v-col>
        <v-col>
          {{ sign.angle }}°
        </v-col>
        <v-col>
          <img class="mt-5 mr-5"
             :src="sign.image"
             width="150"
             height="150"
          />
        </v-col>
      </v-row>
        </v-card>

      <p class="body-1 mt-8">
        Twitterで自慢しましょう！
      </p>

      <div class="my-5">
        <v-btn class="mx-5" 
               target="_blank"
               rel="noopener noreferrer"
               @click="$emit('tweet')"
        >
          <v-icon>
            mdi-twitter
          </v-icon>
          つぶやく
        </v-btn>

        <v-btn class="mx-5"
               @click="$emit('toTop')"
        >
          <v-icon>
            mdi-arrow-u-left-top-bold
          </v-icon>
          トップへ
        </v-btn>
      </div>
    </div>
  </div>
</template>

<script>
export default {
  props: ['item','sign','rank','rankers']
}
</script>

<style scoped>
#overlay {
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

#content {
  z-index:2;
  width:780px;
  padding: 1em;
  background:#fff;
}

span {
  font-size: 20px;
}
</style>
