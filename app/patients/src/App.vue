<template>
  <v-app>
    <v-app-bar
      app
      color="#FF6900"
      dark
    >
      <div class="d-flex align-center">
        <v-toolbar-title>MTA app on Hana Cloud</v-toolbar-title>

      </div>

      <v-spacer></v-spacer>

      <v-btn
        href="https://cap.cloud.sap"
        target="_blank"
        text
      >
        <span class="mr-2">Latest Release</span>
        <v-icon>mdi-open-in-new</v-icon>
      </v-btn>
    </v-app-bar>

    <v-main>
      <HelloWorld/>
    </v-main>
  </v-app>
</template>

<script>
import HelloWorld from './components/HelloWorld';

export default {
  name: 'App',

  components: {
    HelloWorld,
  },

  data: () => ({
    //
  }),
};
</script>
