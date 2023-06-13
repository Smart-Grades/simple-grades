<template>
  <div>
    <div class="mb-6 flex justify-center">
      <NuxtLink to="/">
      <svg
        xmlns="http://www.w3.org/2000/svg"
        fill="none"
        viewBox="0 0 24 24"
        stroke-width="1.5"
        stroke="currentColor"
        class="w-12 h-12 text-white"
      >
        <path
          stroke-linecap="round"
          stroke-linejoin="round"
          d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5"
        />
      </svg>
    </NuxtLink>
    </div>

    <div class="w-80 md:w-96 lg:w-[500px]">
      <div class="">
        <div class="mb-3">
          <p class="text-sm text-gray-300 font-semibold mb-1">Universität</p>
          <p class="border-b-2 w-1/3"></p>
        </div>

        <div class="">
          <!-- INPUT FIELD UNI -->
          <div class="relative flex items-center">
            <span class="absolute px-3.5 mb-1.5 scale-150"> 🏫 </span>

            <input   
              id="searchInputUni"
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Deine Universität"
              v-model="uniInput"
              @keyup="searchList('searchInputUni', 'myUniList')"
            />
          </div>
          
          <!-- SEARCH LIST MAJOR -->
          <ul
            id="myUniList"
            class="mt-2 hidden w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-300"
          >
            <li><a @click="() => takeUni('FOM')" href="#">🎓 FOM</a></li>
          </ul>
        </div>
      </div>

      <div class="mt-4">
        <div class="mb-3">
          <p class="text-sm text-gray-300 font-semibold mb-1">Studiengang</p>
          <p class="border-b-2 w-1/3"></p>
        </div>

        <div class="">
          <!-- INPUT FIELD MAJOR -->
          <div class="relative flex items-center">
            <span class="absolute px-3.5 mb-1.5 scale-150"> 📖 </span>

            <input
              id="searchInputMajor"
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Dein Studiengang"
              @keyup="searchList('searchInputMajor', 'myMajorList')"
              v-model="majorInput"
            />
          </div>

          <!-- SEARCH LIST MAJOR -->
          <ul
            id="myMajorList"
            class="mt-2 hidden w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-300"
          >
            <li><a @click="() => takeMajor('Wirtschaftsinformatik')" href="#">🎓 Wirtschaftsinformatik</a></li>
            <li><a @click="() => takeMajor('BWL')" href="#">🎓 Bwl</a></li>
            <li><a @click="() => takeMajor('VWL')" href="#">🎓 Vwl</a></li>
            <li><a @click="() => takeMajor('Computer Engineering')" href="#">🎓 Computer Engineering</a></li>
          </ul>
        </div>
      </div>
    </div>

    <div class="mt-8">
      <button
        class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
      >
        Loslegen
      </button>
    </div>
  </div>
</template>


<script setup>
  const uniInput = ref("")
  const majorInput = ref("")

  function takeUni(university) {
      uniInput.value = university
      document.getElementById("myUniList").style.display = "none";
  }

  function takeMajor(major) {
      majorInput.value = major
      document.getElementById("myMajorList").style.display = "none";
  }


  function searchList(inputElement, listElement) {
      // Declare variables
      var input, filter, ul, li, a, i;
      input = document.getElementById(inputElement);
      filter = input.value.toUpperCase();
      ul = document.getElementById(listElement);
      li = ul.getElementsByTagName('li');

      if(input.value.length == 0){
          ul.style.display = "none";
          return;
      }else{
          ul.style.display = "block";
      }

      let count = 0;

      // Loop through all list items, and hide those who don't match the search query
      for (i = 0; i < li.length; i++) {
          a = li[i].getElementsByTagName("a")[0];
          if (a.innerHTML.toUpperCase().indexOf(filter) > -1) {
              li[i].style.display = "block";
              count++;
          } else {
              li[i].style.display = "none";
          }
      }

      if (count == 0) {
        ul.style.display = "none"
      } else {
        ul.style.display = "block"
      }
  }
</script>
