<template>
  <v-container>
    <v-row class="text-center mb-3">
      <v-col class="mb-4">
        <h1 class="font-weight-bold mb-3">
          <span class="bgc">ランキング</span>
        </h1>

        <p class="subheading font-weight-regular">
          Ranking
        </p>

        <p>
          現在{{ rankers }}位まで登録されています。
        </p>

        <!-- ページネーション -->
        <v-pagination
          class="mb-8"
          color=#333333
          v-model="page"
          :length="length"
          :total-visible="10"
          @input = "pageChange"
        />

        <div class="hidden-sm-and-down">
          <v-row>
            <v-col>
                <span class="col-title">順位</span>
              </v-col>
              <v-col>
                <span class="col-title">投稿者</span>
              </v-col>
              <v-col>
                <span class="col-title">角度</span>
              </v-col>
              <v-col>
                <span class="col-title">ピース✌️</span>
              </v-col>
              <v-col>
                <span class="col-title">投稿日</span>
              </v-col>
            </v-row>
          </div>

          <v-card>
            <div
              class="card mt-1 mb-4"
              v-for="(sign, index) in displayLists"
              :key="index"
            >
              <v-row align="center">
                <v-col>
                  <h3>{{ index + 1 + pageRank }}位</h3>
                </v-col>
                <v-col>
                  <h3>{{ sign.name }}</h3>
                </v-col>
                <v-col>
                  <h3>{{ sign.angle.toFixed(2) }}°</h3>
                </v-col>
                <v-col>
                  <!-- なぜかResultのstyleが適用される -->
                  <v-card class="width150 mb-3" >
                    <img class="mt-2"
                       :src="sign.image"
                       width="140"
                       height="140"
                    />
                  </v-card>
                </v-col>
                <v-col>
                  <h3>{{ sign.created_at.substr(0, 10) }}</h3>
                </v-col>
              </v-row>
              <v-divider/>
            </div>
          </v-card>

          <!-- ページネーション -->
          <v-pagination
            class="mt-12"
            color=#333333
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

<style scoped>
#table {
  margin: auto;
}

width150 {
  width: 300px;
  margin: 0 auto;
}

@media (max-width: 768px) {
  h3 {
    font-size: 100%;
  }
}
</style>
