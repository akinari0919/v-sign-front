<template>
  <v-container>
    <v-row class="text-center mb-3">
      <v-col class="mb-4">
        <h1 class="display-1 font-weight-bold mb-3">
          ランキング
        </h1>

        <p class="subheading font-weight-regular">
          Ranking
        </p>

        <p class="body-1">
          現在{{ rankers }}位まで登録されています。
        </p>

        <!-- ページネーション -->
        <v-pagination
          color="black"
          v-model="page"
          :length="length"
          :total-visible="10"
          @input = "pageChange"
        />

        <div class="body-1 mt-8 mb-1">
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
            <v-col>
              ピース✌️
            </v-col>
            <v-col>
              投稿日
            </v-col>
          </v-row>
        </div>

        <v-card>
          <div
            class="mb-4"
            v-for="(sign, index) in displayLists"
            :key="index"
          >
            <v-row class="text-h6" align="center">
              <v-col>
                {{ index + 1 + pageRank }}位
              </v-col>
              <v-col>
                {{ sign.name }}
              </v-col>
              <v-col>
                {{ sign.angle.toFixed(2) }}°
              </v-col>
              <v-col>
                <v-card class="mb-3" >
                  <img class="mt-3"
                     :src="sign.image"
                     width="140"
                     height="140"
                  />
                </v-card>
              </v-col>
              <v-col>
                {{ sign.created_at.substr(0, 10) }}
              </v-col>
            </v-row>
            <v-divider/>
          </div>
        </v-card>

        <!-- ページネーション -->
        <v-pagination
          class="mt-12"
          color="black"
          v-model="page"
          :length="length"
          :total-visible="10"
          @input = "pageChange"
        />

      </v-col>
    </v-row>
  </v-container>

</template>

<script>
import axios from 'axios';
const url = process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com';

export default {
  data () {
    return {
      signs: null,
      rankers: null,
      // ページネーション
      pageRank: 0,
      length: 0,
      page: 1,
      displayLists: [],
      pageSize: 10,
    }
  },

  created () {
    axios
      .get(`${url}/v1/signs`)
      .then( response => {
        this.signs = response.data.signs

        // ページネーション
        this.length = Math.ceil(this.signs.length/this.pageSize)
        this.displayLists = this.signs.slice(this.pageSize*(this.page -1),
                            this.pageSize*(this.page))
        // 登録数
        this.rankers = response.data.rankers
      })
      .catch( (err) => {
        this.msg = err // エラー処理
      });
  },

  // ページネーション
  methods: {
    pageChange: function(pageNumber){
      this.displayLists = this.signs.slice(this.pageSize*(pageNumber -1),
                          this.pageSize*(pageNumber))
      this.pageRank = pageNumber *10 -10
    }
  }
}
</script>

<style>
#table {
  margin: auto;
}
</style>
