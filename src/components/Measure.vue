<template>
  <v-container>
    <v-row class="text-center mb-4">
      <v-col class="mb-3">
        <h1 class="display-1 font-weight-bold mb-3">
          測定する
        </h1>

        <p class="subheading font-weight-regular">
          Measure
        </p>

        <!-- 非表示 -->
        <video
          id="video"
          class="input_video"
          ref="input_video"
        />
        <!-- 非表示 -->

        <p class="body-1">
          カメラに✌️サインを向けてください。
        <br>
          ** 画面にVが表示されると自動測定されます **
        </p>

        <div class="mb-3">
          <v-btn :disabled="!item.angle"
                 @click="reset"
          >
            <v-icon>
              mdi-sync
            </v-icon>
            リセット
          </v-btn>
        </div>
        <table id="table" border="1">
          <thead>
            <tr class="text-h6">
              <th>測定</th>
              <th>MAX</th>
            </tr>
          </thead>
          <tbody>
            <tr class="text-h6">
              <td>{{ check.angle.toFixed(2) }}°</td>
              <td>{{ item.angle.toFixed(2) }}°</td>
            </tr>
            <tr>
              <td>
                <canvas
                  id="canvas"
                  class="output_canvas mt-2 mx-2"
                  ref="output_canvas"
                  :width="width"
                  :height="height"
                />
              </td>
              <td>
                <img
                  :src="item.image"
                  class="mt-2 mx-2"
                  width="300"
                  height="300"
                />
              </td>
            </tr>
          </tbody>
        </table>

        <p class="body-1 mt-2">
          ** 手の全体をカメラに収め、正面を向けると反応しやすいです **
        </p>

        <h1 class="display-1 font-weight-bold mb-3 mt-12">
          登録する
        </h1>
        <p class="subheading font-weight-regular">
          Register
        </p>
        <p class="body-1">
          ランキングへ反映し順位結果が確認できます。
        </p>

        <div class="width300 mb-3">
          <v-col>
            <v-text-field
              class="mb-5"
              v-model="item.name"
              counter
              maxlength="8"
              placeholder="(必須)ニックネーム"
            />
          </v-col>
        </div>

        <div class="item-list mb-3">
          <div class="shatter">
            <v-btn :disabled="!item.name"
                   @click="openReflect"
            >
              <v-icon>
                mdi-check
              </v-icon>
              内容を確認する
            </v-btn>
          </div>

          <register :item="item"
                   v-show="showReflect"
                   @close="closeReflect"
                   @register="register"
          />

          <result :item="item"
                  :sign="sign"
                  :rank="rank"
                  :rankers="rankers"
                  v-show="showResult"
                  @toTop="closeResult"
                  @tweet="tweet"
          />
        </div>
      </v-col>
    </v-row>
  </v-container>
</template>

<script>
import { Hands } from "@mediapipe/hands";
import { Camera } from "@mediapipe/camera_utils";
import Register from './Register.vue';
import Result from './Result.vue';
import axios from 'axios';
const url = process.env.VUE_APP_API_URL || 'https://v-sign-api.herokuapp.com';

export default {
  components: {
    Register,
    Result
  },

  data: function() {
    return {
      ctx: null,
      width: null,
      height: null,
      showReflect: false,
      showResult: false,
      item: {
        name: null,
        image: require('../assets/peace-sign-logo.webp'),
        angle: 0,
        done: null
      },
      sign: {
        name: null,
        angle: null
      },
      check: {
        angle: 0
      },
      rank: null,
      rankers: null,
    }
  },

  computed: {
    inputVideo() {
      return this.$refs.input_video;
    },
  },

  mounted() {
    this.ctx = this.$refs.output_canvas.getContext("2d");
    this.init();
  },

  methods: {
    // 反映モーダル
    openReflect() {
      this.showReflect = true
    },
    closeReflect() {
      this.showReflect = false
    },

    // 結果モーダル
    closeResult() {
      window.location.href = '/'
    },
    tweet() {
      const tweetUrl = 'https://twitter.com/intent/tweet?text'
      const angle = `${this.sign.angle}°！!`
      const rank = `結果は${this.rank}位でした✌️`
      const comment = 'ピースサイン競争✌️%0d〜あなたの指の角度を測定〜'
      const serviceUrl = 'https://www.peace-sign-competition.com/'
      const hash = '&hashtags=ピースサイン競争,ピースサイン'
      window.open(`${tweetUrl}=${angle}%0d${rank}%0d%0d${comment}%0d${serviceUrl}%0d${hash}`,
               '_blank'
               )
    },

    register: function() {
      axios
        .post(`${url}/v1/signs`, {
          name: this.item.name,
          image: this.item.image,
          angle: this.item.angle,
          type: 0
        })
        .then( response => {
          this.sign = response.data.sign
          this.rank = response.data.rank
          this.rankers = response.data.rankers
          this.sign.angle = this.sign.angle.toFixed(2)
        })
        .catch( (err) => {
          this.msg = err // エラー処理
        });

      this.showReflect = false
      this.showResult = true
    },

    // MediaPipe設定
    init() {
      const hands = new Hands({
        locateFile: (file) => {
          return `https://cdn.jsdelivr.net/npm/@mediapipe/hands/${file}`;
        },
      });
      hands.setOptions({
        maxNumHands: 1,
        modelComplexity: 1,
        minDetectionConfidence: 0.5,
        minTrackingConfidence: 0.5,
      });
      hands.onResults(this.onResults);

      const camera = new Camera(this.inputVideo, {
        onFrame: async () => {
          await hands.send({ image: this.inputVideo });
        },
        width: 300,
        height: 300
      });
      camera.start();
    },

    // 描画設定
    onResults(results) {
      this.width = results.image.width;
      this.height = results.image.height;
      this.ctx.save();
      this.ctx.clearRect(0, 0, results.image.width, results.image.height);
      this.ctx.drawImage(
        results.image,
        0,
        0,
        results.image.width,
        results.image.height
      );
      this.findHands(results);
      this.ctx.restore();
    },

    // リセット
    reset() {
      this.check.angle = 0
      this.item.angle = 0
      this.item.image = require('../assets/peace-sign-logo.webp')
      this.item.done = null
    },

    // 描画と測定
    findHands(results) {
      if (results.multiHandLandmarks) {
        for (const marks of results.multiHandLandmarks) {

          // 人差し指
          const indexFingerTipY = marks[8].y // 指先y
          const indexFingerDipY = marks[7].y // 第1関節y
          const indexFingerMcpY = marks[5].y // 付け根y
          const indexFingerMcpX = marks[5].x // 付け根x
          // 中指
          const middleFingerTipY = marks[12].y // 指先y
          const middleFingerDipY = marks[11].y // 第1関節y
          const middleFingerPipY = marks[10].y // 第2関節y
          const middleFingerMcpX = marks[9].x // 付け根x
          // 薬指
          const ringFingerTipY = marks[16].y // 指先y
          const ringFingerPipY = marks[14].y // 第2関節y
          const ringFingerMcpX = marks[13].x // 付け根x
          const ringFingerMcpY = marks[13].y // 付け根y
          // 子指
          const pinkyFingerTipY = marks[20].y // 指先y
          const pinkyFingerMcpY = marks[17].y // 付け根y
          // 親指
          const thumbFingerTipX = marks[4].x // 指先x

          // ポーズ条件
          const indexMiddleOpen = indexFingerTipY < indexFingerDipY && middleFingerTipY < middleFingerDipY
          const ringPinkyClose = ringFingerTipY > ringFingerMcpY && pinkyFingerTipY > pinkyFingerMcpY
          // 親指の位置(左右の手に対応)
          const rightHand = middleFingerMcpX < indexFingerMcpX && thumbFingerTipX < indexFingerMcpX && thumbFingerTipX > ringFingerMcpX
          const leftHand = middleFingerMcpX > indexFingerMcpX && thumbFingerTipX > indexFingerMcpX && thumbFingerTipX < ringFingerMcpX
          // 前後角度条件
          const handAngle = ringFingerPipY < ringFingerMcpY
          // その他補正
          const correction1 = middleFingerPipY > indexFingerTipY && indexFingerDipY > middleFingerTipY
          const correction2 = middleFingerTipY < indexFingerMcpY
          const correction = correction1 && correction2

          // 条件集約
          const peaceSignRight =  indexMiddleOpen && ringPinkyClose && rightHand && correction && handAngle
          const peaceSignLeft =  indexMiddleOpen && ringPinkyClose && leftHand && correction && handAngle

          // 条件一致した場合
          if(peaceSignRight || peaceSignLeft) {

            // カメラサイズ
            const cameraSize = 300

            // 人差し指
            const indexX = cameraSize * marks[8].x
            const indexY = cameraSize * marks[8].y

            // 中指
            const middleX = cameraSize * marks[12].x
            const middleY = cameraSize * marks[12].y

            // 付け根
            const mcpX = cameraSize * ((marks[5].x + marks[9].x) / 2)
            const mcpY = cameraSize * ((marks[5].y + marks[9].y) / 2)

            // 描画
            this.ctx.lineWidth = 10
            this.ctx.strokeStyle = '#ff0'
            this.ctx.beginPath()
            this.ctx.moveTo(indexX, indexY)
            this.ctx.lineTo(mcpX, mcpY)
            this.ctx.lineTo(middleX, middleY)
            this.ctx.stroke()


            // 角度算出
            const ba0 = indexX - mcpX
            const ba1 = indexY - mcpY
            const bc0 = middleX - mcpX
            const bc1 = middleY - mcpY
            const babc = ba0 * bc0 + ba1 * bc1
            const ban = (ba0 * ba0) + (ba1 * ba1)
            const bcn = (bc0 * bc0) + (bc1 * bc1)
            const radian = Math.acos(babc / (Math.sqrt(ban * bcn)))
            const angle = radian * 180 / Math.PI
            this.$set(this.check, 'angle', angle)
            this.item.done = true

            // MAX反映
            if (this.check.angle > this.item.angle && this.check.angle > 10) {
              this.$set(this.item, 'angle', angle)
              const canvas = document.getElementById("canvas")
              const base64 = canvas.toDataURL('image/jpeg').replace(/data:.*\/.*;base64,/, '')
              this.$set(this.item, 'image', `data:image/jpeg;base64,${base64}`)
            }
          }
        }
      }
    },
  },
};
</script>

<style scoped>
.input_video {
  display: none;
}

.output_canvas {
  width: 300px;
  height: 300px;
}

.width300 {
  width: 300px;
  margin: 0 auto;
}

.center-input input {
  text-align: center;
}
</style>
