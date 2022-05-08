<template>
  <v-footer
    padless
  >
    <v-row
      justify="center"
      no-gutters
    >
      <!-- 利用規約 -->
      <v-dialog
        v-model="showService"
        width="70%"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            text
            rounded
            class="my-2 mx-8"
            v-bind="attrs"
            v-on="on"
          >
            {{ service }}
          </v-btn>
        </template>

        <Service
          @close="closeService"
        />
      </v-dialog>

      <!-- プライバシーポリシー -->
      <v-dialog
        v-model="showPolicy"
        width="70%"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            text
            rounded
            class="my-2 mx-8"
            v-bind="attrs"
            v-on="on"
          >
            {{ policy }}
          </v-btn>
        </template>

        <Policy
          @close="closePolicy"
        />
      </v-dialog>

      <!-- お問い合わせ -->
      <v-dialog
        v-model="showContact"
        width="500px"
      >
        <template v-slot:activator="{ on, attrs }">
          <v-btn
            text
            rounded
            class="my-2 mx-8"
            v-bind="attrs"
            v-on="on"
          >
            {{ contact }}
          </v-btn>
        </template>

        <Contact
          @close="closeContact"
        />
      </v-dialog>

      <v-col
        class="py-4 text-center"
        cols="12"
      >
        ©{{ new Date().getFullYear() }} ピースサイン競争
      </v-col>
    </v-row>
  </v-footer>
</template>

<script>
import Service from './Service.vue';
import Policy from './Policy.vue';
import Contact from './Contact.vue';

export default {
  components: {
    Service,
    Policy,
    Contact
  },

  data: function() {
    return {
      service: '利用規約',
      policy: 'プライバシーポリシー',
      contact: 'お問い合わせ',
      showService: false,
      showPolicy: false,
      showContact: false,
    }
  },

  methods: {
    // 利用規約
    closeService() {
      this.showService = false
    },
    // プライバシーポリシー
    closePolicy() {
      this.showPolicy = false
    },
    // お問合せ
    closeContact() {
      this.showContact = false
    }
  }
}
</script>
