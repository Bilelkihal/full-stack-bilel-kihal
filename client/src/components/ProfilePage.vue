<template>
    <div class="card-component">
        <div class="title">User Profile</div>
        <div class="user-profile-line">
            <div class="first-row">Email</div>
            <div class="second-row">{{ user.email }}</div>
        </div>
        <div class="user-profile-line">
            <div class="first-row">Balence</div>
            <div class="second-row">{{ user.balance }}</div>
        </div>
    </div>
   
    
</template>

<script setup>
    import { ref, onMounted } from 'vue';
    const API_URL = "http://localhost:3000";
    const user = ref({})
    onMounted(async() => {
        const user_api = await fetch(`${API_URL}/me`)
        const user_api_json = await user_api.json()
        user.value = user_api_json
    })
    
</script>

<style scoped>
    
</style>