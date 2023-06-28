<template>
  <div class="h-full bg-dark">
    <div class="flex h-screen justify-center items-center">
      <div class="flex justify-center items-start gap-32">
        <AccountPage />
        <AccountChangeAuth />
      </div>
    </div>
  </div>
</template>

<script setup>
const isLoggedIn = useState("isLoggedIn");

if (!isLoggedIn.value) {
  await navigateTo("/auth");
}
</script>

