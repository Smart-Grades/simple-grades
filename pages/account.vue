<template>
  <div class="h-full bg-dark">
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
