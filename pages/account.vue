<template>
  <div class="h-full bg-dark">
    <div class="flex h-screen justify-center items-center">
      <AccountPage />
    </div>
  </div>
</template>

<script setup>
const isLoggedIn = useState("isLoggedIn");

if (!isLoggedIn.value) {
  await navigateTo("/auth");
}
</script>
