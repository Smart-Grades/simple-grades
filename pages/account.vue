<template>
  <div class="h-full bg-dark">
    <AccountNav class="pt-6 px-6" />
    <div class="flex h-screen justify-center items-center">
      <AccountPage />
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  middleware: ["auth"],
});
</script>
