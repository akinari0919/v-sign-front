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

        <p class="font-weight-regular">
          カメラに✌️サインを向けて下さい。
        <br>
          ** Vが表示されている間は測定され続けます **
        </p>

        <p class="font-weight-regular">{{ item.angle }}</p>

        <canvas
          id="canvas"
          class="output_canvas"
          ref="output_canvas"
          :width="width"
          :height="height"
        />
        <img
          :src="'data:image/jpeg;base64,' + item.image"
          width="300"
          height="300"
        />

        <p class="font-weight-regular">
          ** 手の全体をカメラに収め、正面を向けると反応し易くなります **
        </p>

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
import { Hands } from "@mediapipe/hands";
import { Camera } from "@mediapipe/camera_utils";
import Modal from './Modal.vue'

export default {
  components: {
    Modal
  },

  name: "HandModel",

  data: function() {
    return {
      number: null,
      ctx: null,
      width: null,
      height: null,
      showContent: false,
      item: {
        name: null,
        image: null,
        angle: '→ 角度が表示されます ←'
      }
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
    // モーダル
    openModal(item) {
      this.showContent = true
    },
    closeModal() {
      this.showContent = false
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
            this.ctx.lineWidth = 8
            this.ctx.strokeStyle = '#ff0'
            this.ctx.beginPath()
            this.ctx.moveTo(indexX, indexY)
            this.ctx.lineTo(mcpX, mcpY)
            this.ctx.lineTo(middleX, middleY)
            this.ctx.stroke()

            const canvas = document.getElementById("canvas")
            const base64 = canvas.toDataURL('image/jpeg').replace(/data:.*\/.*;base64,/, '')
            this.$set(this.item, 'image', base64)

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
            // 表示
            this.$set(this.item, 'angle', angle.toFixed(2)+'°')
          }
        }
      }
    }
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
</style>
