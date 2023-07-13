<template>
  <div>
    <div class="min-h-screen h-full bg-dark flex justify-center items-center">
      <Identification />
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
