<template>
    <div>
        <div class="container flex items-center justify-center min-h-screen px-6 mx-auto">
            <form class="w-full max-w-md">
                <div class="flex justify-center mx-auto">
                    <NuxtLink to="/">
                        <svg xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24" stroke-width="1.5" stroke="currentColor" class="w-12 h-12 text-white">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M4.26 10.147a60.436 60.436 0 00-.491 6.347A48.627 48.627 0 0112 20.904a48.627 48.627 0 018.232-4.41 60.46 60.46 0 00-.491-6.347m-15.482 0a50.57 50.57 0 00-2.658-.813A59.905 59.905 0 0112 3.493a59.902 59.902 0 0110.399 5.84c-.896.248-1.783.52-2.658.814m-15.482 0A50.697 50.697 0 0112 13.489a50.702 50.702 0 017.74-3.342M6.75 15a.75.75 0 100-1.5.75.75 0 000 1.5zm0 0v-3.675A55.378 55.378 0 0112 8.443m-7.007 11.55A5.981 5.981 0 006.75 15.75v-1.5" />
                        </svg>
                    </NuxtLink>
                </div>
                
                <div class="flex items-center justify-center mt-6">
                    <a href="#" class="w-1/3 pb-4 font-medium text-center text-white capitalize border-b-2 border-white">
                        sign in
                    </a>

                    <a @click="() => switchAuthForm()" href="#" class="w-1/3 pb-4 font-medium text-center text-gray-400 capitalize border-b border-gray-400">
                        sign up
                    </a>
                </div>


                <div class="relative flex items-center mt-6">
                    <span class="absolute">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 mx-3 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M3 8l7.89 5.26a2 2 0 002.22 0L21 8M5 19h14a2 2 0 002-2V7a2 2 0 00-2-2H5a2 2 0 00-2 2v10a2 2 0 002 2z" />
                        </svg>
                    </span>

                    <input type="email" class="block w-full py-3 border rounded-lg px-11 bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Email address">
                </div>

                <div class="relative flex items-center mt-4">
                    <span class="absolute">
                        <svg xmlns="http://www.w3.org/2000/svg" class="w-6 h-6 mx-3 text-gray-500" fill="none" viewBox="0 0 24 24" stroke="currentColor" stroke-width="2">
                            <path stroke-linecap="round" stroke-linejoin="round" d="M12 15v2m-6 4h12a2 2 0 002-2v-6a2 2 0 00-2-2H6a2 2 0 00-2 2v6a2 2 0 002 2zm10-10V7a4 4 0 00-8 0v4h8z" />
                        </svg>
                    </span>

                    <input type="password" class="block w-full px-11 py-3 border rounded-lg bg-transparent text-gray-300 border-gray-600 focus:border-fom focus:border-fom focus:ring-fom focus:outline-none focus:ring focus:ring-opacity-40" placeholder="Password">
                </div>


                <div class="mt-6">
                    <button class="w-full px-6 py-3 text-sm font-medium tracking-wide text-white capitalize transition-colors duration-300 transform bg-fom rounded-lg hover:opacity-80 hover:transition hover:ease-out-in hover:duration-250 focus:outline-none focus:ring focus:ring-blue-300 focus:ring-opacity-50">
                        Sign In
                    </button>
                </div>

                <div class="mt-4 text-center ">
                    <a @click="() => switchAuthForm()" href="#" class="text-sm text-gray-500 hover:underline ">
                        Do not have an account?
                    </a>
                </div>
            </form>
        </div>
    </div>
</template>

<script setup>
    const switchAuthPage = useState('toggleAuthPage')

    function switchAuthForm() {
        switchAuthPage.value = !switchAuthPage.value
    }
</script>