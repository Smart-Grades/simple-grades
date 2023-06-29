<template>
  <div class="">
    <div class="">
      <div class="mb-2 -ml-3">
        <NuxtLink to="/">
          <img
            src="/assets/img/logo.png"
            alt=""
            class="hidden xl:block w-16 h-16 hover:scale-110 duration-300 cursor-pointer ease-in"
          />
        </NuxtLink>
      </div>

      <!-- MAIN -->
      <div class="">
        <div class="mb-6 flex-col items-center justify-center">
          <p class="font-main text-xl text-white font-bold cursor-pointer">
            Neue Email?
          </p>
        </div>

        <div class="w-80 md:w-96 lg:w-[500px]">
          <div class="">
            <div class="mb-3">
              <p class="text-sm text-gray-300 font-semibold mb-1">
                Neue Email-Adresse
              </p>
              <p class="border-b-2 w-1/2"></p>
            </div>

            <div class="space-y-4">
              <!-- INPUT FIELD UNI -->
              <div class="relative flex items-center">
                <span class="absolute px-4 scale-150"> 📧 </span>

                <input
                  v-model="mailData.email"
                  type="email"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neue Email"
                />
              </div>

              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  v-model="mailData.password"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Aktuelles Passwort"
                />
              </div>
            </div>

            <div class="mt-8">
              <button
                class="w-full px-6 py-3 text-sm font-medium text-white capitalize duration-500 ease-out-in transform bg-fom rounded-lg hover:opacity-80"
                @click="handleMailUpdate()"
              >
                Change E-Mail
              </button>
            </div>
          </div>

          <div class="mt-20">
            <div class="mb-6 flex-col items-center justify-center">
              <p class="font-main text-xl text-white font-bold cursor-pointer">
                Neues Passwort?
              </p>
            </div>
            <div class="mb-3">
              <p class="text-sm text-gray-300 font-semibold mb-1">
                Neues Passwort
              </p>
              <p class="border-b-2 w-1/2"></p>
            </div>

            <div class="space-y-4">
              <!-- INPUT FIELD MAJOR -->
              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  v-model="passwordData.currentPassword"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Aktuelles Passwort"
                />
              </div>

              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  v-model="passwordData.newPassword"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neues Passwort"
                />
              </div>

              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  v-model="passwordData.newPasswordRepeat"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neues Passwort wiederholen"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-8">
      <button
        class="w-full px-6 py-3 text-sm font-medium text-white capitalize duration-500 ease-out-in transform bg-fom rounded-lg hover:opacity-80"
        @click="handlePasswordUpdate()"
      >
        Change Password
      </button>
    </div>
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

const mailData = reactive({
  email: "",
  password: "",
});

const passwordData = reactive({
  currentPassword: "",
  newPassword: "",
  newPasswordRepeat: "",
});

const getVerifyUrl = () => {
  return `${window.location.protocol}//${window.location.host}/verify`;
};

const updateEmail = async (mail, password) => {
  try {
    const RES = await APP_ACCOUNT.updateEmail(mail, password);
    if (RES.$id) {
      await APP_ACCOUNT.createVerification(getVerifyUrl());
      SNACKBAR.add({
        title: "Bitte verifiziere deine neue Email",
        type: "success",
      });
      await navigateTo("/logout");
    } else {
      SNACKBAR.add({
        title: "Email konnte nicht geändert werden",
        type: "error",
      });
    }
  } catch (error) {
    SNACKBAR.add({
      title: "Email konnte nicht geändert werden",
      type: "error",
    });
  }
};

const updatePassword = async (currentPassword, newPassword) => {
  try {
    const RES = await APP_ACCOUNT.updatePassword(newPassword, currentPassword);
    if (RES.$id) {
      SNACKBAR.add({
        title: "Passwort wurde geändert",
        type: "success",
      });
      await navigateTo("/logout");
    } else {
      SNACKBAR.add({
        title: "Passwort konnte nicht geändert werden",
        type: "error",
      });
    }
  } catch (error) {
    SNACKBAR.add({
      title: "Passwort konnte nicht geändert werden",
      type: "error",
    });
  }
};

const handleMailUpdate = () => {
  if (mailData.email && mailData.password) {
    updateEmail(mailData.email, mailData.password);
  }
};

const handlePasswordUpdate = () => {
  if (
    passwordData.currentPassword &&
    passwordData.newPassword &&
    passwordData.newPasswordRepeat
  ) {
    if (passwordData.newPassword === passwordData.newPasswordRepeat) {
      updatePassword(passwordData.currentPassword, passwordData.newPassword);
    } else {
      SNACKBAR.add({
        title: "Passwörter stimmen nicht überein",
        type: "error",
      });
    }
  }
};
</script>
