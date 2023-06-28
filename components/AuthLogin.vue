<template>
  <div>
    <div
      class="container flex items-center justify-center min-h-screen px-6 mx-auto"
    >
      <form class="w-full max-w-md" @submit.prevent="handleInputChange">
        <div class="flex justify-center mx-auto">
          <NuxtLink to="/">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              fill="none"
              viewBox="0 0 24 24"
              stroke-width="1.5"
              stroke="currentColor"
              class="w-12 h-12 text-white hover:scale-110 cursor-pointer duration-300 ease-out-in"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5"
              />
            </svg>
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
          <span class="absolute">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="w-6 h-6 mx-3 text-white"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z"
              />
            </svg>
          </span>

          <input
            v-model="INPUT.mail"
            type="email"
            class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Email-Adresse"
          />
        </div>

        <div class="relative flex items-center mt-4">
          <span class="absolute">
            <svg
              xmlns="http://www.w3.org/2000/svg"
              class="w-6 h-6 mx-3 text-white"
              fill="none"
              viewBox="0 0 24 24"
              stroke="currentColor"
              stroke-width="2"
            >
              <path
                stroke-linecap="round"
                stroke-linejoin="round"
                d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z"
              />
            </svg>
          </span>

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

        <div class="mt-4 flex justify-between">
          <a
            href="#"
            class="text-sm text-gray-200 hover:underline"
            @click="() => switchAuthForm()"
          >
            Besitzt du noch keinen Account?
          </a>

<<<<<<< HEAD
          <a href="#" class="text-sm text-gray-200 hover:underline">
=======
          <a href="/restore" class="text-sm text-gray-200 hover:underline">
>>>>>>> dev
            Passwort vergessen?
          </a>
        </div>
      </form>
    </div>
  </div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const SWITCH_AUTH_PAGE = useState("toggleAuthPage");
const isLoggedIn = useState("isLoggedIn");
const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();
const SNACKBAR = useSnackbar();

APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

if (isLoggedIn.value) {
  navigateTo("/dashboard");
}

const INPUT = reactive({
  mail: "",
  password: "",
});
const INPUT_ERRORS = ref(false);

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

const switchAuthForm = () => {
  SWITCH_AUTH_PAGE.value = !SWITCH_AUTH_PAGE.value;
};

const handleInputChange = () => {
  INPUT_ERRORS.value = !(INPUT.mail && INPUT.password);

  if (!INPUT_ERRORS.value) {
    login(INPUT.mail, INPUT.password);
  }
};
</script>
