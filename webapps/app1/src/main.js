import { createApp } from "vue";
import App from "./App.vue";

import Amplify from "aws-amplify";
import AmplifyVue from "@aws-amplify/ui-vue";
import "@aws-amplify/ui-vue/styles.css";

Amplify.configure({
  Auth: {
    // REQUIRED - Amazon Cognito Region
    region: "eu-west-1",

    // Amazon Cognito User Pool ID
    userPoolId: "eu-west-1_xxx", // user_pool_id of app1 output

    // Amazon Cognito Web Client ID (26-char alphanumeric string)
    userPoolWebClientId: "xxxxxxYYYYYYYYzzzzzzzzz", // app1_client1_id of app1 output
  },
});

const app = createApp(App);
app.mount("#app");
