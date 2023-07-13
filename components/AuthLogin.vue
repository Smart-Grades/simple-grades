<template>
  <div>
    <div
      class="container flex items-center justify-center min-h-screen px-6 mx-auto"
    >
      <form class="w-full max-w-md" @submit.prevent="handleInputChange">
        <div class="flex justify-center mx-auto">
          <NuxtLink to="/">
            <img
              src="/assets/img/logo.png"
              class="w-20 h-20 hover:scale-110 duration-300 ease-out-in"
              alt="SmartGrades-Logo"
            />
          </NuxtLink>
        </div>

        <div class="flex items-center justify-center mt-6">
          <a
            href="#"
            class="w-1/3 pb-4 font-medium text-center text-white capitalize border-b-2 border-white"
          >
            Anmelden
          </a>

          <a
            href="#"
            class="w-1/3 pb-4 font-medium text-center text-gray-400 capitalize border-b border-gray-400"
            @click="() => switchAuthForm()"
          >
            Registrieren
          </a>
        </div>

        <div class="relative flex items-center mt-6">
          <span class="absolute px-4 scale-150">📧</span>

          <input
            v-model="INPUT.mail"
            type="email"
            class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Email-Adresse"
          />
        </div>

        <div class="relative flex items-center mt-4">
          <span class="absolute px-4 mb-0.5 scale-150"> 🔒 </span>

          <input
            v-model="INPUT.password"
            type="password"
            class="block w-full px-11 py-3 border rounded-lg bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Passwort"
          />
        </div>

        <div class="mt-6">
          <button
            class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
          >
            Anmelden
          </button>
        </div>

        <div class="mt-6 flex flex-wrap justify-between">
          <a
            href="#"
            class="text-sm text-gray-200 hover:underline"
            @click="() => switchAuthForm()"
          >
            Besitzt du noch keinen Account?
          </a>

          <a href="/restore" class="text-sm text-gray-200 hover:underline">
            Passwort vergessen?
          </a>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { Account, Client } from "appwrite";

// Initalizing client, account and snackbar
const SWITCH_AUTH_PAGE = useState("toggleAuthPage");
const isLoggedIn = useState("isLoggedIn");
const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();

// Connecting to Appwrite
APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

// Redirecting to dashboard if user is logged in
if (isLoggedIn.value) {
  navigateTo("/dashboard");
}

// Reactive variables
const INPUT = reactive({
  mail: "",
  password: "",
});
const INPUT_ERRORS = ref(false);

/**
 * Logs in the user with the given mail and password.
 * @param {string} mail User's mail
 * @param {string} password User's password
 */
const login = async (mail, password) => {
  try {
    const RES = await APP_ACCOUNT.createEmailSession(mail, password);
    if (RES.$id) {
      APP_ACCOUNT.get().then((res) => {
        if (!res.emailVerification) {
          SNACKBAR.add({
            type: "warning",
            text: "Bitte verifiziere deine E-Mail-Adresse.",
          });
        } else {
          isLoggedIn.value = true;
          navigateTo("/dashboard");
        }
      });
    }
  } catch (error) {
    console.error(error);
    SNACKBAR.add({
      type: "error",
      text: "Ein Fehler ist aufgetreten.",
    });
  }
};

/**
 * Switches the auth form.
 */
const switchAuthForm = () => {
  SWITCH_AUTH_PAGE.value = !SWITCH_AUTH_PAGE.value;
};

/**
 * Handles the input change.
 */
const handleInputChange = () => {
  INPUT_ERRORS.value = !(INPUT.mail && INPUT.password);

  if (!INPUT_ERRORS.value) {
    login(INPUT.mail, INPUT.password);
  }
};
</script>
