<template>
  <div>
    <div class="">
      <div class="mb-2 -ml-3">
        <NuxtLink to="/">
          <img
            src="/assets/img/logo.png"
            alt=""
            class="w-16 h-16 hover:scale-110 duration-300 cursor-pointer ease-in"
          />
        </NuxtLink>
      </div>

      <!-- MAIN -->
      <div class="">
        <div class="mb-6 flex-col items-center justify-center">
          <p class="font-main text-xl text-white font-bold cursor-pointer">
            Neue Email?
          </p>
          <p class="font-main text-xl text-white font-bold cursor-pointer">
            Neues Passwort?
          </p>
        </div>

        <div class="w-80 md:w-96 lg:w-[500px]">
          <div class="">
            <div class="mb-3">
              <p class="text-sm text-gray-300 font-semibold mb-1">
                Neue Email-Adresse
              </p>
              <p class="border-b-2 w-1/2"></p>
            </div>

            <div class="space-y-4">
              <!-- INPUT FIELD UNI -->
              <div class="relative flex items-center">
                <span class="absolute px-4 scale-150"> 📧 </span>

                <input
                  type="email"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neue Email"
                />
              </div>
            </div>
          </div>

          <div class="mt-4">
            <div class="mb-3">
              <p class="text-sm text-gray-300 font-semibold mb-1">
                Neues Passwort
              </p>
              <p class="border-b-2 w-1/2"></p>
            </div>

            <div class="space-y-4">
              <!-- INPUT FIELD MAJOR -->
              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Aktuelles Passwort"
                />
              </div>

              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neues Passwort"
                />
              </div>

              <div class="relative flex items-center">
                <span class="absolute px-4 mb-1 scale-150"> 🔒 </span>

                <input
                  id="searchInputMajor"
                  type="password"
                  class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                  placeholder="Neues Passwort wiederholen"
                />
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>

    <div class="mt-8">
      <button
        class="w-full px-6 py-3 text-sm font-medium text-white capitalize duration-500 ease-out-in transform bg-fom rounded-lg hover:opacity-80"
        @click="showConfirmModal = true"
      >
        Neuladen
      </button>
    </div>
  </div>
</template>

