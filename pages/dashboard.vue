<template>
  <div>
    <div class="h-full bg-dark">
      <DashboardTableNav />
      <div v-for="course in data.courses" :key="course.$id">
        <DashboardTable
          :id="course.$id"
          :course="course.name"
          :credits="course.ects"
          :grade="course.grade"
          :totalCredits="data.totalCredits"
          @update:course="updateCourse(course.$id, 'name', $event)"
          @update:credits="updateCourse(course.$id, 'ects', parseFloat($event))"
          @update:grade="updateCourse(course.$id, 'grade', parseFloat($event))"
        />
      </div>
      <DashboardTable
        v-if="data.courses.length < 100"
        :id="newCourse.$id"
        :course="newCourse.name"
        :credits="newCourse.ects"
        :grade="newCourse.grade"
        :totalCredits="data.totalCredits"
        :clearValues="clearValues"
        @update:course="updateCourse(newCourse.$id, 'name', $event)"
        @update:credits="
          updateCourse(newCourse.$id, 'ects', parseFloat($event))
        "
        @update:grade="updateCourse(newCourse.$id, 'grade', parseFloat($event))"
      />
      <DashboardTableResult
        :totalCredits="data.totalCredits"
        :totalGrade="data.totalGrade"
        @exportCsv="exportCourses()"
      />
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
    const isLoggedIn = useState("isLoggedIn");
    const SNACKBAR = useSnackbar();

    APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
      RUNTIME_CONFIG.public.appwriteProject
    );

    if (!isLoggedIn.value) {
      return navigateTo("/auth");
    }

    const data = reactive({
      courses: [],
      totalCredits: 0,
      totalGrade: 0,
    });

    const newCourse = reactive({
      $id: "new",
      name: "",
      ects: null,
      grade: null,
    });

    const clearValues = ref(false);

    APP_ACCOUNT.getPrefs()
      .then(
        async (res) => {
          if (!("introduction" in res) || res.introduction === false) {
            await navigateTo("/ident");
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

    const getUserCourses = async () => {
      const APP_DATABASE = new Databases(APP_CLIENT);
      const USER = await APP_ACCOUNT.get();
      const courses = await APP_DATABASE.listDocuments(
        "user_data",
        "user_courses",
        [Query.limit(100), Query.search("user_id", [USER.$id])]
      );

      let totalCredits = 0;
      let totalGrade = 0;
      let validCredits = 0;

      console.log(courses.documents);
      for (const course of courses.documents) {
        totalCredits += course.ects;
        if (course.grade > 0 && course.ects > 0) {
          totalGrade += course.grade * course.ects;
          validCredits += course.ects;
        }
      }

      data.totalCredits = totalCredits;
      data.totalGrade = totalGrade / validCredits;
      data.courses = courses.documents;

      clearValues.value = false;
      newCourse.name = "";
      newCourse.ects = null;
      newCourse.grade = null;
    };

    const updateCourse = async (id, property, value) => {
      if (id === newCourse.$id) {
        if (newCourse[property] === value) {
          return;
        }
        try {
          const APP_DATABASE = new Databases(APP_CLIENT);
          const USER = await APP_ACCOUNT.get();
          const newOne = await APP_DATABASE.createDocument(
            "user_data",
            "user_courses",
            ID.unique(),
            {
              user_id: USER.$id,
              [property]: value,
            }
          );
          console.log(newOne);
          SNACKBAR.add({
            text: "Added course! 🎉",
            type: "success",
          });
          clearValues.value = true;
          await getUserCourses();
        } catch (error) {
          console.error(error);
        }
      } else {
        const course = data.courses.find((course) => course.$id === id);
        if (course[property] === value) {
          return;
        }
        try {
          const APP_DATABASE = new Databases(APP_CLIENT);
          await APP_DATABASE.updateDocument("user_data", "user_courses", id, {
            [property]: value,
          });
          SNACKBAR.add({
            text: "Updated course! 🎉",
            type: "success",
          });
          await getUserCourses();
        } catch (error) {
          console.error(error);
        }
      }
    };

    const exportCourses = () => {
      const csvContent =
        "data:text/csv;charset=utf-8," + encodeURI(generateCsv());
      const link = document.createElement("a");
      link.setAttribute("href", csvContent);
      link.setAttribute("download", "courses.csv");
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    };

    const generateCsv = () => {
      let csv = "\uFEFFCourse,Credits,Grade\n";
      for (const course of data.courses) {
        const name = course.name || ""; // Convert null to empty string
        const credits = course.ects || ""; // Convert null to empty string
        const grade = course.grade || "";
        csv += `${name},${credits},${grade}\n`;
      }
      return csv;
    };

    onMounted(() => {
      getUserCourses();
    });

    return {
      data,
      newCourse,
      clearValues,
      updateCourse,
      exportCourses,
    };
  },
};
</script>
