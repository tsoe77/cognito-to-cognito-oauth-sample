<script setup>
  import MyApp from "./components/MyApp.vue";
  import { Authenticator } from "@aws-amplify/ui-vue";
</script>

<template>
  <div>
    <h1 style="text-align: center">Test App #2</h1>
    <authenticator
      :login-mechanisms="['email']"
      :sign-up-attributes="['email']"
    >
      <template v-slot="{ user, signOut }">
        <MyApp />
        <p style="text-align: center" v-if="!oauth_user">
          Logged in as: {{ user.attributes.email }}
        </p>
        <p style="text-align: center" v-else>
          Logged in as: {{ user.signInUserSession.idToken.payload.email }}
        </p>
        <button style="margin: auto; display: block" @click="signOut">
          Sign Out
        </button>
      </template>

      <template v-slot:sign-in-footer>
        <div style="text-align: center">
          <button
            @click="toResetPassword"
            class="amplify-button amplify-field-group__control"
            data-fullwidth="true"
            data-size="small"
            data-variation="link"
            type="button"
            style="font-weight: normal"
          >
            Forgot your password?
          </button>
          <hr />
          <button
            @click="Auth.federatedSignIn({ provider: 'app1' })"
            class="amplify-button amplify-field-group__control"
            data-fullwidth="true"
            data-size="small"
            data-variation="link"
            type="button"
            style="font-weight: normal; padding-bottom: 10px"
          >
            Sign in with App1
          </button>
        </div>
      </template>
    </authenticator>
  </div>
</template>

<script>
  import { defineComponent } from "vue";
  import { Auth } from "aws-amplify";

  export default defineComponent({
    setup() {},
    data: () => ({
      oauth_user: null,
    }),
    method: {
      signInWithIdp() {
        Auth.federatedSignIn({ provider: "app1" });
      },
    },
    beforeCreate() {
      Auth.currentAuthenticatedUser()
        .then((user) => {
          this.oauth_user = user;
        })
        .catch(() => console.log("Not signed in"));
    },
  });
</script>

<style>
  #app {
    font-family: Avenir, Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    color: #2c3e50;
    margin-top: 60px;
  }
</style>
