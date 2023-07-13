<template>
  <div>
    <!-- MAIN -->
    <form class="" @submit.prevent="handleInputChange">
      <div class="mb-4 flex-col items-center justify-center">
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          Neues Passwort erstellen?
        </p>
      </div>

      <div class="w-80 md:w-96 lg:w-[500px]">
        <div>
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">
              Neues Passwort
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="relative flex items-center">
            <span class="absolute px-3.5"> 🗝️ </span>

            <input
              v-model="INPUT.password"
              type="password"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Neues Passwort"
            />
          </div>
        </div>

        <div class="mt-4">
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">
              Passwort wiederholen
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="relative flex items-center">
            <span class="absolute px-3.5"> 🗝️ </span>

            <input
              v-model="INPUT.passwordConfirm"
              type="password"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Passwort wiederholen"
            />
          </div>
        </div>
      </div>

      <div class="mt-8">
        <button
          class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
        >
          Passwort ändern
        </button>
      </div>
    </form>
  </div>
</template>

<script setup>
import { Account, Client } from "appwrite";

// Initialize client, account and snackbar
const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();

// Connect to Appwrite
APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

// Get query params
const route = useRoute();

// Check if query params are set
const userId = route.query.userId;
const secret = route.query.secret;

// Redirect to home if query params are not set
if (!userId || !secret) {
  await navigateTo("/");
}

// Initialize reactive variables
const INPUT = reactive({
  password: "",
  passwordConfirm: "",
});

/**
 * Reset password
 * @param {string} userId User ID
 * @param {string} secret Secret
 * @param {string} password New password
 * @param {string} passwordConfirm New password confirm
 */
const resetPassword = async (userId, secret, password, passwordConfirm) => {
  try {
    await APP_ACCOUNT.updateRecovery(userId, secret, password, passwordConfirm);

    SNACKBAR.add({
      type: "success",
      text: "Dein Passwort wurde erfolgreich geändert.",
    });
    setTimeout(async () => {
      await navigateTo("/auth");
    }, 0);
  } catch (error) {
    console.error(error);
    SNACKBAR.add({
      type: "error",
      text: "Ein Fehler ist aufgetreten.",
    });
    setTimeout(async () => {
      await navigateTo("/auth");
    }, 0);
  }
};

/**
 * Handle input value and validate them
 */
const handleInputChange = async () => {
  if (!INPUT.password || !INPUT.passwordConfirm) {
    SNACKBAR.add({
      type: "error",
      text: "Bitte fülle alle Felder aus.",
    });
    return;
  }

  if (INPUT.password !== INPUT.passwordConfirm) {
    SNACKBAR.add({
      type: "error",
      text: "Die Passwörter stimmen nicht überein.",
    });
    return;
  }

  await resetPassword(userId, secret, INPUT.password, INPUT.passwordConfirm);
};
</script>
