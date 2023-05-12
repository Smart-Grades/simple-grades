<template>
  <div>
    <div class="">
      <div class="mb-6 flex justify-center">
        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12 text-white">
            <path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5" />
        </svg>
      </div>

      <div class="w-80 md:w-96 lg:w-[500px]">
        <div class="">
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">Universität</p>
            <p class="border-b-2 w-1/3"></p>
          </div>

          <div class="relative flex items-center">
              <span class="absolute">
                <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 24 24" class="w-6 h-6 mx-3 fill-gray-500">
                  <path d="M20,18V17H19V10h1V7L12,2.08,4,7v3H5v7H4.2v1H3v3H21V18ZM12,4l3.14,2H8.86Zm6,15H6a.5.5,0,0,1,0-1H18a.5.5,0,0,1,0,1ZM7,17V11H8v6Zm3,0V11h1v6Zm3,0V11h1v6Zm3,0V11h1v6Zm2-8H6.5a.5.5,0,0,1,0-1H18a.5.5,0,0,1,0,1Z"/></svg>
              </span>

              <input type="text" class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Deine Universität">
          </div>
        </div>

        <div class="mt-4">
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">Studiengang</p>
            <p class="border-b-2 w-1/3"></p>
          </div>

          <div class="relative flex items-center">
              <span class="absolute">
                <img src="/assets/img/book.svg" class="w-6 h-6 mx-3" alt="">
              </span>

              <input type="text" class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Dein Studiengang">
          </div>
        </div>
      </div>

      <div class="mt-8">
          <button class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
              Get Started
          </button>
      </div>
    </div>
  </div>
</template>