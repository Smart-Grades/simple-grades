<template>
  <div>
    <div
      class="px-6 py-6 flex justify-between items-center sm:px-12 lg:px-20 2xl:px-24 2xl:py-8"
    >
      <NuxtLink to="/">
        <span class="font-main font-bold text-white sm:text-xl md:text-2xl">
          SmartGrades
        </span>
      </NuxtLink>

      <div class="space-x-3 flex items-center sm:space-x-4 lg:space-x-6">
        <NuxtLink to="/auth">
          <button
            class="font-main font-bold text-2xs shadow-2xl bg-white border w-16 py-1 rounded-md transition ease-out duration-300 hover:scale-105 sm:w-20 sm:py-2 sm:text-xs lg:w-24 lg:py-2.5 lg:text-xs"
          >
            Anmelden
          </button>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>
