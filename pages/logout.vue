<template>
  <div class="h-screen bg-dark"></div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();
const isLoggedIn = useState("isLoggedIn");

APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

const logout = async () => {
  console.log("logout");
  try {
    // Delete session
    const RES = await APP_ACCOUNT.deleteSession("current");

    if (RES) {
      console.log("logout success");
      isLoggedIn.value = false;
      setTimeout(async () => {
        await navigateTo("/");
      }, 0);
    } else {
      SNACKBAR.add({
        type: "error",
        text: "Ein Fehler ist aufgetreten.",
      });
      setTimeout(async () => {
        await navigateTo("/");
      }, 0);
    }
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

await logout();
</script>
