<template>
    <div class="card-component">
        <div class="title">Add money to wallet</div>
        Your current balence is:
        <div class="title">
             {{ balance }} USD_BTC
        </div>
        <div class="inputs">
            <input v-model="balanceInput" type="number" placeholder="balance to add">
            <div class="button primary-button block" @click="addBalance">
                Add Balance to wallet
            </div>
        </div>
    </div>
    
</template>

<script setup>

    import { ref, onMounted } from 'vue';
    const API_URL = "http://localhost:3000";
    const balance = ref(0)
    const balanceInput = ref(0)

    onMounted(async() => {
        const user_api = await fetch(`${API_URL}/me`)
        const user_api_json = await user_api.json()
        balance.value = user_api_json.balance
    })

    const addBalance = async() => {
        const res = await fetch(`${API_URL}/me/add?balance=${balanceInput.value}`, {
            method: 'PATCH',
            headers: {
                'Content-Type': 'application/json'
            },
        })
        const user = await res.json()
        
        balanceInput.value = 0
        balance.value = user.balance
    }

</script>

<style scoped>
    .block{
        display: block;
    }
    .inputs input{
        font-size: 16px;
        padding: 15px 20px;
        border-radius: 8px;
        outline: none;
        border: 1px solid var(--light-gray);
        display: block;
        margin-bottom: 20px;
    }
</style>