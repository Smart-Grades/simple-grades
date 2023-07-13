<template>
  <div class="h-full bg-dark">
    <NuxtLink to="/dashboard">
      <p
        class="text-gray-200 font-main font-bold text-md px-6 pt-6 hover:opacity-70 duration-300"
      >
        &lt; Zurück
      </p>
    </NuxtLink>
    <div class="py-12 flex h-full xl:h-screen justify-center items-center">
      <div
        class="flex flex-col xl:flex-row justify-center items-start gap-16 xl:32"
      >
        <AccountPage />
        <AccountChangeAuth />
      </div>
    </div>
  </div>
</template>

<script setup>
// If the user is not logged in, navigate to the login page
const isLoggedIn = useState("isLoggedIn");

if (!isLoggedIn.value) {
  await navigateTo("/auth");
}
</script>
