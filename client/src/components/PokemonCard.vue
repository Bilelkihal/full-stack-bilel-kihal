<template>
    <div  class="pokemon-card">
        <img :src=image_path alt="">
        <div class="pokemon-name">{{ name }}</div>
        <div class="pokemon-price">{{ price }} USD_BTC</div>
        <div class="pokemon-action">
            <div v-if=sell class="button primary-button">
                Sell
            </div>
            <div v-if=buy class="button primary-button">
                Buy
            </div>
            <div class="button secondary-button">
                See details
            </div>
        </div>
    </div>
</template>

<script setup>
    import { defineProps } from 'vue';
    const props = defineProps({
        name: {
            type: String,
            required: true
        },
        image_path: {
            type: String,
            required: true
        },
        price: {
            type: String,
            required: true
        }
    });
    


</script>

<style scoped>
    .pokemon-card{
        border: 1px solid var(--light-gray);
        width: 300px;
        display: flex;
        justify-content: center;
        align-items: center;
        flex-direction: column;
        border-radius: 8px;
        padding: 20px 0;
    }
    .pokemon-card img{
        max-width: 200px;
        max-height: 200px;
    }
    .pokemon-name{
        font-size: 20px;
        font-weight: 500;
    }
    .pokemon-price{
        color: gray;
    }
    .pokemon-action{
        display: flex;
        justify-content: center;
    }
    .pokemon-action div{
        margin-top: 10px;
    }
    .pokemon-action div+div{
        margin-left: 10px;
    }

</style>