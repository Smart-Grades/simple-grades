<template>
  <div>
    <div class="h-full bg-dark">
      <AuthLogin v-if="switchAuthPage" />
      <AuthRegister v-if="!switchAuthPage" />
    </div>
  </div>
</template>

<script setup>
import { Account, Client } from "appwrite";

const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();

APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

const switchAuthPage = useState("toggleAuthPage", () => true);
const isLoggedIn = useState("isLoggedIn");
if (isLoggedIn.value) {
  navigateTo("/dashboard");
} else {
  try {
    const USER = await APP_ACCOUNT.get();
    if (USER.emailVerification) {
      isLoggedIn.value = true;
      navigateTo("/dashboard");
    }
  } catch (error) {
    console.error(error);
  }
}
</script>
