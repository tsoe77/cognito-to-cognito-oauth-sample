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
    userPoolId: "eu-west-1_xxx", // user_pool_id of app2 output

    // Amazon Cognito Web Client ID (26-char alphanumeric string)
    userPoolWebClientId: "xxxxxxYYYYYYYYzzzzzzzzz", // app2_client1_id of app2 output

    // // OPTIONAL - Hosted UI configuration
    oauth: {
      domain: "your-poolname.auth.eu-west-1.amazoncognito.com", // app2_oauth_domain of app2 output
      scope: ["openid"],
      redirectSignIn: "http://localhost:8002",
      redirectSignOut: "http://localhost:8002",
      responseType: "code", // or 'token', note that REFRESH token will only be generated when the responseType is code
    },
  },
});

const app = createApp(App);
app.mount("#app");
