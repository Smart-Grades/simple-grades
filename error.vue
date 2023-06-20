<template>
    <div class="px-4 flex justify-center items-center h-screen bg-dark">
        <div class="flex flex-col">
            <h1 class="text-lg text-gray-200">Error</h1>
            <h2 class="font-bold text-2xl text-gray-200">Wir können diese Seite nicht finden!</h2>
            <p class="text-sm text-gray-200">Die Seite, die Sie suchen, existiert leider nicht oder wurde verschoben</p>

            <div class="mt-4">
                <NuxtLink to="/">
                    <button class="bg-fom text-white text-sm py-2 px-3 rounded-lg hover:scale-105 duration-300 ease-out-in">
                        Zur Startseite
                    </button>
                </NuxtLink>
            </div>
        </div>
    </div>
  </template>
  
  <script>
    export default {
      props: ['error'],
      layout: 'error' // you can set a custom layout for the error page
    }
  </script>