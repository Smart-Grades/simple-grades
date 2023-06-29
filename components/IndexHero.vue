<template>
  <div>
    <!-- WebPage-Text -->
    <div class="mb-4 px-6 text-center sm:mb-8 sm:px-12 2xl:mb-12">
      <h1
        class="mb-1 font-fancy font-bold text-white text-4xl leading-10 sm:mb-4 sm:text-6xl sm:leading-[4.5rem] md:mb-4 md:text-7xl md:leading-[5rem] lg:mb-8 lg:text-9xl lg:leading-[7rem]"
      >
        Der perfekte Überblick <br />für die Uni.
      </h1>
      <h5
        class="font-main text-gray-200 text-base sm:text-xl md:text-2xl"
      >
        Track deine Noten, so einfach wie noch nie!
      </h5>
    </div>
    <!-- GetStarted-Button -->
    <div class="flex justify-center">
      <NuxtLink to="/auth">
        <button
          class="font-display font-semibold text-sm text-white shadow-2xl bg-fom py-2 px-6 rounded-md transition ease-out duration-300 hover:scale-105 sm:py-3 sm:px-7 sm:text-base lg:text-lg"
        >
          Loslegen
        </button>
      </NuxtLink>
    </div>
    <div class="flex justify-center">
      <hr class="mt-10 w-5/6 lg:mt-14 2xl:mt-16" />
    </div>
  </div>
</template>
