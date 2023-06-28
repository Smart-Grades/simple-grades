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
          class="w-12 h-12 text-white hover:scale-110 cursor-pointer duration-300 ease-out-in"
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
          <p class="text-sm text-white font-semibold mb-1">Universität</p>
          <p class="border-b-2 w-1/3"></p>
        </div>

        <div class="">
          <!-- INPUT FIELD UNI -->
          <div class="relative flex items-center">
            <span class="absolute px-3.5 mb-1.5 ml-1 scale-150"> 🏫 </span>

            <input
              id="searchInputUni"
              v-model="selectedUni.name"
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Deine Universität"
            />

            <datalist>
              <option
                v-for="option in filteredUnis"
                :key="option.$id"
                :value="option.name"
                @click="() => selectUni(option)"
              >
                {{ option.name }}
              </option>
            </datalist>
          </div>

          <!-- SEARCH LIST UNI -->
          <ul
            v-if="filteredUnis.length > 0"
            class="mt-2 block w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-300"
          >
            <li
              v-for="option in filteredUnis"
              :key="option.$id"
              @click="selectUni(option)"
            >
              {{ option.name }}
            </li>
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
            <span class="absolute px-3.5 scale-150 ml-1"> 📖 </span>

            <input
              id="searchInputMajor"
              v-model="majorInput.name"
              type="text"
              class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
              placeholder="Dein Studiengang"
            />
          </div>

          <!-- SEARCH LIST MAJOR -->
          <ul
            v-if="filteredMajor.length > 0"
            id="myMajorList"
            class="mt-2 w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-300"
          >
            <li
              v-for="option in filteredMajor"
              :key="option.$id"
              @click="selectMajor(option)"
            >
              {{ option.name }}
            </li>
          </ul>
        </div>
      </div>
    </div>

    <div class="mt-8">
      <button
        class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
        @click="addMajorToUser()"
      >
        Loslegen
      </button>
    </div>
  </div>
</template>

<script>
import { Account, Client, Databases, ID, Query } from "appwrite";
import { onMounted, reactive } from "vue";

export default {
  setup() {
    const APP_CLIENT = new Client();
    const APP_ACCOUNT = new Account(APP_CLIENT);
    const RUNTIME_CONFIG = useRuntimeConfig();
    const SNACKBAR = useSnackbar();

    APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
      RUNTIME_CONFIG.public.appwriteProject
    );

    APP_ACCOUNT.getPrefs()
      .then(
        async (res) => {
          if ("introduction" in res && res.introduction === true) {
            await navigateTo("/dashboard");
          }
        },
        (error) => {
          console.error(error);
        }
      )
      .catch((error) => {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      });

    const data = reactive({
      selectedUni: {
        name: "",
        token: "",
        $id: "",
      },
      unis: [],
      studyCourses: [],
      majorInput: {
        name: "",
        $id: "",
      },
    });

    const filteredUnis = computed(() => {
      const search = data.selectedUni.name.toUpperCase().trim();
      return data.unis
        .filter((option) => {
          return (
            option.name.toUpperCase().includes(search) ||
            option.token.toUpperCase().includes(search)
          );
        })
        .slice(0, 5);
    });

    const filteredMajor = computed(() => {
      const search = data.majorInput.name.toUpperCase().trim();
      return data.studyCourses
        .filter((option) => {
          return option.name.toUpperCase().includes(search);
        })
        .slice(0, 5);
    });

    const selectUni = (option) => {
      data.selectedUni = option;
      loadStudyCourses(option.$id);
      data.unis = [];
    };

    const selectMajor = (option) => {
      data.majorInput = option;
      data.studyCourses = [];
    };

    const listUnis = async () => {
      const APP_DATABASE = new Databases(APP_CLIENT);

      try {
        const RES = await APP_DATABASE.listDocuments("uni_data", "uni");

        data.unis = RES.documents.map((doc) => ({
          name: doc.name,
          token: doc.token,
          $id: doc.$id,
        }));
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    const loadStudyCourses = async (uniId) => {
      const APP_DATABASE = new Databases(APP_CLIENT);

      try {
        const RES = await APP_DATABASE.listDocuments("uni_data", "major_data", [
          Query.limit(100),
          Query.sort("name", "asc"),
          Query.equal("uni_id", uniId),
        ]);

        data.studyCourses = RES.documents.map((doc) => ({
          name: doc.name,
          $id: doc.$id,
        }));
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    const addMajorToUser = async () => {
      if (data.selectedUni.$id === "" || data.majorInput.$id === "") {
        SNACKBAR.add({
          message: "Bitte wähle eine Uni und einen Studiengang aus.",
          type: "error",
        });
        return;
      }

      const APP_DATABASE = new Databases(APP_CLIENT);

      const PRE_COURSES_DATA = await APP_DATABASE.listDocuments(
        "uni_data",
        "course_data",
        [Query.limit(100), Query.equal("major_id", data.majorInput.$id)]
      );

      try {
        const USER = await APP_ACCOUNT.get();
        for (const C of PRE_COURSES_DATA.documents) {
          await APP_DATABASE.createDocument(
            "user_data",
            "user_courses",
            ID.unique(),
            {
              user_id: USER.$id,
              name: C.name,
              ects: C.ects,
            }
          );
        }
        await APP_ACCOUNT.updatePrefs({
          introduction: true,
        });
        await navigateTo("/dashboard");
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    onMounted(async () => {
      await listUnis();
    });

    return {
      ...toRefs(data),
      filteredUnis,
      filteredMajor,
      selectUni,
      selectMajor,
      addMajorToUser,
    };
  },
};
</script>
