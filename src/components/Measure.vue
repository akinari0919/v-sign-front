<template>
  <v-container>
    <v-row class="text-center mb-4">
      <v-col>
        <!-- 測定 -->
        <h1 class="font-weight-bold mb-3 mt-12">
          <span class="bgc">測定する</span>
        </h1>

        <p class="subheading font-weight-regular">
          Measure
        </p>

        <p style="color:#CC0033"
           v-show="!isDisplay">
          ** カメラの使用をONにしてご利用ください **
        </p>

        <v-btn @click="cameraStart"
               :disabled="pushedBtn"
               v-on:click="disp"
               v-show="!isDisplay"
               class="mb-7"
        >
          <v-icon>
            mdi-camera
          </v-icon>
          カメラの使用をONにする
        </v-btn>

        <!-- 非表示 -->
        <div class="input_video">
          <p>〜カメラメンテナンス中により表示してます〜</p>
          <video ref="video" autoplay playsinline width="300" height="300"/>
          <div>
            <button v-on:click="capture()">Snap Photo</button>
          </div>
          <canvas id="canvass" width="300" height="300"/>

          <video
            id="video"
            class="input_video"
            ref="input_video"
          />
        </div>
        <!-- 非表示 -->

      <div v-show="isDisplay">
        <p>
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

        <!-- カメラ -->
        <v-row justify="center">

          <!-- 測定 -->
          <v-card class="card mx-2 my-3">
            <v-col>
              <h2>
                測定
              </h2>
              <v-divider/>
              <h2>
                {{ check.angle.toFixed(2) }}°
              </h2>
              <v-divider/>
                <v-card class="mt-3">
                  <canvas
                    id="canvas"
                    class="output_canvas mb-2 mt-4 mx-3"
                    ref="output_canvas"
                    :width="width"
                    :height="height"
                  />
                </v-card>
            </v-col>
          </v-card>

          <!-- MAX -->
          <v-card class="card mx-2 my-3">
            <v-col>
              <h2>
                MAX
              </h2>
              <v-divider/>
              <h2>
                {{ item.angle.toFixed(2) }}°
              </h2>
              <v-divider/>
                <v-card class="mt-3">
                <img
                  :src="item.image"
                  class="mb-2 mt-4 mx-3"
                  width="300"
                  height="300"
                />
                </v-card>
            </v-col>
          </v-card>
        </v-row>

        <p class="mt-3">
          ** 手の全体をカメラに収め、正面を向けると反応しやすいです **
        </p>

        <!-- 登録 -->
        <h1 class="font-weight-bold mb-3 mt-12">
          <span class="bgc">登録する</span>
        </h1>
        <p class="subheading font-weight-regular">
          Register
        </p>
        <p>
          ランキングへ反映し順位結果を確認できます。
        </p>

        <div class="width300 mb-3">
          <v-col>
            <v-text-field
              class="mb-5"
              color="black"
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
                   @click="openRegister"
            >
              <v-icon>
                mdi-check
              </v-icon>
              内容を確認
            </v-btn>
          </div>

          <!-- モーダル -->
          <register :item="item"
                    v-show="showRegister"
                    @close="closeRegister"
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
      showRegister: false,
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
      pushedBtn: false,
      isDisplay: false
    }
  },

  computed: {
    inputVideo() {
      return this.$refs.video;
    },
  },

  mounted() {
    this.ctx = this.$refs.output_canvas.getContext("2d");
    this.init();
  },

  methods: {
    // カメラON
    disp() {
      this.pushedBtn = true,
      this.isDisplay = true
    },

    // 反映モーダル
    openRegister() {
      this.showRegister = true
    },
    closeRegister() {
      this.showRegister = false
    },

    // 結果モーダル
    closeResult() {
      window.location.href = '/'
    },

    // Tweet設定
    tweet() {
      const tweetUrl = 'https://twitter.com/intent/tweet?text'
      const angle = `${this.sign.angle}°！!`
      const rank = `結果は${this.rank}位でした✌️`
      const comment = 'ピースサイン競争✌️%0d〜あなたは何度開く？〜'
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

      this.showRegister = false
      this.showResult = true
    },


    capture () {
     const video = this.$refs.video;
     const canvas = document.getElementById("canvass").getContext("2d");
     canvas.drawImage(video, 0, 0, 300, 300);
    },
    // MediaPipe設定
    cameraStart() {

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
        height: 300,
      });
      camera.start();

      const video = this.$refs.video;
      const constraints = new Camera(this.inputVideo, {
        onFrame: async () => {
          await hands.send({ image: this.inputVideo });
        },
        width: 300,
        height: 300,
      });

      navigator.mediaDevices.getUserMedia(constraints)
      .then(stream => {
        video.srcObject = stream;
        video.play()
      });
    },

    // 描画設定
    onResults(results) {
      this.width = 300;
      this.height = 300;
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

      const video = this.$refs.video;
      const canvas = document.getElementById("canvass").getContext("2d");
      canvas.save();
      canvas.clearRect(0, 0, 300, 300);
      canvas.drawImage(video, 0, 0, 300, 300);
      this.findHands(results);
      canvas.restore();
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

            // 描画
            const canvas = document.getElementById("canvass").getContext("2d");
            canvas.lineWidth = 10
            canvas.strokeStyle = '#ff0'
            canvas.beginPath()
            canvas.moveTo(indexX, indexY)
            canvas.lineTo(mcpX, mcpY)
            canvas.lineTo(middleX, middleY)
            canvas.stroke()

            // 角度算出
            const a = {x: indexX, y: indexY}
            const b = {x: mcpX, y: mcpY}
            const c = {x: middleX, y: middleY}

            const d0 = (Math.atan2(b.x - a.x, b.y - a.y) -
                        Math.atan2(b.x - c.x, b.y - c.y)) * 180 / Math.PI
            const d1 = (360 + d0) % 360 // ∠ABC
            const angle = d1 > 180 ? 360 - d1 : d1 // 180度を境に小さいほうの角度

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
    }
  }
};
</script>

<style scoped>
.input_video {
 display: none;
}

.output_canvas {
  width: 300px;
  height: 300px;
  transform: scale(-1, 1);
}

.width300 {
  width: 300px;
  margin: 0 auto;
}

.center-input input {
  text-align: center;
}

.card {
  background-color: #FFFFE0;
}
</style>
