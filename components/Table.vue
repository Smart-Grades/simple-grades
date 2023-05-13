<template>
  <div class="px-8 mb-8">
    <!-- TABLE -->
    <div class="">
      <div class="space-y-3">
        <div class="flex items-center">
          <span class="absolute">
            <img src="/assets/img/book.svg" class="w-6 h-6 mx-3" alt="">
          </span>

          <input class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Studienfach" type="text" readonly>
        </div>
        

        <div class="flex justify-between gap-4">
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Credits" type="text" readonly>
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Note" type="text">
          <input class="block w-full py-3 border rounded-lg bg-transparent text-center text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Gewichtung" type="text" readonly>
        </div>
      </div>
    </div>
  </div>
</template>