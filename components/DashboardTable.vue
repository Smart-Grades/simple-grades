<template>
  <div class="px-8 mb-8">
    <!-- TABLE -->
    <div class="mt-16 md:mt-16 flex items-center space-x-8 justify-center">
      <div
        class="space-y-10 lg:space-y-0 lg:flex md:justify-center md:gap-10 lg:gap-16"
      >
        <div class="flex items-center">
          <span class="absolute scale-150 px-4"> 📖 </span>

          <div class="w-full">
            <input
              :value="course"
              class="block w-full lg:w-[28rem] xl:w-[38rem] py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Studienfach"
              type="text"
              @blur="$emit('update:course', $event.target.value)"
              @input="shouldReset = false"
            />
          </div>
        </div>

        <div class="lg:flex lg:items-center lg:space-x-8">
          <div
            class="flex justify-between items-center gap-4 md:gap-10 lg:gap-16"
          >
            <div>
              <input
                :value="credits"
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Credits"
                type="text"
                :readonly="id === 'new'"
                @blur="$emit('update:credits', $event.target.value)"
              />
            </div>

            <div>
              <input
                :value="grade"
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white font-bold border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Note"
                type="number"
                step="0.1"
                :readonly="id === 'new'"
                @blur="$emit('update:grade', $event.target.value)"
              />
            </div>

            <span class="font-main font-bold text-white text-2xl">|</span>

            <div>
              <input
                :value="((credits / totalCredits) * 100).toFixed(2)"
                class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Wertung"
                type="text"
                readonly
              />
            </div>
          </div>
        </div>
      </div>

      <svg
        v-if="id !== 'new'"
        version="1.0"
        xmlns="http://www.w3.org/2000/svg"
        class="w-8 h-8 fill-gray-200 hover:fill-red-800 cursor-pointer hover:scale-125 active:scale-110 duration-300 ease-out-in"
        viewBox="0 0 1280.000000 1280.000000"
        preserveAspectRatio="xMidYMid meet"
        @click="$emit('delete')"
      >
        <g
          transform="translate(0.000000,1280.000000) scale(0.100000,-0.100000)"
          stroke="none"
        >
          <path
            d="M3137 9659 l-537 -539 1360 -1360 1360 -1360 -1360 -1360 -1360
-1360 540 -540 540 -540 1360 1360 1360 1360 1360 -1360 1360 -1360 540 540
540 540 -1360 1360 -1360 1360 1360 1360 1360 1360 -540 540 -540 540 -1360
-1360 -1360 -1360 -1360 1360 c-748 748 -1361 1360 -1362 1359 -2 0 -245 -243
-541 -540z"
          />
        </g>
      </svg>
      <div v-if="id === 'new'" class="w-8"></div>
    </div>
  </div>
</template>

<script>
export default {
  props: {
    id: {
      type: String,
      required: true,
    },
    course: {
      type: String,
      required: false,
    },
    credits: {
      type: Number,
      required: false,
    },
    grade: {
      type: Number,
      required: false,
    },
    totalCredits: {
      type: Number,
      required: false,
    },
    clearValues: {
      type: Boolean,
      required: false,
    },
  },
  data() {
    return {
      shouldReset: false,
    };
  },
  watch: {
    clearValues(newValue) {
      if (newValue) {
        this.shouldReset = true;
      }
    },
  },
};
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
