<template>
  <div>
    <div class=""></div>
    <div class="mb-2">
      <NuxtLink to="/dashboard">
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
        <div class="">
          <div class="mb-3">
            <p class="text-sm text-white font-semibold mb-1">
              Neue Universität
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="">
            <!-- INPUT FIELD UNI -->
            <div class="relative flex items-center">
              <span class="absolute px-3.5 mb-1.5 scale-150"> 🏫 </span>

              <input
                id="searchInputUni"
                v-model="selectedUni.name"
                type="text"
                class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Deine Universität"
              />
            </div>

            <!-- SEARCH LIST Uni -->
            <ul
              v-if="filteredUnis.length > 0"
              id="myMajorList"
              class="mt-2 block w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-200"
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
            <p class="text-sm text-white font-semibold mb-1">
              Neuer Studiengang
            </p>
            <p class="border-b-2 w-1/2"></p>
          </div>

          <div class="">
            <!-- INPUT FIELD MAJOR -->
            <div class="relative flex items-center">
              <span class="absolute px-3.5 mb-1.5 scale-150"> 📖 </span>

              <input
                id="searchInputMajor"
                v-model="selectedMajor.name"
                type="text"
                class="block w-full py-3 border rounded-lg px-11 bg-transparent text-white border-white focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40"
                placeholder="Dein Studiengang"
              />
            </div>

            <!-- SEARCH LIST MAJOR -->
            <ul
              v-if="filteredMajor.length > 0"
              id="myMajorList"
              class="mt-2 block w-full py-3 border border-gray-600 rounded-lg px-4 bg-transparent text-gray-200"
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
    </div>
    <div class="mt-8">
      <button
        class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50"
        @click="showConfirmModal = true"
      >
        Neuladen
      </button>
    </div>
    <AccountConfirmModal
      v-show="showConfirmModal"
      :uni="selectedUni"
      :major="selectedMajor"
      @accept="doChange(true)"
      @decline="doChange(false)"
    />
  </div>
</template>

<script>
import { Account, Client, Databases, ID, Query } from "appwrite";
import { onMounted, reactive } from "vue";
import AccountConfirmModal from "@/components/AccountConfirmModal.vue";

export default {
  components: {
    AccountConfirmModal,
  },
  setup() {
    const APP_CLIENT = new Client();
    const APP_ACCOUNT = new Account(APP_CLIENT);
    const APP_DATABASE = new Databases(APP_CLIENT);
    const RUNTIME_CONFIG = useRuntimeConfig();
    const SNACKBAR = useSnackbar();

    APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
      RUNTIME_CONFIG.public.appwriteProject
    );

    const data = reactive({
      selectedUni: {
        name: "",
        token: "",
        $id: "",
      },
      unis: [],
      studyCourses: [],
      selectedMajor: {
        name: "",
        $id: "",
      },
      showConfirmModal: false,
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
      const search = data.selectedMajor.name.toUpperCase().trim();
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
      data.selectedMajor = option;
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
          Query.orderAsc("name"),
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

    const getUserCourses = async (userId) => {
      try {
        const courses = await APP_DATABASE.listDocuments(
          "user_data",
          "user_courses",
          [Query.limit(100), Query.equal("user_id", userId)]
        );

        return courses.documents;
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    const deleteUserCourses = async (userId, courses) => {
      try {
        const promises = courses.map((course) => {
          return APP_DATABASE.deleteDocument(
            "user_data",
            "user_courses",
            course.$id
          );
        });

        await Promise.all(promises);
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    const changeUserCourse = async () => {
      const USER = await APP_ACCOUNT.get();

      const courses = await getUserCourses(USER.$id);
      await deleteUserCourses(USER.$id, courses);
      await addMajorToUser();
    };

    const addMajorToUser = async () => {
      if (data.selectedUni.$id === "" || data.selectedMajor.$id === "") {
        SNACKBAR.add({
          message: "Bitte wähle eine Uni und einen Studiengang aus.",
          type: "error",
        });
        return;
      }
      const PRE_COURSES_DATA = await APP_DATABASE.listDocuments(
        "uni_data",
        "course_data",
        [Query.limit(100), Query.equal("major_id", data.selectedMajor.$id)]
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
        await navigateTo("/dashboard");
      } catch (error) {
        console.error(error);
        SNACKBAR.add({
          message: error.message,
          type: "error",
        });
      }
    };

    const doChange = async (accept) => {
      if (accept) {
        changeUserCourse();
      } else {
        data.selectedUni = {
          name: "",
          token: "",
          $id: "",
        };
        data.selectedMajor = {
          name: "",
          $id: "",
        };
        data.unis = [];
        data.studyCourses = [];
        await listUnis();
      }
      data.showConfirmModal = false;
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
      changeUserCourse,
      doChange,
    };
  },
};
</script>
