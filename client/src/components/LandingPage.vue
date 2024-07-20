<template>

    <img class="pokemon-logo" src="../assets/pokemon.svg" alt="pokemon logo" />

    <div class="card-component">
        <div class="title">
            Latest transactions
        </div>
        <EmptyState message="No transaction is done yet" />
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
