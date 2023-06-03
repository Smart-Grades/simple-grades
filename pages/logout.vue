<template>
  <div></div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const APP_CLIENT = new Client();
const ACCOUNT = new Account(APP_CLIENT);

const runtimeConfig = useRuntimeConfig();
APP_CLIENT.setEndpoint(runtimeConfig.public.appwriteEndpoint).setProject(
  runtimeConfig.public.appwriteProject
);

try {
  await ACCOUNT.get();
  console.log("logging out");
  await ACCOUNT.deleteSession("current");
  console.log("logged out");
  app.$auth.loggedIn = false;
} catch (error) {
  console.log(error);
} finally {
  console.log("redirecting");
  navigateTo("/");
}
</script>
