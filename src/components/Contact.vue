<template>
  <v-card>
    <v-card-title>
      <span class="text-h5">お問い合わせ</span>
    </v-card-title>
    <v-card-text>
      Twitter(
      <a href="https://twitter.com/runmizzo"
         target="_blank"
         rel="noopener noreferrer"
      >
         @runmizzo
      </a>
      )までご連絡をお願いいたします。
    </v-card-text>

    <v-card-actions>
      <v-spacer></v-spacer>
      <v-btn
        text
        @click="$emit('close')"
      >
        <v-icon>
          mdi-close
        </v-icon>
        閉じる
      </v-btn>
    </v-card-actions>
  </v-card>
</template>

<script>
</script>
