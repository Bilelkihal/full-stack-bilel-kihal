<template>

    <img class="pokemon-logo" src="../assets/pokemon.svg" alt="pokemon logo" />

    <div class="card-component">
        <div class="title">
            My last transactions
        </div>
        <EmptyState v-if="transactions.length===0" message="No transaction is done yet" />
        <div v-else class="div">
            <div v-for="transaction in transactions.slice(0, 3)" :key="transaction.id">
                <div class="info-line">
                    <div class="first-row">Action</div>
                    <div class="second-row">{{ transaction.action }}</div>
                </div>
                <div class="info-line">
                    <div class="first-row">Pokemon id</div>
                    <div class="second-row">{{ transaction.pokemon_id }}</div>
                </div>
            </div>
        </div>
    </div>
    <div class="landing-call-to-actions">
        <div class="button primary-button" @click="openMarketPage">
            Enter to the market
        </div>
        <div class="button secondary-button" @click="openAllPokemons">
            Discover all pokemons
        </div>
    </div>

</template>


<script setup>
    import EmptyState from './EmptyState.vue';
    import { useRouter } from 'vue-router';

    import { ref, onMounted } from 'vue';
    const API_URL = "http://localhost:3000";

    const transactions = ref([])

    onMounted(async() => {
        const transaction_api = await fetch(`${API_URL}/me/transactions`)
        const transaction_api_json = await transaction_api.json()
        transactions.value = transaction_api_json  
    })

    const router = useRouter();
    const openMarketPage = () => {
        router.push({name: 'Market'});
    }
    const openAllPokemons = () => {
        router.push({name: 'AllPokemons'});
    }
</script>

<style scoped>
    .pokemon-logo{
        width: 500px;
    }
    .landing-call-to-actions{
        display: flex;
        justify-content: center;
    }
    .landing-call-to-actions div+div{
        margin-left: 20px;
    }
</style>
