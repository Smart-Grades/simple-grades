<template>
  <div>
    <div class="min-h-screen h-full bg-dark flex justify-center items-center">
      <Identification />
    </div>
  </div>
</template>

<script setup>
const isLoggedIn = useState("isLoggedIn");

if (!isLoggedIn.value) {
  await navigateTo("/auth");
}
</script>
