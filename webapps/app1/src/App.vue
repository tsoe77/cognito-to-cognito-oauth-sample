<script setup>
  import MyApp from "./components/MyApp.vue";
  import { Authenticator } from "@aws-amplify/ui-vue";
</script>

<template>
  <div>
    <h1 style="text-align: center">Test App #1</h1>
    <authenticator
      :login-mechanisms="['email']"
      :sign-up-attributes="['email']"
    >
      <template v-slot="{ user, signOut }">
        <MyApp />
        <p style="text-align: center">
          Logged in as: {{ user.attributes.email }}
        </p>
        <button style="margin: auto; display: block" @click="signOut">
          Sign Out
        </button>
      </template>
    </authenticator>
  </div>
</template>

<style>
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>
