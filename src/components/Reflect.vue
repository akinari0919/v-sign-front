<template>
  <v-container>
    <v-row class="text-center mb-4">
      <v-col class="mb-3">
        <h1 class="display-1 font-weight-bold mb-3">
          反映する
        </h1>
        <p class="subheading font-weight-regular">
          Refrect
        </p>
        <p class="font-weight-regular">
          反映時点でのランキング結果を確認できます。
        </p>

        <div class="width300 mb-3">
          <v-col>
            <v-text-field
              v-model="item.name"
              counter
              maxlength="8"
              placeholder="(必須)ニックネーム"
            />
          </v-col>
        </div>

        <div class="item-list mb-3">
          <div class="shatter">
            <v-btn :disabled="!item.name" @click="openModal(item)" >確認してランキングへ反映</v-btn>
          </div>

          <modal :item="item" v-show="showContent" @close="closeModal" />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import Modal from './Modal.vue'

export default {
  components: {
    Modal
  },

  data: function() {
    return {
      showContent: false,
      item: {
        name: null,
        image: null,
        angle: null,
      }
    }
  },

  methods: {
    openModal(item) {
      this.showContent = true
    },
    closeModal() {
      this.showContent = false
    },
  },
};
</script>

<style scoped>
.width300 {
  width: 300px;
  margin: 0 auto;
}
</style>
