<template>
    <div class="empty-state-container">
        <img src="../assets/empty-state.svg" alt="empty state illustration">
        <div class="empty-state-message">{{ message }}</div>
    </div>
    
</template>

<script setup>
    import { defineProps } from 'vue';
    const props = defineProps({
    message: {
        type: String,
        required: true
    }
    });
</script>

<style scoped>
    .empty-state-container img{
        width: 200px;
    }
    .empty-state-message{
        color: gray;
    }
</style>