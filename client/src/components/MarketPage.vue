<template>

    <div class="card-component">
        Your current balence is:
        <div class="title">
             {{ balance }} USD_BTC
        </div>
        <div class="button secondary-button buy" @click="openAddMoneyPage">
            Add money to wallet
        </div>

    </div>
        
        


    <div class="card-component">
        <EmptyState v-if="pokemonsInMarket.length===0" message="There is no pokemon for sale" />
        <div v-else class="pokemons">
            <div class="title">
                Pokemons in the market
            </div>
            <div v-for="pokemon in pokemonsInMarket" :key="pokemon.id">
                <div class="pokemon-card"> <!-- todo: extract pokemon card as a component -->
                    <img :src=pokemon.image_path alt="">
                    <div class="pokemon-name">{{ pokemon.name }}</div>
                    <div class="pokemon-price">{{ pokemon.price }} USD_BTC</div>
                    <div class="pokemon-action">
                        <div class="button primary-button" @click="checkoutPokemon(pokemon.id)" >
                            Checkout
                        </div>
                        <div class="button secondary-button" @click="openPokemon(pokemon.id)">
                            See details
                        </div>
                    </div>
                    <div class="checkout-container" v-if="is_checkout.state && is_checkout.pokemon_id===pokemon.id">
                        <div class="checkout-text">
                            Please confirm that you want to purchase this Pokémon for {{ pokemon.price }} USD_BTC
                        </div>
                        <div class="button primary-button buy" @click="buyPokemon(pokemon.id)" >
                            Buy
                        </div>
                    </div>
                </div>
            </div>
        </div>
        
    </div>

    <div class="card-component">
        <EmptyState v-if="myPokemons.length===0" message="You didn't buy any pokemon yet" />
        <div v-else class="pokemons">
            <div class="title">
                My pokemons
            </div>
            <div v-for="pokemon in myPokemons" :key="pokemon.id">
                <div class="pokemon-card">
                    <img :src=pokemon.image_path alt="">
                    <div class="pokemon-name">{{ pokemon.name }}</div>
                    <div class="pokemon-price">{{ pokemon.price }} USD_BTC</div>
                    <div class="pokemon-action">
                        <div class="button primary-button" @click="sellPokemon(pokemon.id)" >
                            sell
                        </div>
                        <div class="button secondary-button">
                            See details
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
</template>

<script setup>
    import EmptyState from './EmptyState.vue';
    import { useRouter } from 'vue-router';

    import { ref, onMounted } from 'vue';
    const API_URL = "http://localhost:3000";

    const pokemonsInMarket = ref([])

    const myPokemons = ref([])

    const is_checkout = ref({})

    const balance = ref(0)

    onMounted(async() => {
        getPokemonsInMarket()
        getMyPokemons()
        getUserBalance()
    })

    const getUserBalance = async() => {
        const user_api = await fetch(`${API_URL}/me`)
        const user_api_json = await user_api.json()
        balance.value = user_api_json.balance
    }

    const getPokemonsInMarket = async() => {
        const pokemons = await fetch(`${API_URL}/market/pokemons`)
        const pokemons_json = await pokemons.json()
        pokemonsInMarket.value = pokemons_json
    }

    const getMyPokemons = async() => {
        const pokemons = await fetch(`${API_URL}/me/pokemons`)
        const pokemons_json = await pokemons.json()
        myPokemons.value = pokemons_json
    }

    const sellPokemon = async(id) => {
        const response = await fetch(`${API_URL}/pokemon/${id}/sell`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        })
        const response_json = await response.json()
        pokemonsInMarket.value.push(response_json.pokemon)
        myPokemons.value = myPokemons.value.filter(pokemon => pokemon.id !== response_json.pokemon.id);
        balance.value = parseFloat(balance.value) + parseFloat(response_json.pokemon.price)
    }

    const checkoutPokemon = async(id) => {
        const response = await fetch(`${API_URL}/pokemon/${id}/checkout`)
        const res_json = await response.json()

        if(res_json.can_buy){
            is_checkout.value = {state: true, pokemon_id: id}
        } else {
            // todo: handle insuffisante balence
        }
    }

    const buyPokemon = async(id) => {
        const response = await fetch(`${API_URL}/pokemon/${id}/buy`, {
            method: 'POST',
            headers: {
                'Content-Type': 'application/json'
            }
        }) 
        const response_json = await response.json()
        myPokemons.value.push(response_json.pokemon)
        pokemonsInMarket.value = pokemonsInMarket.value.filter(pokemon => pokemon.id !== response_json.pokemon.id);
        is_checkout.value.state = false
        balance.value = parseFloat(balance.value) - parseFloat(response_json.pokemon.price)
    }

    const router = useRouter();
    const openAddMoneyPage = () => {
        router.push({name: 'AddMoneyPage'});
    }
    const openPokemon = (id) => {
        router.push({ name: 'Pokemon', params: { id } });
    }

</script>

<style scoped>
    .checkout-container{
        margin-top: 10px;
        max-width: 250px;
    }
    .buy{
        display: block !important;
    }
    .checkout-text{
        margin: 20px 0;
    }
</style>