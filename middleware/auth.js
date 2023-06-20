import { Account, Client } from "appwrite";

export default defineNuxtRouteMiddleware(async (to) => {
  const APP_CLIENT = new Client();
  const APP_ACCOUNT = new Account(APP_CLIENT);
  const RUNTIME_CONFIG = useRuntimeConfig();

  APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
    RUNTIME_CONFIG.public.appwriteProject
  );

  try {
    const RES = await APP_ACCOUNT.get();
    if (!(RES.status && RES.emailVerification)) {
      if (to.path !== "/auth") {
        return navigateTo("/auth");
      }
    }
  } catch (error) {
    if (to.path !== "/auth") {
      return navigateTo("/auth");
    }
  }
});
