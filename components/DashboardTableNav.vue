<template>
  <div class="px-5 md:px-12 pt-8 mb-8">
    <!-- HEADER -->
    <div class="flex justify-between items-center">
      <NuxtLink to="/">
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          SmartGrades
        </p>
      </NuxtLink>

      <div class="flex space-x-2 items-center">
        <NuxtLink to="/account">
          <button
            class="font-main font-bold text-2xs shadow-2xl bg-fom border border-fom text-white w-20 sm:w-24 py-1 rounded-md transition ease-out duration-300 hover:scale-105 sm:py-2 md:w-24 sm:text-xs lg:w-28 lg:py-2.5 lg:text-xs"
          >
            Daten ändern
          </button>
        </NuxtLink>

        <NuxtLink to="/logout">
          <button
            class="font-main font-bold text-2xs shadow-2xl bg-white w-16 py-1 rounded-md transition ease-out duration-300 hover:scale-105 sm:w-20 sm:py-2 sm:text-xs lg:w-28 lg:py-2.5 lg:text-xs"
          >
            Abmelden
          </button>
        </NuxtLink>
      </div>
    </div>
  </div>
</template>
