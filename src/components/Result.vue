<template>
  <div id="overlay">
    <div id="content">
      <h1 class="display-1 font-weight-bold mb-5">
        <span>(全{{ rankers }}位中)</span><br>
        結果は{{ rank }}位でした！!
      </h1>

      <table id="table" border="1">
        <thead>
          <tr>
            <th width="150">順位</th>
            <th width="150">投稿者</th>
            <th width="150">角度</th>
            <th width="150">✌️画像</th>
          </tr>
        </thead>
        <tbody>
          <tr>
            <td>{{ rank }}位</td>
            <td>{{ sign.name }}</td>
            <td>{{ sign.angle }}°</td>
            <td><img :src="sign.image" width="150" height="150"/></td>
          </tr>
        </tbody>
      </table>

      <p class="font-weight-regular mt-5">
        Twitterで自慢しましょう！
      </p>

      <div class="my-5">
        <v-btn class="mx-5" target="_blank" rel="noopener noreferrer" @click="$emit('tweet')">つぶやく</v-btn>
        <v-btn class="mx-5" @click="$emit('toTop')">トップへ</v-btn>
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
  width:50%;
  padding: 1em;
  background:#fff;
}

span {
  font-size: 20px;
}
</style>
