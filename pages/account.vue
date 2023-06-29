<template>
  <div class="h-full bg-dark">
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
const isLoggedIn = useState("isLoggedIn");

if (!isLoggedIn.value) {
  // await navigateTo("/auth");
}
</script>

