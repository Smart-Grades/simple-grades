<template>
  <div class="h-screen bg-dark"></div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();

APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

const verify = async (userId, secret) => {
  try {
    await APP_ACCOUNT.updateVerification(userId, secret);

    SNACKBAR.add({
      type: "success",
      text: "Dein Account wurde erfolgreich verifiziert.",
    });
    setTimeout(async () => {
      await navigateTo("/");
    }, 0);
  } catch (error) {
    console.error(error);
    SNACKBAR.add({
      type: "error",
      text: "Ein Fehler ist aufgetreten.",
    });
    setTimeout(async () => {
      await navigateTo("/");
    }, 0);
  }
};

const route = useRoute();

const userId = route.query.userId;
const secret = route.query.secret;

if (userId && secret) {
  await verify(userId, secret);
} else {
  await navigateTo("/auth");
}
</script>
