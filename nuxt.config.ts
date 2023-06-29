// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  modules: ["nuxt-snackbar"],
  snackbar: {
    top: true,
    duration: 5000,
  },
  css: ["/public/assets/css/main.css"],
  postcss: {
    plugins: {
      tailwindcss: {},
      autoprefixer: {},
    },
  },
  runtimeConfig: {
    public: {
      url: process.env.CF_PAGES_URL || "http://localhost:3000",
      appwriteEndpoint: process.env.NUXT_PUBLIC_APPWRITE_ENDPOINT || "",
      appwriteProject: process.env.NUXT_PUBLIC_APPWRITE_PROJECT || "",
    },
  },
});
