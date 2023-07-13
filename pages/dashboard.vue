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
          @delete="deleteCourse(course.$id)"
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
    // This code initializes the client, account, and snackbar objects.
    const APP_CLIENT = new Client();
    const APP_ACCOUNT = new Account(APP_CLIENT);
    const RUNTIME_CONFIG = useRuntimeConfig();
    const isLoggedIn = useState("isLoggedIn");
    const SNACKBAR = useSnackbar();

    // Connect to Appwrite
    APP_CLIENT.setEndpoint(RUNTIME_CONFIG.public.appwriteEndpoint).setProject(
      RUNTIME_CONFIG.public.appwriteProject
    );

    // 1. Check if the user is logged in
    if (!isLoggedIn.value) {
      // 2. If not, redirect them to the login page
      return navigateTo("/auth");
    }

    // create reactive data object
    const data = reactive({
      courses: [],
      totalCredits: 0,
      totalGrade: 0,
    });

    // create a new course
    const newCourse = reactive({
      $id: "new",
      name: "",
      ects: null,
      grade: null,
    });

    // Clears the values in the form
    const clearValues = ref(false);

    // Fetch if the user has seen the introduction
    APP_ACCOUNT.getPrefs()
      .then(
        async (res) => {
          // Check if the user has seen the introduction
          if (!("introduction" in res) || res.introduction === false) {
            // Navigate to the introduction if they haven't
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
          text: error.message,
          type: "error",
        });
      });

    /**
     * Fetches the courses from the database
     */
    const getUserCourses = async () => {
      // Create a new instance of the Databases class
      const APP_DATABASE = new Databases(APP_CLIENT);
      // Get the current user
      const USER = await APP_ACCOUNT.get();
      // Get all courses the user is enrolled in
      const courses = await APP_DATABASE.listDocuments(
        "user_data",
        "user_courses",
        [Query.limit(100), Query.search("user_id", [USER.$id])]
      );

      // Declare variables
      let totalCredits = 0;
      let totalGrade = 0;
      let validCredits = 0;

      console.log(courses.documents);
      // iterate over the courses
      for (const course of courses.documents) {
        // add the ects of the current course to the totalCredits
        totalCredits += course.ects;
        // check if the course has a grade
        if (course.grade > 0 && course.ects > 0) {
          // add the grade of the current course multiplied with the ects of the current course to the totalGrade
          totalGrade += course.grade * course.ects;
          // add the ects of the current course to the validCredits
          validCredits += course.ects;
        }
      }

      // Set the default values for the data fields that will be calculated.
      // These values will be overwritten if the user's input is valid.
      data.totalCredits = totalCredits;
      data.totalGrade = totalGrade / validCredits;
      data.courses = courses.documents;

      // Clear the values of the inputs
      clearValues.value = false;

      // Clear the values of the inputs
      newCourse.name = "";
      newCourse.ects = null;
      newCourse.grade = null;
    };

    /**
     * This function updates the course with the given id, property, and value.
     * @param {string} id The id of the course to update
     * @param {string} property The property of the course to update
     * @param {string} value The value to update the course with
     */
    const updateCourse = async (id, property, value) => {
      // Check if the id is the same as the newCourse id
      if (id === newCourse.$id) {
        // Check if the course has the property we are looking for
        if (newCourse[property] === value) {
          return;
        }
        try {
          // Create a new instance of the Databases class
          const APP_DATABASE = new Databases(APP_CLIENT);
          // Get the current user
          const USER = await APP_ACCOUNT.get();
          // Create a new course
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
          // Add a snackbar notification
          SNACKBAR.add({
            text: "Added course! 🎉",
            type: "success",
          });
          // Clear the values of the inputs
          clearValues.value = true;
          // Fetch the courses again
          await getUserCourses();
        } catch (error) {
          console.error(error);
        }
      } else {
        // Find the course with the given id
        const course = data.courses.find((course) => course.$id === id);
        // Check if the course has the property we are looking for
        if (course[property] === value) {
          return;
        }
        try {
          // Create a new instance of the Databases class
          const APP_DATABASE = new Databases(APP_CLIENT);
          // Update the course with the given id
          await APP_DATABASE.updateDocument("user_data", "user_courses", id, {
            [property]: value,
          });
          // Add a snackbar notification
          SNACKBAR.add({
            text: "Updated course! 🎉",
            type: "success",
          });
          // Fetch the courses again
          await getUserCourses();
        } catch (error) {
          console.error(error);
        }
      }
    };

    /**
     * This function deletes the course with the given id.
     * @param {string} id The id of the course to delete
     */
    const deleteCourse = async (id) => {
      try {
        // Create a new instance of the Databases class
        const APP_DATABASE = new Databases(APP_CLIENT);
        // Delete the course with the given id
        await APP_DATABASE.deleteDocument("user_data", "user_courses", id);
        // Add a snackbar notification
        SNACKBAR.add({
          text: "Deleted course! 🎉",
          type: "success",
        });
        // Fetch the courses again
        await getUserCourses();
      } catch (error) {
        console.error(error);
      }
    };

    /**
     * This function exports the courses to a csv file.
     */
    const exportCourses = () => {
      // Create the CSV content
      const csvContent =
        "data:text/csv;charset=utf-8," + encodeURI(generateCsv());
      // Create a link to the CSV file
      const link = document.createElement("a");
      link.setAttribute("href", csvContent);
      link.setAttribute("download", "courses.csv");
      // Add the link to the page, click it, and remove it
      document.body.appendChild(link);
      link.click();
      document.body.removeChild(link);
    };

    /**
     * This function generates a CSV string from the courses.
     */
    const generateCsv = () => {
      // Declare the CSV string
      let csv = "\uFEFFCourse,Credits,Grade\n";
      // Iterate over the courses
      for (const course of data.courses) {
        const name = course.name || ""; // Convert null to empty string
        const credits = course.ects || ""; // Convert null to empty string
        const grade = course.grade || "";
        csv += `${name},${credits},${grade}\n`;
      }
      // Return the CSV string
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
      deleteCourse,
    };
  },
};
</script>
