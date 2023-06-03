<template>
  <div></div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const APP_CLIENT = new Client();
const ACCOUNT = new Account(APP_CLIENT);

const runtimeConfig = useRuntimeConfig();
const ROUTE = useRoute();

APP_CLIENT.setEndpoint(runtimeConfig.public.appwriteEndpoint).setProject(
  runtimeConfig.public.appwriteProject
);

const verifyUser = (userId, secret) =>
  ACCOUNT.updateVerification(userId, secret)
    .then((res) => {
      console.log(res);
    })
    .catch((error) => {
      console.error(error);
      navigateTo("/auth");
    });

if (ROUTE.query.userId && ROUTE.query.secret) {
  verifyUser(ROUTE.query.userId, ROUTE.query.secret);
} else {
  navigateTo("/auth");
}
</script>
