<template>
  <div class="px-8 mb-8">
    <!-- TABLE -->
    <div class="md:mt-16">
      <div
        class="space-y-3 md:space-y-0 md:flex md:justify-center md:gap-10 lg:gap-16"
      >
        <div class="flex items-center">
          <span class="absolute">
            <img src="/assets/img/book.svg" class="w-6 h-6 mx-3" alt="" />
          </span>

          <input
            :value="course"
            class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Studienfach"
            type="text"
            @blur="$emit('update:course', $event.target.value)"
            @input="shouldReset = false"
          />
        </div>

        <div
          class="flex justify-between items-center gap-4 md:gap-10 lg:gap-16"
        >
          <input
            :value="credits"
            class="block w-full py-3 border rounded-lg bg-transparent text-center text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Credits"
            type="text"
            :readonly="id === 'new'"
            @blur="$emit('update:credits', $event.target.value)"
          />
          <span class="font-main font-bold text-white text-2xl mt-2">*</span>
          <input
            :value="grade"
            class="block w-full py-3 border rounded-lg bg-transparent text-center text-white font-bold border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
            placeholder="Note"
            type="number"
            step="0.1"
            :readonly="id === 'new'"
            @blur="$emit('update:grade', $event.target.value)"
          />
          <span class="font-main font-bold text-white text-2xl">=</span>
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
