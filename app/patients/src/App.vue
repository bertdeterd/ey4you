<template>
  <v-app>
   
    <v-main>
      <HelloSCP/>
    </v-main>
  </v-app>
</template>

<script>
import HelloSCP from './components/HelloSCP';

export default {
  name: 'App',

  components: {
    HelloSCP,
  },

  data: () => ({
    //
  }),
};
</script>
