<template>
    <div>
        <div class="h-full bg-dark">
            <Login v-if="switchAuthPage" />
            <Register v-if="!switchAuthPage" />
        </div>
    </div>
</template>

<script setup>
    const switchAuthPage = useState('toggleAuthPage', () => true)
</script>