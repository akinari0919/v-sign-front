<template>
  <v-app-bar
    app
    color="dark"
    dark
  >
    <div class="d-flex align-center">
      <v-img
        alt="PeaceSign Logo"
        class="shrink mr-2"
        contain
        src="../assets/peace-sign-logo.webp"
        transition="scale-transition"
        width="40"
      />

      <h1
        alt="PeaceSign Name"
        class="shrink mt-1 hidden-sm-and-down"
        contain
        min-width="100"
        width="100"
      >
       ピースサイン競争
      </h1>
    </div>

    <v-spacer></v-spacer>

    <v-toolbar-items>
      <v-menu offset-y>
        <template v-slot:activator="{on}">
          <v-btn v-on="on" text width="230px">
            <v-icon>
              mdi-information-outline
            </v-icon>
            information
            <v-icon>
              mdi-menu-down
            </v-icon>
          </v-btn>
        </template>

        <v-list>
          <!-- 利用規約 -->
          <v-list-item>
            <v-dialog
              v-model="showService"
              width="70%"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  rounded
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
          </v-list-item>

          <!-- プライバシーポリシー -->
          <v-list-item>
            <v-dialog
              v-model="showPolicy"
              width="70%"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  rounded
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
          </v-list-item>

          <!-- お問い合わせ -->
          <v-list-item>
            <v-dialog
              v-model="showContact"
              width="500px"
            >
              <template v-slot:activator="{ on, attrs }">
                <v-btn
                  text
                  rounded
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
          </v-list-item>

        </v-list>
      </v-menu>
    </v-toolbar-items>
  </v-app-bar>
</template>

<script>
import Service from './Service.vue';
import Policy from './Policy.vue';
import Contact from './Contact.vue';

export default {
  name: 'App',

  components: {
    Service,
    Policy,
    Contact
  },

  data(){
    return{
      drawer: null,
      service: '利用規約',
      policy: 'プライバシーポリシー',
      contact: 'お問い合わせ',
      showService: false,
      showPolicy: false,
      showContact: false
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
