<template>
  <div>
    <div
      class="container flex items-center justify-center min-h-screen px-6 mx-auto"
    >
      <form class="w-full max-w-md" @submit.prevent="handleInputChange">
        <div class="flex justify-center mx-auto">
          <NuxtLink to="/">
            <img src="/assets/img/logo.png" class="w-20 h-20 hover:scale-110 duration-300 ease-out-in" alt="SmartGrades-Logo">
          </NuxtLink>
        </div>

        <div class="flex items-center justify-center mt-6">
          <a
            href="#"
            class="w-1/3 pb-4 font-medium text-center text-gray-400 capitalize border-b border-gray-400"
            @click="() => switchAuthForm()"
          >
            Anmelden
          </a>

          <a
            href="#"
            class="w-1/3 pb-4 font-medium text-center text-white capitalize border-b-2 border-white"
          >
            Registrieren
          </a>
        </div>

        <div class="relative flex items-center mt-6">
          <span class="absolute px-4 scale-150">
            📧
          </span>

          <input
            v-model="INPUT.email"
            type="email"
            class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Email-Adresse"
          />
        </div>

        <div class="relative flex items-center mt-4">
          <span class="absolute px-4 scale-150">
            🔒
          </span>

          <input
            v-model="INPUT.password"
            type="password"
            class="block w-full px-11 py-3 border rounded-lg bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Passwort"
          />
        </div>

        <div class="relative flex items-center mt-4">
          <span class="absolute px-4 scale-150">
            🔒
          </span>

          <input
            v-model="INPUT.passwordRepeat"
            type="password"
            class="block w-full px-11 py-3 border rounded-lg bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Passwort wiederholen"
          />
        </div>

        <div class="mt-6">
          <button
            class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
          >
            Registrieren
          </button>
        </div>

        <div class="mt-4 text-center">
          <a
            href="#"
            class="text-sm text-gray-200 hover:underline"
            @click="() => switchAuthForm()"
          >
            Hast du bereits ein Konto?
          </a>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { Account, Client, ID } from "appwrite";

const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();

APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

const SWITCH_AUTH_PAGE = useState("toggleAuthPage");
const isLoggedIn = useState("isLoggedIn");
const SNACKBAR = useSnackbar();

const INPUT = reactive({
  email: "",
  password: "",
  passwordRepeat: "",
});

const getVerifyUrl = () => {
  return `${window.location.protocol}//${window.location.host}/verify`;
};

const login = async (email, password) => {
  console.log("login");
  let lIsLoggedIn = false;
  await APP_ACCOUNT.createEmailSession(email, password)
    .then((_res) => {
      console.log("login success", _res);
      isLoggedIn.value = true;
      lIsLoggedIn = true;
    })
    .catch((error) => {
      console.error(error);
      return false;
    });
  return lIsLoggedIn;
};

const logout = async () => {
  console.log("logout");
  try {
    // Delete session
    await APP_ACCOUNT.deleteSession("current");
    isLoggedIn.value = false;
  } catch (error) {
    console.error(error);
  }
};

const register = async (email, password) => {
  console.log("register");
  try {
    await APP_ACCOUNT.create(ID.unique(), email, password);
    if (await login(email, password)) {
      await APP_ACCOUNT.createVerification(getVerifyUrl());
      await logout();
      SNACKBAR.add({
        text: "Du hast dich erfolgreich registriert. Bitte verifiziere deine Email-Adresse.",
        type: "success",
      });
    }
  } catch (error) {
    console.error(error);
  }
};

const handleInputChange = async () => {
  if (!INPUT.email || !INPUT.password || !INPUT.passwordRepeat) {
    SNACKBAR.add({
      text: "Bitte fülle alle Felder aus.",
      type: "error",
    });
  }
  if (INPUT.password !== INPUT.passwordRepeat) {
    SNACKBAR.add({
      text: "Die Passwörter stimmen nicht überein.",
      type: "error",
    });
  }

  if (await register(INPUT.email, INPUT.password)) {
    INPUT.email = "";
    INPUT.password = "";
    navigateTo("/ident");
  }
};

const switchAuthForm = () => {
  SWITCH_AUTH_PAGE.value = !SWITCH_AUTH_PAGE.value;
};
</script>
