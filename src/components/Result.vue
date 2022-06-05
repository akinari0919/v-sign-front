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

      <v-card class="card">
        <v-row class="hidden-sm-and-down">
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
        <v-col class="hidden-sm-and-down">
          <h3>{{ rank }}位</h3>
        </v-col>
        <v-col class="sm-col">
          <h3>{{ sign.name }}</h3>
        </v-col>
        <v-col class="sm-col">
          <h3>{{ sign.angle }}°</h3>
        </v-col>
        <v-col class="sm-col-img">
          <v-card class="sm-size mt-2 mr-3"
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

      <v-row justify="center">
        <div class="my-5">
            <v-btn class="mx-4"
                   target="_blank"
                   rel="noopener noreferrer"
                   @click="$emit('tweet')"
            >
              <v-icon>
                mdi-twitter
              </v-icon>
              つぶやく
            </v-btn>

            <v-btn class="mx-4"
                   @click="$emit('toTop')"
            >
              <v-icon>
                mdi-arrow-u-left-top-bold
              </v-icon>
              トップへ
            </v-btn>
        </div>
      </v-row>
    </div>
  </div>
</template>

<script scoped>
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
  width: 780px;
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

.card {
  background-color: #FFFFE0;
  margin-top: 30px;
}

@media (max-width: 768px) {
  #content {
    width: 330px;
  }
  #content.h3 {
    font-size: 15px;
  }

  h1 {
    font-size: 30px;
  }

  .card {
    margin-top: 0;
  }
  .sm-size {
    width: 170px;
    margin-left: 65px;
  }
  .sm-col-img {
    padding-top: 0;
  }
  .sm-col {
    padding-bottom: 0;
  }
}
</style>
