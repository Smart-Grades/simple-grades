<template>
  <div>
    <div class="h-screen bg-dark flex justify-center items-center">
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
