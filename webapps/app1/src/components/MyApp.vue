<script setup>
  import { ref } from "vue";
  const count = ref(0);
</script>

<template>
  <div style="text-align: center">
    <p>Powered by Vue 3.0 + Vite</p>
    <h1>Hello! welcome to click the count!</h1>
    <button type="button" @click="count++">count is: {{ count }}</button>
  </div>
</template>