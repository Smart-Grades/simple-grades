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

// Connect to Appwrite
APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

/**
 * Verify the user.
 */
const verify = async (userId, secret) => {
  try {
    await APP_ACCOUNT.updateVerification(userId, secret);

    // Show success message
    SNACKBAR.add({
      type: "success",
      text: "Dein Account wurde erfolgreich verifiziert.",
    });
    setTimeout(async () => {
      await navigateTo("/");
    }, 0);
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

// Get the query parameters
const route = useRoute();

// Get the userId and secret from the query parameters
const userId = route.query.userId;
const secret = route.query.secret;

// Check if the userId and secret are set
if (userId && secret) {
  await verify(userId, secret);
} else {
  await navigateTo("/auth");
}
</script>
