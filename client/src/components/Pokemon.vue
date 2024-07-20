<template>
    <div class="card-component">
        <div class="title">Pokemon Profile</div>
        <img :src=pokemon.image_path class="profile_image">
        <div class="info-line">
            <div class="first-row">Name:</div>
            <div class="second-row">{{ pokemon.name }}</div>
        </div>
        <div class="info-line">
            <div class="first-row">Price:</div>
            <div class="second-row">{{ pokemon.price }}</div>
        </div>
        <div class="info-line">
            <div class="first-row">Weight:</div>
            <div class="second-row">{{ pokemon.weight }}</div>
        </div>
        <div class="info-line">
            <div class="first-row">Height:</div>
            <div class="second-row">{{ pokemon.height }}</div>
        </div>
    </div>
    
</template>

<script setup>
    import { defineProps, ref, onMounted  } from 'vue';
    const props = defineProps({
        id: {
            type: String,
            required: true
        }
    });
    const { id } = props;
    const API_URL = "http://localhost:3000";
    const pokemon = ref({})
    onMounted(async() => {
        const pokemon_api = await fetch(`${API_URL}/pokemons/${id}`)
        const pokemon_api_json = await pokemon_api.json()
        pokemon.value = pokemon_api_json
    })
    
</script>

<style scoped>

</style>