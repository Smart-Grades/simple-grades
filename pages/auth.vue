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

// This code initializes a client and an account for the application.
const APP_CLIENT = new Client();
const APP_ACCOUNT = new Account(APP_CLIENT);
const RUNTIME_CONFIG = useRuntimeConfig();

// Connect to Appwrite
APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
  RUNTIME_CONFIG.public.appwriteProject
);

// Create a new variable to track the current auth page
const switchAuthPage = useState("toggleAuthPage", () => true);

// Create a new variable to track if the user is logged in
const isLoggedIn = useState("isLoggedIn");

// If the user is logged in, navigate to the dashboard
if (isLoggedIn.value) {
  navigateTo("/dashboard");
} else {
  // Try to fetch the user account from the database
  try {
    const USER = await APP_ACCOUNT.get();

    // If the user has verified their email, log them in and navigate to the dashboard
    if (USER.emailVerification) {
      isLoggedIn.value = true;
      navigateTo("/dashboard");
    }
  } catch (error) {
    console.error(error);
  }
}
</script>
