<template>
  <div class="px-6 xl:px-20 pb-16">
    <p class="border-t w-full"></p>

    <div
      class="md:flex md:justify-center md:items-center md:space-x-6 lg:space-x-14"
    >
      <div class="mt-8 flex justify-between gap-6 lg:gap-14">
        <input
          :value="totalCredits"
          class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
          placeholder="Credits"
          type="text"
          readonly
        />
        <input
          :value="totalGrade.toFixed(2)"
          class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
          placeholder="Note"
          type="text"
          readonly
        />
      </div>

      <button
        class="mt-4 py-4 w-full bg-fom rounded-lg text-white font-bold cusor-pointer text-sm md:mt-8 md:w-[179px]"
        @click="$emit('exportCsv')"
      >
        Download CSV
      </button>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    totalCredits: {
      type: Number,
      required: false,
    },
    totalGrade: {
      type: Number,
      required: false,
    },
  },
};
</script>
