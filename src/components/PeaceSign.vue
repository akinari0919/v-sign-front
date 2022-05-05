<template>
  <v-container>
    <v-row class="text-center mb-3">
      <v-col cols="12">
        <transition name="fade"
                    appear
                    appear-class="custom-appear-class"
                    appear-active-class="custom-appear-active-class"
                    appear-to-class="custom-appear-to-class"
        >
          <v-img
            v-if="show"
            :src="require('../assets/peace-sign-logo.webp')"
            class="my-3"
            contain
            height="200"
          />
        </transition>
      </v-col>

      <v-col>
        <transition name="fade"
                    appear
                    appear-class="custom-appear-class"
                    appear-active-class="custom-appear-active-class"
                    appear-to-class="custom-appear-to-class"
        >

          <h1 class="font-weight-bold mb-3">
            <TextAnime1 v-if="anime1"/>
          </h1>
        </transition>

        <transition name="fade"
                    appear
                    appear-class="custom-appear-class"
                    appear-active-class="custom-appear-active-class"
                    appear-to-class="custom-appear-to-class"
        >
         <p class="subheading font-weight-regular">
           Peace - Sign - Competition
         </p>
        </transition>
      </v-col>

      <v-col cols="12">
        <p>
          ピースサインの指が開く角度で競い合ってみるサービスです。
          <br>
          (カメラの使用をONにしてご利用ください)
          <br>
          <br>
          <span style="color:#CC0033">** 現在PC環境でのみ対応しています **</span>
        </p>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import TextAnime1 from './TextAnime1'

export default {
  components: {
    TextAnime1,
  },
  data() {
    return {
      show: true,
      anime1: true
    }
  }
}

</script>

<style scoped>
/* アニメーション開始時 */
.custom-appear-class {
    opacity: 0;
}
/* アニメーション中 */
.custom-appear-active-class {
    transition: opacity 2s;
}
/* アニメーション終了時 */
.custom-appear-to-class {
    opacity: 1;
}
</style>
