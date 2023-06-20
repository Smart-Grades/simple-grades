<template>
  <div>
    <div class="h-full bg-dark">
      <DashboardTableNav />
      <DashboardTable />
      <DashboardTable />
      <DashboardTable />
      <DashboardTable />
      <DashboardTable />
      <DashboardTable />
      <DashboardTable />
      <DashboardTableResult />
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  middleware: ["auth"],
});
</script>
