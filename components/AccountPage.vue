<template>
  <div>
    <!-- MAIN -->
    <div class="">
      <div class="mb-6 flex-col items-center justify-center">
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          Neue Uni?
        </p>
        <p class="font-main text-xl text-white font-bold cursor-pointer">
          Neues Studium?
        </p>
      </div>

      <div class="w-80 md:w-96 lg:w-[500px]">
        <div>
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">
              Neue Universität
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="relative flex items-center">
            <span class="absolute">
              <svg
                xmlns="http://www.w3.org/2000/svg"
                viewBox="0 0 24 24"
                class="w-6 h-6 mx-3 fill-gray-500"
              >
                <path
                  d="M20,18V17H19V10h1V7L12,2.08,4,7v3H5v7H4.2v1H3v3H21V18ZM12,4l3.14,2H8.86Zm6,15H6a.5.5,0,0,1,0-1H18a.5.5,0,0,1,0,1ZM7,17V11H8v6Zm3,0V11h1v6Zm3,0V11h1v6Zm3,0V11h1v6Zm2-8H6.5a.5.5,0,0,1,0-1H18a.5.5,0,0,1,0,1Z"
                />
              </svg>
            </span>

            <input
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Deine neue Universität"
            />
          </div>
        </div>

        <div class="mt-4">
          <div class="mb-3">
            <p class="text-sm text-gray-300 font-semibold mb-1">
              Neuer Studiengang
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="relative flex items-center">
            <span class="absolute">
              <img src="/assets/img/book.svg" class="w-6 h-6 mx-3" alt="" />
            </span>

            <input
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Dein neuer Studiengang"
            />
          </div>
        </div>
      </div>

      <div class="mt-8">
        <button
          class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
        >
          Get Started
        </button>
      </div>
    </div>
  </div>
</template>
