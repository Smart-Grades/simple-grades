<template>
  <div>
    <div class="h-full bg-dark">
      <AuthLogin v-if="switchAuthPage" />
      <AuthRegister v-if="!switchAuthPage" />
    </div>
  </div>
</template>

<script setup>
const switchAuthPage = useState("toggleAuthPage", () => true);
const isLoggedIn = useState("isLoggedIn");
if (isLoggedIn.value) {
  navigateTo("/dashboard");
}
</script>
