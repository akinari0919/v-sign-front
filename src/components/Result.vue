<template>
  <div id="overlay">
    <div id="content" class="my-modal">
      <h3 class="font-weight-bold mb-5">
        <h3>
          (全{{ rankers }}位中)
        </h3>
        <h1>
          結果は{{ rank }}位でした✌️
        </h1>
      </h3>

      <v-card class="card mt-8 mb-1">
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

      <v-row align="center"
             justify="center">
        <v-col>
          <h3>{{ rank }}位</h3>
        </v-col>
        <v-col>
          <h3>{{ sign.name }}</h3>
        </v-col>
        <v-col>
          <h3>{{ sign.angle }}°</h3>
        </v-col>
        <v-col>
          <v-card class="mt-2 mr-3"
                  jsutify="center"
          >
            <img class="mt-2 mx-2"
               :src="sign.image"
               width="150"
               height="150"
            />
          </v-card>
        </v-col>
      </v-row>
        </v-card>

      <p class="mt-8">
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

.card {
  background-color: #FFFFE0;
}
</style>
