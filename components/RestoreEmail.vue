<template>
  <div>
    <!-- MAIN -->
    <form class="" @submit.prevent="handleInputChange">
      <div class="mb-6 flex-col items-center justify-center">
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          Passwort vergessen?
        </p>
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          Email angeben!
        </p>
      </div>

      <div class="w-80 md:w-96 lg:w-[500px]">
        <div>
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">Email</p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="relative flex items-center">
            <span class="absolute scale-150 px-3 mb-2"> 📨 </span>

            <input
              v-model="INPUT.email"
              type="email"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="max.mustermann@gmail.com"
            />
          </div>
        </div>
      </div>

      <div class="mt-8">
        <button
          class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
        >
          Reset password
        </button>
      </div>
    </form>
  </div>
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

const INPUT = reactive({
  email: "",
});

const getVerifyUrl = () => {
  return `${window.location.protocol}//${window.location.host}/reset`;
};

const sendResetEmail = async (email) => {
  try {
    await APP_ACCOUNT.createRecovery(email, getVerifyUrl());
    SNACKBAR.add({
      text: "Passwort zurücksetzen Email wurde versendet!",
      type: "success",
    });
    await navigateTo("/");
  } catch (error) {
    console.error(error);
    SNACKBAR.add({
      text: error.message,
      type: "error",
    });
  }
};

const handleInputChange = async () => {
  if (INPUT.email === "") {
    SNACKBAR.show({
      text: "Bitte Email angeben!",
      type: "error",
    });
    return;
  }
  await sendResetEmail(INPUT.email);
};
</script>
