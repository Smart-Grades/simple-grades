<template>
  <div class="h-screen bg-dark"></div>
</template>

<script setup>
import { Account, Client } from "appwrite";

// This code initializes the client, account, and snackbar objects.
const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();
const isLoggedIn = useState("isLoggedIn");

// Connect to Appwrite
APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

/**
 * Logout the user.
 */
const logout = async () => {
  console.log("logout");
  try {
    // Delete session
    const RES = await APP_ACCOUNT.deleteSession("current");

    if (RES) {
      console.log("logout success");

      // Update the isLoggedIn variable to reflect the change in state
      isLoggedIn.value = false;

      // Wait 0 seconds before navigating to the root of the site
      setTimeout(async () => {
        await navigateTo("/");
      }, 0);
    } else {
      // Show error message
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
    // Show error message
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
