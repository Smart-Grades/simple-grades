<template>
  <NuxtLayout>
    <NuxtPage />
  </NuxtLayout>
  <NuxtSnackbar />
</template>

<script setup>
useState("isLoggedIn", () => false);
</script>
