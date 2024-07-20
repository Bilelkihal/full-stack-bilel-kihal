<template>
    <div class="card-component">
        <EmptyState v-if="!pokemonsInMarket" message="There is no pokemon for sale" />
        <div v-else class="title">
            Pokemons in market
            <div v-for="pokemon in pokemonsInMarket" :key="pokemon.id">
                <div  class="pokemon-card">
                    <img :src=pokemon.image_path alt="">
                    <div class="pokemon-name">{{ pokemon.name }}</div>
                    <div class="actions">
                        <div class="primary-button">
                            Buy
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="card-component">
        <div class="title">
            My pokemons
        </div>
        <EmptyState message="You didn't buy any pokemon yet" />
    </div>
    
</template>

<script setup>
    import EmptyState from './EmptyState.vue';
    import { defineProps } from 'vue';

    import { ref, onMounted } from 'vue';
    const API_URL = "http://localhost:3000";

    const pokemonsInMarket = ref([])

    const myPokemons = ref([])

    onMounted(async() => {
        getPokemonsInMarket()
    })

    const getPokemonsInMarket = async() => {
        const pokemons = await fetch(`${API_URL}/pokemons`)
        const pokemons_json = await pokemons.json()
        pokemonsInMarket.value = pokemons_json
    }



</script>

<style scoped>

</style>