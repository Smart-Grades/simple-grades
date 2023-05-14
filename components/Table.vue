<template>
  <div class="px-8 mb-8">
    <!-- TABLE -->
    <div class="md:mt-16">
      <div class="space-y-3 md:space-y-0 md:flex md:justify-center md:gap-10 lg:gap-16">
        <div class="flex items-center">
          <span class="absolute">
            <img src="/assets/img/book.svg" class="w-6 h-6 mx-3" alt="">
          </span>

          <input class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Studienfach" type="text" readonly>
        </div>
        

        <div class="flex justify-between items-center gap-4 md:gap-10 lg:gap-16">
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Credits" type="text" readonly>
          <span class="font-main font-bold text-white text-2xl mt-2">*</span>
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Note" type="text">
          <span class="font-main font-bold text-white text-2xl">=</span>
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Wertung" type="text" readonly>
        </div>
      </div>
    </div>
  </div>
</template>