<template>
    <div class="card-component">
        <EmptyState v-if="!allPokemons" message="There is no pokemon for sale" />
        <div v-else class="pokemons">
            <div class="title">
                All pokemons
            </div>
            <div v-for="pokemon in allPokemons" :key="pokemon.id">
                <PokemonCard :name=pokemon.name :image_path=pokemon.image_path :price="pokemon.price" />
            </div>
        </div>
    </div>
    <div class="button primary-button">
        Create new pokemon
    </div>
    
</template>

<script setup>
    import PokemonCard from './PokemonCard.vue';
    import EmptyState from './EmptyState.vue';
    import { ref, onMounted } from 'vue';


    const API_URL = "http://localhost:3000";

    const allPokemons = ref([])

    onMounted(async() => {
        getPokemonsInMarket()
    })

    const getPokemonsInMarket = async() => {
        const pokemons = await fetch(`${API_URL}/pokemons`)
        const pokemons_json = await pokemons.json()
        allPokemons.value = pokemons_json
    }



</script>

<style scoped>
    .pokemon-name{
        font-size: 16px;
        font-weight: 400;
    }
</style>