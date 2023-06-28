<template>
  <transition name="modal-fade">
    <div
      class="fixed top-0 bottom-0 left-0 right-0 flex justify-center items-center bg-[#000000da]"
    >
      <div
        class="text-white text-center bg-dark h-fit w-[500px] py-[60px] px-8 rounded-3xl"
      >
        <h6 class="text-2xl mb-4">Bist du dir sicher?</h6>
        <p>
          Wenn du deinen Studiengang änderst, werden alle deine bisherigen Daten
          gelöscht.
        </p>

        <div class="flex justify-center">
          <div class="px-2">
            <button
              class="bg-red-500 hover:bg-red-700 text-white font-bold py-2 px-4 rounded mt-4 my-4"
              @click="$emit('accept')"
            >
              Ändern
            </button>
          </div>
          <div class="px-2">
            <button
              class="bg-gray-500 hover:bg-gray-700 text-white font-bold py-2 px-4 rounded mt-4 my-4"
              @click="$emit('decline')"
            >
              Abbrechen
            </button>
          </div>
        </div>
      </div>
    </div>
  </transition>
</template>
