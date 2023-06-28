<template>
  <div class="px-8 mb-8">
    <!-- TABLE -->
    <div class="mt-16 md:mt-16 flex items-center space-x-8 justify-center">
      <div
        class="space-y-10 lg:space-y-0 lg:flex md:justify-center md:gap-10 lg:gap-16"
      >
        <div class="flex items-center">
          <span class="absolute scale-150 px-4">
            📖
          </span>

          <FloatLabel class="w-full">
            <input
              class="block w-full lg:w-[28rem] xl:w-[38rem] py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Studienfach"
              type="text"
              readonly
            />
          </FloatLabel>
        </div>

        <div class="lg:flex lg:items-center lg:space-x-8">
          <div
            class="flex justify-between items-center gap-4 md:gap-10 lg:gap-16"
          >
            <FloatLabel>
              <input
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Credits"
                type="text"
                readonly
              />
            </FloatLabel>

            <FloatLabel>
              <input
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white font-bold border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Note"
                type="number"
                step="0.1"
              />
            </FloatLabel>

            <span class="font-main font-bold text-white text-2xl">|</span>

            <FloatLabel>
              <input
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Wertung"
                type="text"
                readonly
              />
            </FloatLabel>
          </div>
        </div>
      </div>

      <span class="block cursor-pointer hover:scale-150 active:scale-110 duration-300 ease-out-in">
            ❌
      </span>
    </div>
  </div>
</template>

<script>
  import FloatLabel from 'vue-float-label/components/FloatLabel'
  
  export default {
    components: {
      FloatLabel
    }
  }
</script>

<style>
.vfl-label {
  text-transform: uppercase;
}
 
.vfl-label-on-input {
  top: -1.5rem;
}
 
.vfl-label-on-focus {
  color: #ffffff;
}

</style>
